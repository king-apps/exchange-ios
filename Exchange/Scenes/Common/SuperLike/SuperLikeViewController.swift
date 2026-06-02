import UIKit


protocol SuperLikeDisplayLogic: AnyObject {
    func onLoad(viewModel: SuperLike.Load.ViewModel)
    func onFetch(viewModel: SuperLike.Fetch.ViewModel)
    func onSend(viewModel: SuperLike.Send.ViewModel)
    func onSend(error: String)
}


protocol SuperLikeDelegate: AnyObject {
    func superLikeSendSuccess()
    func superLikeDidClose()
}

class SuperLikeViewController: MainBaseViewController, SuperLikeDisplayLogic {
  
    
    // Var's
    var interactor: SuperLikeBusinessLogic?
    var router: (NSObjectProtocol & SuperLikeRoutingLogic & SuperLikeDataPassing)?

    @IBOutlet var buttonSend: UIButtonBase!
    var delegate: SuperLikeDelegate?
  
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // Setup inputs
    func setupInputs() {
        registerTableView()
        applyTableViewInsetsLg()
        addTapToDismissKeyboard()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = SuperLike.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: SuperLike.Load.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        buttonSend.showLoading()
        fetch()
    }
    
    
    // Handler fetch
    func fetch() {
        let request = SuperLike.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: SuperLike.Fetch.ViewModel) {
        buttonSend.setTitle(viewModel.title, for: .normal)
        buttonSend.setTitle(viewModel.title, for: .disabled)
        buttonSend.hideLoading()
    }
    
    
    // Handler send
    func send() {
        AppHaptics.tap()
        buttonSend.showLoading(text: "App.Sending".localized)
        let message = rows.inputTextViewValue(identifier: .SuperLike)
        let request = SuperLike.Send.Request(message: message)
        interactor?.send(request: request)
    }
    func onSend(viewModel: SuperLike.Send.ViewModel) {
        AppHaptics.success()
        dismiss(animated: true) {
            self.delegate?.superLikeSendSuccess()
        }
    }
    func onSend(error: String) {
        buttonSend.hideLoading()
        displayAlert(nil, message: error)
    }
    
    
    // Handler button send
    func handerButtonSend() {
        let text = rows.inputTextViewValue(identifier: .SuperLike)
        buttonSend.isEnabled = !text.isEmpty
    }
    
    
    // Handler actions
    @IBAction func didClose() {
        dismiss(animated: true) {
            self.delegate?.superLikeDidClose()
        }
    }
    @IBAction func didSend() {
        send()
    }
    @IBAction func didMore() {
        performSegue(withIdentifier: "KnowMore", sender: nil)
    }
    
    
    // Hooks
    override func configureCell(_ cell: UITableViewCell, for row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .inputTextView:
            (cell as? InputTextViewCell)?.delegate = self
            break
        default:
            break
        }
    }
    
    
}
