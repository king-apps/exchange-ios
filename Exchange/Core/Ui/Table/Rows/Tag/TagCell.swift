import UIKit
import Foundation


class TagCell: UITableViewCell, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var imageViewIcon: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var viewBackground: UIView!
    @IBOutlet var constraintCenter: NSLayoutConstraint!
    
    // Models
    struct Model {
        var icon: AppTheme.Icon
        var title: String
        var style: TagCell.Style
        var align: TagCell.Align
    }

    enum Style {
        case Default
        case Success
        case Warning
        case Error
        case Disabled
    }

    enum Align {
        case Left
        case Center
        case Right
    }
    
    
    // Setup
    func setup(model: TagCell.Model) {
        
        // Icon
        imageViewIcon.image = AppTheme.icon(model.icon)
        // Text
        labelTitle.text = model.title
        // Style
        handlerStyle(style: model.style)
        // Radius
        viewBackground.layer.cornerRadius = AppTheme.Radius.sm
        // Align
        if model.align == .Left {
            constraintCenter.isActive = false
        }
    }
    
    
    // Handler style
    private func handlerStyle(style: TagCell.Style) {
        if style == .Default {
            setStyleDefault()
        }
        else if style == .Success {
            setStyleSuccess()
        }
        else if style == .Warning {
            setStyleWarning()
        }
        else if style == .Error {
            setStyleError()
        }
        else if style == .Disabled {
            setStyleDisabled()
        }
    }
    private func setStyleDefault() {
        imageViewIcon.tintColor = AppTheme.Colors.brandPrimary500
        labelTitle.textColor = AppTheme.Colors.brandPrimary500
        viewBackground.backgroundColor = AppTheme.Colors.backgroundDisabled
    }
    private func setStyleSuccess() {
        imageViewIcon.tintColor = AppTheme.Colors.success500
        labelTitle.textColor = AppTheme.Colors.success500
        viewBackground.backgroundColor = AppTheme.Colors.success100
    }
    private func setStyleWarning() {
        imageViewIcon.tintColor = AppTheme.Colors.warning500
        labelTitle.textColor = AppTheme.Colors.warning500
        viewBackground.backgroundColor = AppTheme.Colors.warning100
    }
    private func setStyleError() {
        imageViewIcon.tintColor = AppTheme.Colors.error500
        labelTitle.textColor = AppTheme.Colors.error500
        viewBackground.backgroundColor = AppTheme.Colors.error100
    }
    private func setStyleDisabled() {
        imageViewIcon.tintColor = AppTheme.Colors.neutral600
        labelTitle.textColor = AppTheme.Colors.neutral600
        viewBackground.backgroundColor = AppTheme.Colors.neutral100
    }
    
    
}
