import UIKit
import Kingfisher
import IQKeyboardManagerSwift
import IQKeyboardToolbarManager


protocol ChatMessageDisplayLogic: AnyObject {
    func onLoad(viewModel: ChatMessage.Load.ViewModel)
    func onFetch(viewModel: ChatMessage.Fetch.ViewModel)
    func onSend(viewModel: ChatMessage.Send.ViewModel)
}


class ChatMessageViewController: MainBaseViewController, ChatMessageDisplayLogic {
  
    
    // Var's
    var interactor: ChatMessageBusinessLogic?
    var router: (NSObjectProtocol & ChatMessageRoutingLogic & ChatMessageDataPassing)?
    
    @IBOutlet var imageViewAvatar: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelDistance: UILabel!
    @IBOutlet var textViewMessage: UITextView!
    @IBOutlet var buttonSend: UIButtonBase!
    @IBOutlet var constraintToSafeAreaBottom: NSLayoutConstraint!
    @IBOutlet var viewMessage: UIView!
    var timer: Timer?
    private var loopTime: Int = 20
    private var chatId: Int = 0
    private var messagePlaceholder: String {
        "Chat.Message.Placeholder".localized
    }

  
    // Constructor
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
  
    // Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputs()
        load()
    }
  
    
    // Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnalytics()
        
        if status == .ready {
            timer?.invalidate()
            loop()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Chat.Message.Title".localized
        IQKeyboardManager.shared.isEnabled = false
        IQKeyboardToolbarManager.shared.isEnabled = false
    }
    
    
    // Disappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate( )
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardToolbarManager.shared.isEnabled = true
        dismissKeyboard()
    }
    
    
    // Setup inputs
    func setupInputs() {
        registerTableView()
        applyTableViewInsetsLg()
        
        imageViewAvatar.layer.cornerRadius = imageViewAvatar.bounds.width / 2
        imageViewAvatar.layer.borderWidth = 1
        imageViewAvatar.layer.borderColor = UIColor.white.cgColor
        
        textViewMessage.delegate = self
        textViewMessage.returnKeyType = .send
        textViewMessage.enablesReturnKeyAutomatically = true
        setTextViewMessagePlaceholder()
        addTapToDismissKeyboard()
       
        
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(animationToHideKeyboard),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = ChatMessage.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: ChatMessage.Load.ViewModel) {
        
        chatId = viewModel.chatId
        loopTime = viewModel.loopTime
        
        if viewModel.avatarUrl.isEmpty {
            imageViewAvatar.image = AppTheme.icon(.user)
            imageViewAvatar.contentMode = .center
        }
        else {
            imageViewAvatar.kf.setImage(with: URL(string: viewModel.avatarUrl)!)
            imageViewAvatar.contentMode = .scaleAspectFill
        }
        
        labelName.text = viewModel.name
        labelDistance.text = viewModel.distante
        fetch()
        
    }
    
    
    // Handler loop
    func loop() {
        let interval = TimeInterval(loopTime)
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: { (timer) in
            self.fetch()
        })
    }
    
    
    // Handler fetch
    func fetch() {
        let request = ChatMessage.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: ChatMessage.Fetch.ViewModel) {
        
        if rows.count == 0 {
            rows = viewModel.rows
            tableView?.reloadData()
            scrollToLastMessage(animated: false)
        }
        else {
            onFetchNew(newRows: viewModel.rows)
        }
        
        loop()
    }
    private func onFetchNew(newRows: [MainTableRow]) {
       // let lastIndex = rows.count
        for row in newRows {
            rows.append(row)
        }
        
        // Check if is end of scroll
        let height = tableView!.frame.size.height
        let contentOffset = tableView!.contentOffset.y
        let distanceFromBottom = tableView!.contentSize.height - contentOffset
        tableView?.reloadData()
        if (distanceFromBottom * 0.7) <= height {
            scrollToLastMessage(animated: true)
        }
    }
    
    
    // Handler keyboard
    @objc
    func keyboardWillShow(_ notification: Notification) {
        
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            animationToShowKeyboard(height: keyboardHeight)
        }
    }
    func animationToShowKeyboard(height: CGFloat) {
        constraintToSafeAreaBottom.constant = height - 24
        UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0) {
            self.view.layoutIfNeeded()
            self.scrollToLastMessage(animated: false)
        }
    }
    @objc
    func animationToHideKeyboard() {
        constraintToSafeAreaBottom.constant = 24
        UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0) {
            self.view.layoutIfNeeded()
        }
    }
    
    
    func setTextViewMessagePlaceholder() {
        if textViewMessage.text.isEmpty {
            textViewMessage.text = messagePlaceholder
            textViewMessage.textColor = AppTheme.Colors.textOnSurfaceSecondary
        }
        handlerButtonSend()
    }
    func setTextViewMessageEnter() {
        if textViewMessage.text == messagePlaceholder {
            textViewMessage.text = ""
        }
        textViewMessage.textColor = AppTheme.Colors.textOnSurface
        handlerButtonSend()
    }
    
    
    // Handler send
    func send() {
        if let text = textViewMessage.text, text.isEmpty == false {
            timer?.invalidate()
            sendShowLoading()
            let request = ChatMessage.Send.Request(text: text)
            interactor?.send(request: request)
        }
    }
    func onSend(viewModel: ChatMessage.Send.ViewModel) {
        rows.append(viewModel.row)
        tableView?.reloadData()
        textViewMessage.text = ""
        scrollToLastMessage(animated: true)
        sendHideLoading()
        handlerButtonSend()
        fetch()
    }
    private func sendShowLoading() {
        textViewMessage.alpha = 0.5
        buttonSend.isEnabled = false
    }
    private func sendHideLoading() {
        textViewMessage.alpha = 1
        buttonSend.isEnabled = true
    }
    
    
    // Handler button save
    func handlerButtonSend() {
        if let text = textViewMessage.text {
            if text.isEmpty || text == messagePlaceholder {
                buttonSend.isEnabled = false
            }
            else {
                buttonSend.isEnabled = true
            }
        }
    }
    
    
    // Scroll messages
    func scrollToLastMessage(animated: Bool) {
        guard let tableView, tableView.numberOfSections > 0 else { return }
        
        let rowCount = tableView.numberOfRows(inSection: 0)
        guard rowCount > 0 else { return }
        
        let indexPath = IndexPath(row: rowCount - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
    func scrollToMessage(row: Int, animated: Bool) {
        guard let tableView, tableView.numberOfSections > 0 else { return }
        
        let rowCount = tableView.numberOfRows(inSection: 0)
        guard row >= 0, row < rowCount else { return }
        
        let indexPath = IndexPath(row: row, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: animated)
    }
    
    
    // Handler denunciate
    func confirmDenunciate() {
        confirmDenunciate(chatId: self.chatId) { confirm in
            if confirm {
                self.router?.routeToDenunciateSuccess()
            }
        }
    }
    func onDenunciateSuccess() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    // Handler actions
    @IBAction func didDenunciate() {
        AppHaptics.tap()
        router?.routeToDenunciate()
    }
    @IBAction func didProducts() {
        performSegue(withIdentifier: "Products", sender: nil)
    }
    @IBAction func didSend() {
        send()
    }
    
    
}
