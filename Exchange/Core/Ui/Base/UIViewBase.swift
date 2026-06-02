import UIKit


class UIViewBase: UIView {
    
    
    // Var's
    open override func awakeFromNib() {
        super.awakeFromNib()
        sharedInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        sharedInit()
    }
    
    
    // Style
    func sharedInit() {
        self.layer.cornerRadius = AppTheme.Radius.lg
        self.layer.borderWidth = 1
        updateDynamicColors()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else {
            return
        }
        
        updateDynamicColors()
    }
    
    private func updateDynamicColors() {
        self.backgroundColor = AppTheme.Colors.backgroundSurface100
        self.layer.borderColor = AppTheme.Colors.borderDefault.resolvedColor(with: traitCollection).cgColor
    }
    
    
}
