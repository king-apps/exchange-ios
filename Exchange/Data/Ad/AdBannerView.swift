import UIKit


class AdBannerView: UIView {
    
    
    // Var's
    private var placement: AdPlacement?
    private var buffer: UIView?
    
    
    // Init
    open override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = AppTheme.Colors.backgroundApp
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard window != nil else { return }
        attachIfNeeded()
    }

    
    
    // Load
    func load(_ placement: AdPlacement, viewController: UIViewController) {
        self.placement = placement
        
        AdBannerService.shared.load(placement, viewController: viewController)
        attachIfNeeded()
    }
    
    
    // Attached
    private func attachIfNeeded() {
        
        if let placement {
            if let adView = AdBannerService.shared.view(for: placement) {
                if adView == self.buffer {
                    return
                }
                else {
                    self.buffer?.removeFromSuperview()
                    self.buffer = adView
                    
                    addSubview(adView)
                    adView.translatesAutoresizingMaskIntoConstraints = false
                    NSLayoutConstraint.activate([
                        adView.leadingAnchor.constraint(equalTo: leadingAnchor),
                        adView.trailingAnchor.constraint(equalTo: trailingAnchor),
                        adView.topAnchor.constraint(equalTo: topAnchor),
                        adView.bottomAnchor.constraint(equalTo: bottomAnchor)
                    ])
                }
            }
        }
        
    }
    
    
}
