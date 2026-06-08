import UIKit
import CoreLocation
import ZLSwipeableViewSwift
import GoogleMobileAds


protocol MatchMakerDisplayLogic: AnyObject {
    func onLoad(viewModel: MatchMaker.Load.ViewModel)
    func onLoadError(error: String)
    func onLocation(viewModel: MatchMaker.Location.ViewModel)
    func onLocationError(error: String)
    func onNotification(viewModel: MatchMaker.Notification.ViewModel)
    func onTracking(viewModel: MatchMaker.Tracking.ViewModel)
    func onSearch(viewModel: MatchMaker.Search.ViewModel)
    func onSearchError(error: String, generation: Int)
    func onDetail(viewModel: MatchMaker.Detail.ViewModel)
    func onIntention(viewModel: MatchMaker.Intention.ViewModel)
    func onIntentionError(error: String)
    func onCountMyProducts(viewModel: MatchMaker.CountMyProducts.ViewModel)
    func onAd(viewModel: MatchMaker.Ad.ViewModel)
    func onSuperLike(viewModel: MatchMaker.SuperLike.ViewModel)
    func onBoostProfile(viewModel: MatchMaker.BoostProfile.ViewModel)
    func onBoostProfile(error: String)
    func onBoostProfileStatus(viewModel: MatchMaker.BoostProfileStatus.ViewModel)
}


class MatchMakerViewController: MainBaseViewController, MatchMakerDisplayLogic {
  
    
    // Var's
    var interactor: MatchMakerBusinessLogic?
    var router: (NSObjectProtocol & MatchMakerRoutingLogic & MatchMakerDataPassing)?
    
    @IBOutlet var imageViewCircle: UIImageView!
    @IBOutlet var constraintFullHeightCircle: NSLayoutConstraint!
    @IBOutlet var viewSwipeable: ZLSwipeableView!
    @IBOutlet var viewButtons: UIView!
    @IBOutlet var viewLoading: UIView!
    @IBOutlet var viewLoading0: UIView!
    @IBOutlet var viewLoading1: UIView!
    @IBOutlet var viewLoading2: UIView!
    @IBOutlet var viewEmpty: UIView!
    @IBOutlet var buttonBoost: UIButtonBase!
    @IBOutlet var viewFilterBadge: UIView!
    
    @IBOutlet var buttonAds: UIButtonBase!
    @IBOutlet var constraintMatchButtonsTop: NSLayoutConstraint!
    @IBOutlet var constraintMatchButtonsBottom: NSLayoutConstraint!
    
    let locationManager = CLLocationManager()
    var locationHasSended = false
    var cards = [CardModel]()
    var cardIndex = 0
    var page: Int = 0
    var myProducts: Int = 0
    var hasShowingAlertNeedsLocation: Bool = false
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    private var interstitial: RewardedInterstitialAd?
    private var isFirstLoad: Bool = true
    private var loadingAnimationGeneration: Int = 0
    private var searchGeneration: Int = 0
    
  
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
        setupAd()
        load()
        ad()
    }
  
    
    // Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        countMyProducts()
        setupAnalytics()
        boostProfileStatus()
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        viewFilterBadge.isHidden = !LocalConfig.shared.filterIsActive()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    // Setup inputs
    func setupInputs() {

        imageViewCircle.tintColor = .secondaryLabel
        viewButtons.alpha = 0.0
        viewLoading0.layer.cornerRadius = viewLoading0.bounds.width * 0.5
        viewLoading1.layer.cornerRadius = viewLoading1.bounds.width * 0.5
        viewLoading2.layer.cornerRadius = viewLoading2.bounds.width * 0.5
        viewLoading1.alpha = 0.3
        viewLoading2.alpha = 0.15
        viewEmpty.alpha = 0
        viewFilterBadge.isHidden = true
        
        constraintFullHeightCircle.isActive = false
        view.layoutIfNeeded()
        
        viewSwipeable.allowedDirection = .Horizontal
        viewSwipeable.animateView = {(view: UIView, index: Int, views: [UIView], swipeableView: ZLSwipeableView) in
            let degree = CGFloat(sin(0.5*Double(index)))
            let offset = CGPoint(x: 0, y: swipeableView.bounds.height)
            let translation = CGPoint(x: 0, y: CGFloat(index*4))
            let duration = 0.4
            self.rotateAndTranslateView(view, forDegree: degree, translation: translation, duration: duration, offsetFromCenter: offset, swipeableView: swipeableView)
        }
        setupViewSwipeable()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Setup notifications
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: .reloadMatchMaker, object: nil)
    }
    
    
    // Setup ad
    func setupAd() {
        if hasAd() {
            adBannerView?.load(.matchMakerBanner, viewController: self)
            constraintMatchButtonsTop.constant = 16
            constraintMatchButtonsBottom.constant = 16
        }
        else {
            constraintMatchButtonsTop.constant = 64
            constraintMatchButtonsBottom.constant = 64
        }
        self.view.layoutIfNeeded()
    }
    
    
    // Handler load
    func load() {
        let request = MatchMaker.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: MatchMaker.Load.ViewModel) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        showLoading {}
    }
    func onLoadError(error: String) {
        displayAlert(nil, message: error)
    }
    
    
    // Handler loading
    func showLoading(completion: @escaping() -> ()) {
        loadingAnimationGeneration += 1
        let generation = loadingAnimationGeneration

        if status != .loading {
            status = .loading
            UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0.0, options: .curveEaseInOut) {
                self.adBannerView?.superview?.alpha = 0.0
                self.viewSwipeable.alpha = 0.0
                self.viewButtons.alpha = 0.0
                self.viewLoading.alpha = 1.0
            } completion: { (finished) in
                guard finished, self.loadingAnimationGeneration == generation, self.status == .loading else { return }
                self.constraintFullHeightCircle.isActive = false
                UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0.0, options: .curveEaseInOut) {
                    self.imageViewCircle.tintColor = .secondaryLabel
                    self.viewLoading.alpha = 1.0
                    self.view.layoutIfNeeded()
                } completion: { (finished) in
                    guard finished, self.loadingAnimationGeneration == generation, self.status == .loading else { return }
                    self.animationLoading()
                    completion()
                }
            }
        }
        else {
            completion()
        }
    }
    func animationLoading() {
        UIView.animate(withDuration: AppConfig.Animation.duration * 8, delay: AppConfig.Animation.duration, options: .curveEaseInOut) {
            self.viewLoading1.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            self.viewLoading2.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.viewLoading1.alpha = 0.0
            self.viewLoading2.alpha = 0.0
        } completion: { (finished) in
            if finished {
                self.viewLoading1.transform = .identity
                self.viewLoading2.transform = .identity
                self.viewLoading1.alpha = 0.3
                self.viewLoading2.alpha = 0.15
                if self.status == .loading {
                    self.animationLoading()
                }
            }
        }
    }
    func hideLoading(completion: @escaping() -> ()) {
        loadingAnimationGeneration += 1
        status = .ready
        self.constraintFullHeightCircle.isActive = true
        UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0.0, options: .curveEaseInOut) {
            self.imageViewCircle.tintColor = UIColor(named: "BrandPrimary500")
            self.viewLoading.alpha = 0.0
            self.view.layoutIfNeeded()
        } completion: { (finished) in
            UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0.0, options: .curveEaseInOut) {
                self.viewSwipeable.alpha = 1.0
                self.viewButtons.alpha = 1.0
                self.adBannerView?.superview?.alpha = 1.0
            } completion: { (finished) in
                completion()
            }
        }
    }
    
    
    // Handler search
    @objc
    func reload() {
        self.page = 0
        self.viewSwipeable.discardViews()
        search()
    }
    func search() {
        searchGeneration += 1
        let generation = searchGeneration
        cardIndex = 0
        self.viewEmpty.alpha = 0
        showLoading {
            guard generation == self.searchGeneration else { return }

            let request = MatchMaker.Search.Request(
                page: self.page,
                generation: generation
            )
            self.interactor?.search(request: request)
        }
    }
    func onSearch(viewModel: MatchMaker.Search.ViewModel) {
        guard viewModel.generation == searchGeneration else { return }

        page += 1
        if viewModel.cards.count > 0 {
            self.viewEmpty.alpha = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
                guard viewModel.generation == self.searchGeneration else { return }

                self.cards = viewModel.cards
                self.viewSwipeable.discardViews()
                self.viewSwipeable.numberOfActiveView = UInt(self.cards.count > 3 ? 3 : self.cards.count)
                self.viewSwipeable.nextView = {
                    return self.nextCardView()
                }
                self.hideLoading {
                    if self.page > 1 {
                        self.showAd()
                    }
                }
            }
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
                guard viewModel.generation == self.searchGeneration else { return }

                self.showEmptyState {
                    if self.page > 1 {
                        self.showAd()
                    }
                }
            }
        }
        if isFirstLoad {
            isFirstLoad = false
        }
    }
    func onSearchError(error: String, generation: Int) {
        guard generation == searchGeneration else { return }

        displayAlert(nil, message: error)
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
            guard generation == self.searchGeneration else { return }

            self.showEmptyState()
        }
    }

    private func showEmptyState(completion: (() -> Void)? = nil) {
        loadingAnimationGeneration += 1
        status = .ready
        cards.removeAll()
        cardIndex = 0
        viewSwipeable.discardViews()

        UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0.0) {
            self.viewSwipeable.alpha = 0
            self.viewButtons.alpha = 0
            self.viewLoading.alpha = 0
            self.viewEmpty.alpha = 1
        } completion: { _ in
            completion?()
        }
    }
    
    
    // Handler location
    func location(latitude: Double, longitude: Double) {
        if !locationHasSended {
            locationHasSended = true
            let request = MatchMaker.Location.Request(latitude: latitude, longitude: longitude)
            interactor?.location(request: request)
        }
    }
    func onLocation(viewModel: MatchMaker.Location.ViewModel) {
        search()
        notification()
    }
    func onLocationError(error: String) {
        locationHasSended = false
        search()
        displayAlert(nil, message: error)
        notification()
    }
    
    
    // Handler notification
    func notification() {
        let request = MatchMaker.Notification.Request()
        self.interactor?.notification(request: request)
    }
    func onNotification(viewModel: MatchMaker.Notification.ViewModel) {
        if viewModel.granted {
            DispatchQueue.main.async {
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        tracking()
    }
    
    
    // Handler tracking
    func tracking() {
        let request = MatchMaker.Tracking.Request()
        self.interactor?.tracking(request: request)
    }
    func onTracking(viewModel: MatchMaker.Tracking.ViewModel) {
        
    }
    
    
    // Handler product
    func nextCardView() -> UIView? {
    
        if cardIndex < cards.count {
            let cardView = CardView(frame: viewSwipeable.bounds)
            let card = cards[cardIndex]
            cardView.setup(card)
            cardView.tag = card.id
            cardIndex += 1
            return cardView
        }
        
        return nil
    }
    
    
    // Handler intention
    func intention(productId: Int, option: MatchMakerOption) {
        impactFeedback(for: option)
        
        if option == .Like {
            AppAnalytics.shared.logEvent("product_like", parameters: nil)
        }
        else {
            AppAnalytics.shared.logEvent("product_nope", parameters: nil)
        }
        
        let request = MatchMaker.Intention.Request(
            productId: productId,
            option: option
        )
        interactor?.intention(request: request)
        handlerIntention()
    }
    func onIntention(viewModel: MatchMaker.Intention.ViewModel) {
        
        if viewModel.match {
            addChatBadgeValue()
            reloadChatListIfNeeded()
            
            AppHaptics.success()
            performSegue(withIdentifier: "ItsAMatch", sender: nil)
            
            AppAnalytics.shared.logEvent("its_a_match", parameters: nil)
        }
        
       // handlerIntention()
    }
    func onIntentionError(error: String) {
        displayAlert(nil, message: error)
    }
    func handlerIntention() {
        if cards.count > 0 {
            cards.removeFirst()
            cardIndex = max(0, cardIndex - 1)
        }
        
        if cards.count == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
                self.search()
            }
        }
    }
    private func impactFeedback(for option: MatchMakerOption) {
        switch option {
        case .Like:
            AppHaptics.impact(.medium)
        case .Nope:
            AppHaptics.impact(.rigid)
        }
    }
    
    
    // Handler detail
    func detail(productId: Int) {
        let request = MatchMaker.Detail.Request(productId: productId)
        interactor?.detail(request: request)
    }
    func onDetail(viewModel: MatchMaker.Detail.ViewModel) {
        performSegue(withIdentifier: "Product", sender: nil)
    }
    
    
    // Handler super like
    func superLike(productId: Int) {
        let request = MatchMaker.SuperLike.Request(productId: productId)
        interactor?.superLike(request: request)
    }
    func onSuperLike(viewModel: MatchMaker.SuperLike.ViewModel) {
        performSegue(withIdentifier: "SuperLike", sender: nil)
    }
    func onSuperLikeSuccess() {
        viewSwipeable.swipeTopView(inDirection: .Up)
        handlerIntention()
    }
    
    
    // Handler denunciate
    func handlerDenunciate() {
        if let cardView = viewSwipeable.topView() as? CardView {
            let id = cardView.tag
            
            confirmDenunciate(productId: id) { confirm in
                if confirm {
                    self.router?.routeToDenunciateSuccess()
                }
            }
        }
    }
    func onDenunciateSuccess() {
        self.viewSwipeable.swipeTopView(inDirection: .Down)
        self.handlerIntention()
    }
    
    
    // Handler count my products
    func countMyProducts() {
        let request = MatchMaker.CountMyProducts.Request()
        interactor?.countMyProducts(request: request)
    }
    func onCountMyProducts(viewModel: MatchMaker.CountMyProducts.ViewModel) {
        self.myProducts = viewModel.myProducts
    }
    
    
    // Handler need add Product
    func handlerNeedAddProduct() {
        router?.routeToAddProduct()
    }
    
    
    // Handler need location
    func handlerNeedLocation() {
        router?.routeToNeedLocation()
    }
    func openSeetingsLocation() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
               UIApplication.shared.open(url)
            }
        }
    }
    
    
    // Handler ad
    func ad() {
        let request = MatchMaker.Ad.Request()
        interactor?.ad(request: request)
    }
    func onAd(viewModel: MatchMaker.Ad.ViewModel) {
        let request = Request()
        RewardedInterstitialAd.load(
            with: viewModel.adUnitId,
            request: request,
            completionHandler: { ad, error in
                self.interstitial = ad
            })
    }
    func showAd() {
        if let ad = interstitial {
            ad.present(from: self) {
            }
        }
        ad()
    }
    
    
    // Handler boost profile
    func boostProfile() {
        let request = MatchMaker.BoostProfile.Request()
        interactor?.boostProfile(request: request)
    }
    func onBoostProfile(viewModel: MatchMaker.BoostProfile.ViewModel) {
        router?.routeToBoostProfileIsActive()
        buttonBoost.isEnabled = false
        reloadProfileIfNeeded()
    }
    func onBoostProfile(error: String) {
        
    }
     
    
    // Handler boost profile status
    func boostProfileStatus() {
        let request = MatchMaker.BoostProfileStatus.Request()
        interactor?.boostProfileStatus(request: request)
    }
    func onBoostProfileStatus(viewModel: MatchMaker.BoostProfileStatus.ViewModel) {
        buttonBoost.isEnabled = !viewModel.isActive
    }
    

    // Handler actions
    @IBAction func didDenunciate() {
        AppHaptics.tap()
        router?.routeToDenunciate()
    }
    @IBAction func didRewind() {
        AppHaptics.tap()
        viewSwipeable.rewind()
    }
    @IBAction func didNope() {
        if let cardView = viewSwipeable.topView() as? CardView {
            cardView.animationDidNope()
        }
        self.viewSwipeable.swipeTopView(inDirection: .Left)
    }
    @IBAction func didLike() {
        if let cardView = viewSwipeable.topView() as? CardView {
            cardView.animationDidLike()
        }
        viewSwipeable.swipeTopView(inDirection: .Right)
    }
    @IBAction func didSuperLike() {
        
        if let cardView = viewSwipeable.topView() as? CardView {
            AppHaptics.success()
            cardView.animationSuperLike()
            let productId = cardView.tag
            DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration * 3, execute: {
                self.superLike(productId: productId)
            })
        }
    
    }
    @IBAction func didBoost() {
        AppHaptics.tap()
        router?.routeToBoostProfile()
    }
    
    
}
