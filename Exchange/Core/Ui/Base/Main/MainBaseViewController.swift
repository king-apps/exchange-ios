import UIKit


class MainBaseViewController: UIViewController {
    
    
    // Var's
    @IBOutlet private(set) weak var tableView: UITableView?
    @IBOutlet private(set) weak var adBannerView: AdBannerView?
    
    var status: MainBaseStatus = .ready
    var rows: [MainTableRow] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // Load
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonDisplayMode = .minimal
        navigationItem.backButtonTitle = ""
    }
    
    // Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    // Handler Keyboard
    func addTapToDismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    // Register
    func registerTableView() {
        guard let tableView else { return }
        
        tableView.register(LoadingCell.self)
        tableView.register(EmptyCell.self)
        
        tableView.register(InputTextCell.self)
        tableView.register(InputTextViewCell.self)
        tableView.register(InputTokenCell.self)
        tableView.register(InputSelectCell.self)
        tableView.register(InputSliderCell.self)
        
        tableView.register(TextHeadingLgCell.self)
        tableView.register(TextHeadingMdCell.self)
        tableView.register(TextBodyCell.self)
        tableView.register(TextBodySmallCell.self)
        tableView.register(TextCaptionCell.self)
        tableView.register(TextCaptionSemiboldCell.self)

        tableView.register(TagCell.self)
        tableView.register(SpacingCell.self)
        tableView.register(DefaultCell.self)
        tableView.register(AdBannerCell.self)
        tableView.register(SwitchCell.self)
        
        // Premium
        tableView.register(CtaCreativeUrlCell.self)
        tableView.register(CtaLottieFileCell.self)
        
        // Product
        tableView.register(ProductCell.self)
        tableView.register(ProductProgressCell.self)
        tableView.register(ProductCategoryCell.self)
        tableView.register(MyProductCell.self)
        
        // Chat
        tableView.register(ChatListCell.self)
        tableView.register(ChatMessageAppCell.self)
        tableView.register(ChatMessageMeCell.self)
        tableView.register(ChatMessageHeCell.self)
        
        // Profile
        tableView.register(ProfileUserCell.self)
        
        // Stickers
        tableView.register(StickerListCell.self)
        tableView.register(StickerCategoryListCell.self)
    
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
    }
    
    
    // Denunciate
    func confirmDenunciate(productId: Int, completion: @escaping(_ confirm: Bool) -> ()) {
        confirmDenunciate(area: "product", id: productId, completion: completion)
    }
    func confirmDenunciate(chatId: Int, completion: @escaping(_ confirm: Bool) -> ()) {
        confirmDenunciate(area: "chat", id: chatId, completion: completion)
    }
    private func confirmDenunciate(area: String, id: Int, completion: @escaping(_ confirm: Bool) -> ()) {
        
        let alert = UIAlertController(
            title: "Denunciate.Title".localized,
            message: "Denunciate.Message".localized,
            preferredStyle: .actionSheet
        )
        
        let actionBlock = UIAlertAction(title: "Denunciate.Option.Block".localized, style: .destructive) { _ in
            self.denunciate(area: area, id: id, reason: .block)
            completion(true)
        }
        alert.addAction(actionBlock)

        let actionImage = UIAlertAction(title: "Denunciate.Option.Image".localized, style: .default) { _ in
            self.denunciate(area: area, id: id, reason: .image)
            completion(true)
        }
        alert.addAction(actionImage)
        
        let actionSpam = UIAlertAction(title: "Denunciate.Option.Spam".localized, style: .default) { _ in
            self.denunciate(area: area, id: id, reason: .spam)
            completion(true)
        }
        alert.addAction(actionSpam)
        
        let actionOther = UIAlertAction(title: "Denunciate.Option.Other".localized, style: .default) { _ in
            self.denunciate(area: area, id: id, reason: .other)
            completion(true)
        }
        alert.addAction(actionOther)
        
        let actionClose = UIAlertAction(title: "App.Close".localized, style: .cancel) { _ in
            completion(false)
        }
        alert.addAction(actionClose)
        
        present(alert, animated: true)
    }
    private func denunciate(area: String, id: Int, reason: DenunciateReason) {
        
        if area == "product" {
            let api = ProductApi()
            let request = ProductDenunciateRequestDTO(productId: id, reason: reason.rawValue)
            api.denunciate(request: request) { error in
            }
        }
        if area == "chat" {
            let api = MatchApi()
            let request = MatchChatDenunciateRequestDTO(chatId: id, reason: reason.rawValue)
            api.chatDenunciate(request: request) { error in
                
            }
        }
        
    }
    
    
    // HOOKS
    func didSelect(row: MainTableRow, at indexPath: IndexPath) {
    }
    func didDeselect(row: MainTableRow, at indexPath: IndexPath) {
    }
    func shouldDelaySelectionEvents() -> Bool {
        return true
    }
    func configureCell(_ cell: UITableViewCell, for row: MainTableRow, at indexPath: IndexPath) {
    }
    func canEdit(row: MainTableRow, at indexPath: IndexPath) -> Bool {
        return canSwipe(row: row, at: indexPath)
    }
    func editingStyle(row: MainTableRow, at indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func canSwipe(row: MainTableRow, at indexPath: IndexPath) -> Bool {
        return false
    }
    func trailingSwipeActions(for row: MainTableRow, at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return nil
    }

    
}
