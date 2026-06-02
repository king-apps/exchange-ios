import UIKit


@IBDesignable
class HeadingMd: UILabelBase {
    
    
    // Construct
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    
    // Interface builder
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setup()
    }
    
    
    // Setup
    private func setup() {
        
        let baseFont = UIFont.systemFont(ofSize: AppTheme.FontSize.headingMd, weight: .semibold)
        self.font = UIFontMetrics.default.scaledFont(for: baseFont)
        self.adjustsFontForContentSizeCategory = true
        
    }
    
    
}
