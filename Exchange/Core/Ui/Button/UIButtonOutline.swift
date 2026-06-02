import UIKit


class UIButtonOutline: UIButtonBase {
    
    
    // Var's
    open override var isEnabled: Bool {
        didSet {
            if isEnabled {
                styleEnabled()
            }
            else {
                styleDisabled()
            }
        }
    }
    
    
    // Handler construct
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    func sharedInit() {
        style()
        styleEnabled()
    }
    
    
    // Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        style()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else {
            return
        }
        
        isEnabled ? styleEnabled() : styleDisabled()
    }
    
    
    // Handler style
    func style() {
        self.layer.cornerRadius = AppTheme.Radius.sm
        self.layer.borderWidth = 1
        let baseFont = UIFont.systemFont(ofSize: AppTheme.FontSize.button, weight: .semibold)
        self.titleLabel?.font = baseFont
    }
    func styleEnabled() {
        self.layer.borderColor = AppTheme.Colors.borderDefault.resolvedColor(with: traitCollection).cgColor
        self.backgroundColor = AppTheme.Colors.backgroundSurface100
        self.setTitleColor(AppTheme.Colors.buttonPrimary, for: .normal)
        self.tintColor = AppTheme.Colors.buttonPrimary
    }
    func styleDisabled() {
        self.backgroundColor = AppTheme.Colors.backgroundDisabled
        self.layer.borderColor = AppTheme.Colors.borderDefault.resolvedColor(with: traitCollection).cgColor
        self.setTitleColor(AppTheme.Colors.buttonDisabled, for: .disabled)
        self.tintColor = AppTheme.Colors.buttonDisabled
    }
    
}
