import UIKit
import StoreKit


protocol RootDisplayLogic: AnyObject {
    func onLoad(viewModel: Root.Load.ViewModel)
    func onControllers(viewModel: Root.Controllers.ViewModel)
    func onFcmToken(viewModel: Root.FcmToken.ViewModel)
    func onFcmToken(error: String)
    func onUserProfile(viewModel: Root.UserProfile.ViewModel)
    func onUserProfile(error: String)
    func onAppStoreView(viewModel: Root.AppStoreReview.ViewModel)
}


class RootViewController: UITabBarController, RootDisplayLogic {
  
    
    // Var's
    var interactor: RootBusinessLogic?
    var router: (NSObjectProtocol & RootRoutingLogic & RootDataPassing)?
    
    private var chatTabIndex: Int?
    private var isRefreshingNotificationBadge = false
    private var hasCheckedAppStoreReview = false
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
        appStoreReviewIfNeeded()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    
    // Setup inputs
    func setupInputs() {
        
    }
    func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(fcmToken), name: .updateFcmToken, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(userProfile), name: .reloadChatListBadge, object: nil)
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
    func setChatBadgeValue(value: Int) {
        let item = tabBar.items?[2]
        item?.badgeValue = value > 0 ? "\(value)" : nil
    }
    func addChatBadgeValue() {
        let item = tabBar.items?[2]
        if let badgeValue = item?.badgeValue, let value = Int(badgeValue) {
            item?.badgeValue = "\(value + 1)"
        } else {
            item?.badgeValue = "1"
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
                    selectedImage: AppTheme.icon(c.icon).withRenderingMode(.alwaysTemplate),
                )
                array.append(controller)
            }

        }
        
        viewControllers = array
        setNeedsStatusBarAppearanceUpdate()
    }
   
    
    // Handler fcm token
    @objc
    func fcmToken() {
        let request = Root.FcmToken.Request()
        interactor?.fcmToken(request: request)
    }
    func onFcmToken(viewModel: Root.FcmToken.ViewModel) {
        
    }
    func onFcmToken(error: String) {
        
    }
    
    
    // Handler user profile
    @objc
    func userProfile() {
        let request = Root.UserProfile.Request()
        interactor?.userProfile(request: request)
    }
    func onUserProfile(viewModel: Root.UserProfile.ViewModel) {
        setChatBadgeValue(value: viewModel.messagesNotViewed)
    }
    func onUserProfile(error: String) {
        
    }
    
    
    // Handler appstore review
    func appStoreReviewIfNeeded() {
        guard hasCheckedAppStoreReview == false else {
            return
        }
        
        hasCheckedAppStoreReview = true
        appStoreReview()
    }
    func appStoreReview() {
        let request = Root.AppStoreReview.Request()
        interactor?.appStoreReview(request: request)
    }
    func onAppStoreView(viewModel: Root.AppStoreReview.ViewModel) {
        guard viewModel.shouldRequestReview else {
            return
        }
        
        showAppStoreReview()
    }
    func showAppStoreReview() {
        guard let windowScene = view.window?.windowScene ?? UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        
        SKStoreReviewController.requestReview(in: windowScene)
    }
    
    
}
