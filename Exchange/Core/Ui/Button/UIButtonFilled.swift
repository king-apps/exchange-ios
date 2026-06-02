import UIKit


class UIButtonFilled: UIButtonBase {
    
    
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
    
    
    // Handler style
    func style() {
        self.layer.cornerRadius = AppTheme.Radius.sm
        let baseFont = UIFont.systemFont(ofSize: AppTheme.FontSize.button, weight: .semibold)
        self.titleLabel?.font = baseFont
    }
    func styleEnabled() {
        self.backgroundColor = AppTheme.Colors.buttonPrimary
        self.setTitleColor(AppTheme.Colors.buttonOnPrimary, for: .normal)
        self.tintColor = AppTheme.Colors.buttonOnPrimary
    }
    func styleDisabled() {
        self.backgroundColor = AppTheme.Colors.buttonDisabled
        self.setTitleColor(AppTheme.Colors.buttonOnDisabled, for: .disabled)
        self.tintColor = AppTheme.Colors.buttonOnDisabled
    }
    
}
