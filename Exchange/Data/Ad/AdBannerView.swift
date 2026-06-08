import UIKit


class AdBannerView: UIView {
    
    
    // Var's
    private var placement: AdPlacement?
    private var buffer: UIView?
    private weak var viewController: UIViewController?
    private var heightConstraint: NSLayoutConstraint?
    private var lastLoadedWidth: CGFloat = 0
    
    
    // Init
    open override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = AppTheme.Colors.backgroundApp
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        guard window != nil else { return }
        loadIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loadIfNeeded()
    }

    
    
    // Load
    func load(_ placement: AdPlacement, viewController: UIViewController) {
        self.placement = placement
        self.viewController = viewController
        
        loadIfNeeded()
    }
    
    private func loadIfNeeded() {
        guard
            let placement,
            let viewController,
            bounds.width > 0
        else {
            return
        }
        
        let width = bounds.width
        let didLoadWidth = abs(lastLoadedWidth - width) <= 1
        if didLoadWidth == false {
            let height = AdBannerService.shared.load(
                placement,
                width: width,
                viewController: viewController
            )
            updateHeight(height)
            lastLoadedWidth = width
        }
        
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
    
    private func updateHeight(_ height: CGFloat) {
        let constraint = heightConstraint ?? constraints.first {
            $0.firstAttribute == .height && $0.secondItem == nil
        }
        
        constraint?.constant = height
        heightConstraint = constraint
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }
    
}
