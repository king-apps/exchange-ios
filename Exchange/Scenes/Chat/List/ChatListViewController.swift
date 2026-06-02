import UIKit


protocol ChatListDisplayLogic: AnyObject {
    func onLoad(viewModel: ChatList.Load.ViewModel)
    func onFetch(viewModel: ChatList.Fetch.ViewModel)
    func onFetch(error: String)
    func onSave(viewModel: ChatList.Save.ViewModel)
    func onDelete(viewModel: ChatList.Delete.ViewModel)
    func onDelete(error: String)
}


class ChatListViewController: MainBaseViewController, ChatListDisplayLogic {
  
    
    // Var's
    var interactor: ChatListBusinessLogic?
    var router: (NSObjectProtocol & ChatListRoutingLogic & ChatListDataPassing)?
    
    private let refreshControlView = UIRefreshControl()

  
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
        setupNotifications()
        load()
    }
  
    
    // Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnalytics()
        
        if status == .ready {
            fetch()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Chat.List.Title".localized
    }
    
    
    // Setup inputs
    func setupInputs() {
        status = .loading
        registerTableView()
        applyTableViewInsetsLg()
        refreshControlView.tintColor = AppTheme.Colors.brandPrimary500
        refreshControlView.addTarget(self, action: #selector(fetch), for: .valueChanged)
        tableView?.insertSubview(refreshControlView, at: 0)
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Setup notifications
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(fetch), name: .reloadChatList, object: nil)
    }
    
    
    // Handler load
    func load() {
        let height: CGFloat = tableView?.bounds.height ?? self.view.bounds.height
        let request = ChatList.Load.Request(height: height)
        interactor?.load(request: request)
    }
    func onLoad(viewModel: ChatList.Load.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        fetch()
    }
    
    
    // Handler fetch
    @objc
    func fetch() {
        let request = ChatList.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: ChatList.Fetch.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        refreshControlView.endRefreshing()
        status = .ready
        setChatBadgeValue(value: viewModel.unreadCount)
    }
    func onFetch(error: String) {
        refreshControlView.endRefreshing()
        status = .ready
    }
    
    
    // Handler save
    func save(chatId: Int) {
        let request = ChatList.Save.Request(chatId: chatId)
        interactor?.save(request: request)
    }
    func onSave(viewModel: ChatList.Save.ViewModel) {
        performSegue(withIdentifier: "ChatMessage", sender: nil)
    }
    
    
    // Handler delete
    func delete(chatId: Int) {
        let request = ChatList.Delete.Request(chatId: chatId)
        interactor?.delete(request: request)
    }
    func onDelete(viewModel: ChatList.Delete.ViewModel) {
        
    }
    func onDelete(error: String) {
        
    }
    
    
    // Hooks
    override func didSelect(row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .chatList(let model):
            save(chatId: model.id)
        default:
            break
        }
    }
    
    override func canSwipe(row: MainTableRow, at indexPath: IndexPath) -> Bool {
        if case .chatList = row {
            return true
        }
        
        return false
    }
    
    override func trailingSwipeActions(for row: MainTableRow, at indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard case .chatList(let model) = row else {
            return nil
        }
        
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, completion in
            guard let self else {
                completion(false)
                return
            }
            
            self.rows.remove(at: indexPath.row)
            self.tableView?.deleteRows(at: [indexPath], with: .automatic)
            self.delete(chatId: model.id)
            completion(true)
        }
        
        deleteAction.image = AppTheme.icon(.trash)
        deleteAction.backgroundColor = AppTheme.Colors.error500
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    
}
