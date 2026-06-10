//
//  PaywallV1ViewController.swift
//  simulados.pro
//
//  Created by Douglas Cicarello on 11/03/26.
//  Copyright (c) 2026 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Kingfisher
import KingOS
import StoreKit
import DotLottie


protocol PaywallV1DisplayLogic: AnyObject {
    func onLoad(viewModel: PaywallV1.Load.ViewModel)
    func onAB(viewModel: PaywallV1.AB.ViewModel)
    func onFetch(viewModel: PaywallV1.Fetch.ViewModel)
    func onPurchase(viewModel: PaywallV1.Purchase.ViewModel)
    func onRestore(viewModel: PaywallV1.Restore.ViewModel)
}


class PaywallV1ViewController: MainBaseViewController, PaywallV1DisplayLogic {
    
    private enum ABPayloadKey {
        static let creativeURL = "creative_url"
        static let creativeLottie = "creative_lottie"
    }
    
    private enum HeroAsset {
        static let premium = "premium"
    }
  
    
    // Var's
    var interactor: PaywallV1BusinessLogic?
    var router: (NSObjectProtocol & PaywallV1RoutingLogic & PaywallV1DataPassing)?
    
    @IBOutlet var heroImageView: UIImageView!
    @IBOutlet var buttonPurchase: UIButtonBase!
    
    //@IBOutlet var buttonRestore: UIButton!
   // @IBOutlet var buttonTerms: UIButton!
    //@IBOutlet var buttonPrivacy: UIButton!
    
    private var productsByIdentifier = [String: SKProduct]()
    private var productIdentifierByRow = [Int: String]()
    private var offerKeyByIdentifier = [String: KingOSIAPOfferKey]()
    private var selectedProductIdentifier: String?
    private var doLottieAnimationView: DotLottieAnimationView?
    
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
        modalPresentationCapturesStatusBarAppearance = true
        setNeedsStatusBarAppearanceUpdate()
        setupInputs()
        load()
    }
  
    
    // Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        setupAnalytics()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        
        //self.buttonTerms.setTitle("PayWall.Footer.Terms".localized, for: .normal)
       // self.buttonRestore.setTitle("PayWall.Footer.Restore".localized, for: .normal)
       // self.buttonPrivacy.setTitle("PayWall.Footer.Privacy".localized, for: .normal)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard isBeingDismissed || presentingViewController != nil else { return }
        
        // Reapplies the status bar style of the underlying screen after the paywall sheet closes.
        DispatchQueue.main.async { [weak self] in
            self?.presentingViewController?.setNeedsStatusBarAppearanceUpdate()
            self?.presentingViewController?.navigationController?.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    
    // Setup inputs
    func setupInputs() {
        registerTableView()
        applyTableViewInsetsLg()
        buttonPurchase.showLoading()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
    }
    
    
    // Handler load
    func load() {
        let request = PaywallV1.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: PaywallV1.Load.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        AB()
        fetch()
    }
    
    
    // Handler AB
    func AB() {
        let request = PaywallV1.AB.Request()
        interactor?.AB(request: request)
    }
    func onAB(viewModel: PaywallV1.AB.ViewModel) {
        
        var hasHero = false
        
        if let abAssignment = viewModel.abAssignment {
            
            // Online image
            if let creativeUrl = abAssignment.payloadString(ABPayloadKey.creativeURL) {
                if let url = URL(string: creativeUrl) {
                    hasHero = true
                    heroImageView.kf.setImage(with: url)
                }
            }
            else {
                
                if let creativeLottie = abAssignment.payloadString(ABPayloadKey.creativeLottie) {
                    doLottieAnimationView?.removeFromSuperview()
                   
                    let animation = DotLottieAnimation(
                        fileName: creativeLottie,
                        config: .init(
                            autoplay: true,
                            loop: true
                        )
                    )
                    let view = DotLottieAnimationView(dotLottieViewModel: animation)
                    heroImageView.addSubview(view)
                        
                    view.translatesAutoresizingMaskIntoConstraints = false
                    view.contentMode = .scaleAspectFit
                        
                    NSLayoutConstraint.activate([
                        view.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor),
                        view.trailingAnchor.constraint(equalTo: heroImageView.trailingAnchor),
                        view.topAnchor.constraint(equalTo: heroImageView.topAnchor),
                        view.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor)
                    ])
                    
                    doLottieAnimationView = view
                    hasHero = true
                }

               
            }
    
        }
        
        if !hasHero {
           doLottieAnimationView?.removeFromSuperview()
               
            let animation = DotLottieAnimation(
                fileName: HeroAsset.premium,
                config: .init(
                    autoplay: true,
                    loop: true
                )
            )
            let view = DotLottieAnimationView(dotLottieViewModel: animation)
            heroImageView.addSubview(view)
                
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleAspectFit
                
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: heroImageView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: heroImageView.trailingAnchor),
                view.topAnchor.constraint(equalTo: heroImageView.topAnchor),
                view.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor)
            ])
            
            doLottieAnimationView = view
        }
        
        
    }
    
    
    // Fetch
    func fetch() {
        let request = PaywallV1.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: PaywallV1.Fetch.ViewModel) {
        rows = viewModel.rows
        productsByIdentifier = viewModel.productsByIdentifier
        productIdentifierByRow = viewModel.productIdentifierByRow
        offerKeyByIdentifier = viewModel.offerKeyByIdentifier
        selectedProductIdentifier = viewModel.selectedProductIdentifier
        tableView?.reloadData()
        updatePurchaseButtonTitle()
        buttonPurchase.hideLoading()
    }
    
    
    
    
    // Handler restore
    func restore() {
        buttonPurchase.showLoading()
        let request = PaywallV1.Restore.Request()
        interactor?.restore(request: request)
    }
    func onRestore(viewModel: PaywallV1.Restore.ViewModel) {
        buttonPurchase.hideLoading()
        if viewModel.shouldDismiss {
            AppHaptics.success()
        }
        else {
            AppHaptics.warning()
        }
        
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Alert.Action.Close".localized, style: .default) { [weak self] _ in
            guard viewModel.shouldDismiss else { return }
            self?.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    // Handler purchase
    func purchase() {
        buttonPurchase.showLoading()
        let request = PaywallV1.Purchase.Request(productIdentifier: selectedProductIdentifier)
        interactor?.purchase(request: request)
    }
    func onPurchase(viewModel: PaywallV1.Purchase.ViewModel) {
        buttonPurchase.hideLoading()
        if viewModel.shouldDismiss {
            AppHaptics.success()
        }
        else {
            AppHaptics.error()
        }
        
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "Alert.Action.Close".localized, style: .default) { [weak self] _ in
            guard viewModel.shouldDismiss else { return }
            self?.dismiss(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    

    // Handler actions
    @IBAction func didClose() {
        dismiss(animated: true)
    }
    @IBAction func didPurchase() {
        purchase()
    }
    @IBAction func didRestore() {
        restore()
    }
    
    
    
    override func didSelect(row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .default(let model):
            guard model.identifier == .payWall else { return }
            AppHaptics.selection()
            selectedProductIdentifier = productIdentifierByRow[indexPath.row]
            updateSelectedPlan(at: indexPath)
        default:
            break
        }
    }
    
    private func updateSelectedPlan(at selectedIndexPath: IndexPath) {
        rows = rows.enumerated().map { index, row in
            guard case .default(var model) = row, model.identifier == .payWall else {
                return row
            }
            
            model.style = index == selectedIndexPath.row ? .selected : .normal
            model.iconLeft = .none
            model.iconRight = index == selectedIndexPath.row ? .checkCircle : .circle
            return .default(model)
        }
        updateCaptionText()
        
        tableView?.reloadData()
        updatePurchaseButtonTitle()
    }
    
    private func updatePurchaseButtonTitle() {
        guard let selectedProductIdentifier,
              let product = productsByIdentifier[selectedProductIdentifier] else {
            buttonPurchase.setTitle("PayWall.Cta.Purchase".localized.replacingOccurrences(of: "{$0}", with: "premium"), for: .normal)
            return
        }
        
        if isOneTimePremium(product) {
            buttonPurchase.setTitle("PayWall.Cta.OneTime.2026".localized, for: .normal)
            return
        }
        
        if let introductoryPrice = product.introductoryPrice,
           introductoryPrice.paymentMode == .freeTrial {
            let days = trialDays(for: introductoryPrice.subscriptionPeriod)
            let title: String
            if days == 1 {
                title = "PayWall.Cta.Purchase.Trial.Singular".localized
            }
            else {
                title = "PayWall.Cta.Purchase.Trial.Plural".localized.replacingOccurrences(of: "{$0}", with: "\(days)")
            }
            buttonPurchase.setTitle(title, for: .normal)
            return
        }
        
        if isPromotional(product) {
            buttonPurchase.setTitle("PayWall.Cta.Promotional".localized, for: .normal)
            return
        }
        
        let title = "PayWall.Cta.Purchase".localized.replacingOccurrences(
            of: "{$0}",
            with: localizedPlanName(for: product).lowercased()
        )
        buttonPurchase.setTitle(title, for: .normal)
    }
    
    private func localizedPlanName(for product: SKProduct) -> String {
        if isOneTimePremium(product) {
            return "PayWall.Period.OneTime".localized
        }
        
        if let offerKey = offerKeyByIdentifier[product.productIdentifier] {
            switch offerKey {
            case .promotional:
                return "PayWall.Period.Promotional".localized
            case .weekly:
                return "PayWall.Period.Weekly".localized
            case .monthly:
                return "PayWall.Period.Monthly".localized
            case .bimonthly:
                return "PayWall.Period.Bimonthly".localized
            case .quarterly:
                return "PayWall.Period.Quarterly".localized
            case .semiannual:
                return "PayWall.Period.Semiannual".localized
            case .annual:
                return "PayWall.Period.Annual".localized
            }
        }
        
        switch product.productIdentifier {
        case InAppPurchase.Product.premiumOneTime.identifier:
            return "PayWall.Period.OneTime".localized
        case InAppPurchase.Product.premiumSubscriptionWeekly.identifier:
            return "PayWall.Period.Weekly".localized
        case InAppPurchase.Product.premiumSubscriptionPromotional.identifier:
            return "PayWall.Period.Promotional".localized
        case InAppPurchase.Product.premiumSubscriptionMonthly.identifier:
            return "PayWall.Period.Monthly".localized
        case InAppPurchase.Product.premiumSubscriptionQuarterly.identifier:
            return "PayWall.Period.Quarterly".localized
        case InAppPurchase.Product.premiumSubscriptionSemiannual.identifier:
            return "PayWall.Period.Semiannual".localized
        default:
            return product.localizedTitle
        }
    }

    private func isPromotional(_ product: SKProduct) -> Bool {
        if isOneTimePremium(product) {
            return false
        }
        
        if let offerKey = offerKeyByIdentifier[product.productIdentifier] {
            return offerKey == .promotional
        }
        return product.productIdentifier == InAppPurchase.Product.premiumSubscriptionPromotional.identifier
    }
    
    private func updateCaptionText() {
        guard selectedProductIdentifier != nil else {
            return
        }
    
        let product = selectedProductIdentifier.flatMap { productsByIdentifier[$0] }
        let text = captionText(for: product)
        let footerCaptionIndex = rows.lastIndex {
            guard case .textCaption = $0 else {
                return false
            }
            return true
        }
        
        rows = rows.enumerated().map { index, row in
            guard index == footerCaptionIndex else {
                return row
            }
            guard case .textCaption(var model) = row else {
                return row
            }
            model.text = text
            return .textCaption(model)
        }
    }
    
    private func trialDays(for period: SKProductSubscriptionPeriod) -> Int {
        switch period.unit {
        case .day:
            return period.numberOfUnits
        case .week:
            return period.numberOfUnits * 7
        case .month:
            return period.numberOfUnits * 30
        case .year:
            return period.numberOfUnits * 365
        @unknown default:
            return period.numberOfUnits
        }
    }
    
    private func captionText(for product: SKProduct?) -> String {
        guard let product else {
            return "PayWall.Caption.Mixed".localized
        }
        
        if isOneTimePremium(product) {
            return "PayWall.Caption.OneTime.2026".localized
        }
        
        return "PayWall.Caption.CancelAnytime".localized
    }
    
    private func isOneTimePremium(_ product: SKProduct) -> Bool {
        product.subscriptionPeriod == nil || isOneTimePremiumIdentifier(product.productIdentifier)
    }
    
    private func isOneTimePremiumIdentifier(_ identifier: String) -> Bool {
        let normalized = identifier.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return normalized == "exchange.stickers.premium"
            || (normalized.hasSuffix(".premium") && !normalized.contains(".subscription."))
    }
    
    
}
