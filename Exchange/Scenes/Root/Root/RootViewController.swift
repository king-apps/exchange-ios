import UIKit


protocol RootDisplayLogic: AnyObject {
    func onLoad(viewModel: Root.Load.ViewModel)
    func onControllers(viewModel: Root.Controllers.ViewModel)
}


class RootViewController: UITabBarController, RootDisplayLogic {
  
    
    // Var's
    var interactor: RootBusinessLogic?
    var router: (NSObjectProtocol & RootRoutingLogic & RootDataPassing)?
    
    private var chatTabIndex: Int?
    private var isRefreshingNotificationBadge = false
    override var childForStatusBarStyle: UIViewController? {
        return selectedViewController
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
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
        setupObservers()
        load()
    }
  
    
    // Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnalytics()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    // Setup inputs
    func setupInputs() {
        
    }
    
    func setupObservers() {
        
    }
    
    
    // Setup analytics
    func setupAnalytics() {
    
    }
    
    
    // Handler load
    func load() {
        let request = Root.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: Root.Load.ViewModel) {
        controllers()
        setChatBadgeValue(value: viewModel.messagesNotViewed)
    }
    private func setChatBadgeValue(value: Int) {
        if let item = tabBar.items?.filter({$0.tag == 2}).first {
            item.badgeValue = value > 0 ? "\(value)" : nil
        }
    }
    
    
    // Controllers
    func controllers() {
        let request = Root.Controllers.Request()
        interactor?.controllers(request: request)
    }
    func onControllers(viewModel: Root.Controllers.ViewModel) {
        
        var array = [UIViewController]()
        for c in viewModel.list {
            
            if let controller = UIStoryboard(name: c.storyboard, bundle: nil).instantiateInitialViewController() {
                controller.tabBarItem = UITabBarItem(
                    title: "", // c.title,
                    image: AppTheme.icon(c.icon).withRenderingMode(.alwaysTemplate),
                    selectedImage: AppTheme.icon(c.icon).withRenderingMode(.alwaysTemplate)
                )
                array.append(controller)
            }

        }
        
        viewControllers = array
        setNeedsStatusBarAppearanceUpdate()
    }
   
}
