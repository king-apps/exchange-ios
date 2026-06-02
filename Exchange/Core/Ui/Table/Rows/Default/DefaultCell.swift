import UIKit
import Foundation
import Kingfisher


class DefaultCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var viewIconLeft: UIView!
    @IBOutlet var imageViewIconLeft: UIImageView!
    @IBOutlet var imageViewIconRight: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var viewTag: UIView!
    @IBOutlet var imageViewIconTag: UIImageView!
    @IBOutlet var labelTitleTag: UILabel!
    
    private var viewIconLeftConstraints = [NSLayoutConstraint]()
    private var imageViewIconRightConstraints = [NSLayoutConstraint]()
    private var viewTagConstraints = [NSLayoutConstraint]()
    private var model: Model?
    
    
    // Models
    struct Model {
        var iconLeft: AppTheme.Icon
        var iconLeftUrl: String?
        var iconRight: AppTheme.Icon
        var iconRightUrl: String?
        var title: String?
        var titleNumberOfLines: Int?
        var description: String?
        var style: DefaultCell.Style
        var identifier: DefaultCell.Identifier
        var tag: TagCell.Model?
        var color: UIColor?
    }
    enum Style {
        case normal
        case selected
        case disabled
    }
    enum Identifier {
        case none
        case signIn
        case picture
        case name
        case ratingApp
        case shareApp
        case terms
        case privacy
        case deleteAccount
        case logoutApp
        case generic
        case payWall
        case resetApp
        case category
        case radius
    }

    
    // Load
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        
        // Container
        //viewContainer.layer.borderWidth = 1.0
        //viewContainer.layer.cornerRadius = AppTheme.Radius.lg
        
        // Icon Left
        viewIconLeft.layer.borderWidth = 1.0
        viewIconLeft.layer.cornerRadius = viewIconLeft.bounds.width * 0.5
        
        // Tag
        viewTag.layer.cornerRadius = AppTheme.Radius.sm
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        viewIconLeft.layer.cornerRadius = viewIconLeft.bounds.width * 0.5
    }

    
    // Setup
    func setup(model: DefaultCell.Model) {
        
        self.model = model
        
        // Icon Left
        if model.iconLeft == .none {
            if let icon = model.iconLeftUrl {
                if let image = UIImage(named: icon) {
                    imageViewIconLeft.image = image
                    imageViewIconLeft.contentMode = .scaleAspectFit
                }
                else {
                    if let url = URL(string: icon) {
                        imageViewIconLeft.kf.setImage(with: url)
                    }
                    else {
                        if let path = model.iconLeftUrl, let image = UIImage(named: path) {
                            imageViewIconLeft.image = image
                        }
                    }
                }
            }
            else {
                detachLeftIconViewIfNeeded()
                imageViewIconLeft.image = nil
            }
        }
        else {
            attachLeftIconViewIfNeeded()
            imageViewIconLeft.image = AppTheme.icon(model.iconLeft)
        }
        
        // Icon Right
        if model.iconRight == .none {
            detachRightIconViewIfNeeded()
            imageViewIconRight.image = nil
        }
        else {
            attachRightIconViewIfNeeded()
            imageViewIconRight.isHidden = false
            imageViewIconRight.image = AppTheme.icon(model.iconRight)
        }
        
        // Labels
        if let titleNumberOfLines = model.titleNumberOfLines {
            labelTitle.numberOfLines = titleNumberOfLines
            labelTitle.lineBreakMode = .byTruncatingTail
        }
        
        labelTitle.text = model.title
        if let description = model.description {
            labelDescription.isHidden = false
            labelDescription.text = description
        }
        else {
            labelDescription.isHidden = true
            labelDescription.text = nil
        }
        
        // Tag
        if let tag = model.tag {
            attachTagViewIfNeeded()
            // Icon
            imageViewIconTag.image = AppTheme.icon(tag.icon)
            // Text
            labelTitleTag.text = tag.title
            // Style
            handlerStyleTag(style: tag.style)
            
        }
        else {
            detachTagViewIfNeeded()
            imageViewIconTag.image = nil
            labelTitleTag.text = nil
        }
        
        applyStyle(model)

    }
    
    override func updateDynamicColors() {
        super.updateDynamicColors()
        
        guard let model else { return }
        applyStyle(model)
    }
    
    
    // Handler style
    private func applyStyle(_ model: DefaultCell.Model) {
        if model.style == .normal {
            applyStyleDefault()
        }
        else if model.style == .selected {
            if let color = model.color {
                applyStyleSelected(color: color)
            }
            else {
                applyStyleSelected()
            }
        }
        else if model.style == .disabled {
            applyStyleDisabled()
        }
        
        customStyle(for: model.identifier, style: model.style)
    }
    
    private func applyStyleDefault() {
        effectView?.backgroundColor = AppTheme.Colors.borderDefault
        viewContainer.layer.borderColor = AppTheme.Colors.borderDefault.resolvedColor(with: traitCollection).cgColor
        viewContainer.backgroundColor = AppTheme.Colors.backgroundSurface100
        viewIconLeft.backgroundColor = AppTheme.Colors.backgroundBase
        viewIconLeft.layer.borderColor = AppTheme.Colors.borderDefault.resolvedColor(with: traitCollection).cgColor
        imageViewIconLeft.tintColor = AppTheme.Colors.brandPrimary500
        labelTitle.textColor = AppTheme.Colors.textOnSurface
        labelDescription.textColor = AppTheme.Colors.textOnSurfaceSecondary
        imageViewIconRight.tintColor = AppTheme.Colors.iconOnSurface
        //imageViewIconRight.tintColor = AppTheme.shared.getColorIconOnSurface()
    }
    private func applyStyleSelected() {
        effectView?.backgroundColor = AppTheme.Colors.brandPrimary700
        viewContainer.layer.borderColor = AppTheme.Colors.brandPrimary500.resolvedColor(with: traitCollection).cgColor
        viewContainer.backgroundColor = AppTheme.Colors.brandPrimary500
        //viewIconLeft.backgroundColor = AppTheme.Colors.backgroundApp
        viewIconLeft.layer.borderColor = AppTheme.Colors.brandPrimary500.resolvedColor(with: traitCollection).cgColor
        viewIconLeft.backgroundColor = AppTheme.Colors.brandPrimary500
        imageViewIconLeft.tintColor = AppTheme.Colors.iconOnBrandPrimary
        labelTitle.textColor = AppTheme.Colors.textOnBrandPrimary
        labelDescription.textColor = AppTheme.Colors.brandPrimary100
        imageViewIconRight.tintColor = AppTheme.Colors.iconOnBrandPrimary
    }
    private func applyStyleSelected(color: UIColor) {
        effectView?.backgroundColor = color.withAlphaComponent(0.5)
        viewContainer.backgroundColor = color
        viewContainer.layer.borderColor = color.cgColor
        viewIconLeft.layer.borderColor = color.cgColor
        viewIconLeft.backgroundColor = color
        imageViewIconLeft.tintColor = color
        labelTitle.textColor = .white
        labelDescription.textColor = .white
        imageViewIconRight.tintColor = .white
    }
    private func applyStyleDisabled() {
        effectView?.backgroundColor = .clear // AppTheme.Colors.borderDefault
        viewContainer.backgroundColor = AppTheme.Colors.backgroundSurface100
        viewContainer.layer.borderColor = AppTheme.Colors.borderDefault.resolvedColor(with: traitCollection).cgColor
        viewIconLeft.backgroundColor = AppTheme.Colors.textOnSurfaceDisabled
        viewIconLeft.layer.borderColor = AppTheme.Colors.textOnSurfaceDisabled.resolvedColor(with: traitCollection).cgColor
        imageViewIconLeft.tintColor = AppTheme.Colors.iconOnSurfaceDisabled
        labelTitle.textColor = AppTheme.Colors.textOnSurfaceDisabled
        labelDescription.textColor = AppTheme.Colors.textOnSurfaceDisabled
        imageViewIconRight.tintColor = AppTheme.Colors.iconOnSurfaceDisabled
    }
    private func applyStyleLocked() {
        
    }
    
    
    // Custom identifier
    private func customStyle(for identifier: DefaultCell.Identifier, style: DefaultCell.Style) {
        
        self.isUserInteractionEnabled = identifier != .none
        
        switch identifier {
        case .deleteAccount:
            applyCustomStyleDeleteAccount()
            break
        case .signIn:
            applyCustomStyleEmailSignIn()
            break
        default:
            break
        }
    }
    private func applyCustomStyleDeleteAccount() {
        //labelTitle.textColor = AppTheme.Colors.error500
        imageViewIconRight.tintColor = AppTheme.Colors.error500
    }
    private func applyCustomStyleEmailSignIn() {
        labelTitle.textColor = AppTheme.Colors.warning500
        //imageViewIconRight.tintColor = AppTheme.Colors.warning500
    }
   
    
    // Handler tag
    private func handlerStyleTag(style: TagCell.Style) {
        if style == .Default {
            setStyleTagDefault()
        }
        else if style == .Success {
            setStyleTagSuccess()
        }
        else if style == .Warning {
            setStyleTagWarning()
        }
        else if style == .Error {
            setStyleTagError()
        }
        else if style == .Disabled {
            setStyleTagDisabled()
        }
    }
    private func setStyleTagDefault() {
        imageViewIconTag.tintColor = AppTheme.Colors.brandPrimary500
        labelTitleTag.textColor = AppTheme.Colors.brandPrimary500
        viewTag.backgroundColor = AppTheme.Colors.backgroundDisabled
    }
    private func setStyleTagSuccess() {
        imageViewIconTag.tintColor = AppTheme.Colors.success500
        labelTitleTag.textColor = AppTheme.Colors.success500
        viewTag.backgroundColor = AppTheme.Colors.success100
    }
    private func setStyleTagWarning() {
        imageViewIconTag.tintColor = AppTheme.Colors.warning500
        labelTitleTag.textColor = AppTheme.Colors.warning500
        viewTag.backgroundColor = AppTheme.Colors.warning100
    }
    private func setStyleTagError() {
        imageViewIconTag.tintColor = AppTheme.Colors.error500
        labelTitleTag.textColor = AppTheme.Colors.error500
        viewTag.backgroundColor = AppTheme.Colors.error100
    }
    private func setStyleTagDisabled() {
        imageViewIconTag.tintColor = AppTheme.Colors.neutral600
        labelTitleTag.textColor = AppTheme.Colors.neutral600
        viewTag.backgroundColor = AppTheme.Colors.neutral100
    }
    
    private func attachLeftIconViewIfNeeded() {
        guard viewIconLeft.superview == nil, let container = labelTitle.superview else { return }
        
        container.addSubview(viewIconLeft)
        viewIconLeft.translatesAutoresizingMaskIntoConstraints = false
        
        viewIconLeftConstraints = [
            viewIconLeft.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            viewIconLeft.topAnchor.constraint(equalTo: labelTitle.topAnchor),
            viewIconLeft.widthAnchor.constraint(equalToConstant: 40),
            viewIconLeft.heightAnchor.constraint(equalTo: viewIconLeft.widthAnchor),
            labelTitle.leadingAnchor.constraint(equalTo: viewIconLeft.trailingAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(viewIconLeftConstraints)
    }
    
    private func detachLeftIconViewIfNeeded() {
        NSLayoutConstraint.deactivate(viewIconLeftConstraints)
        viewIconLeftConstraints.removeAll()
        viewIconLeft.removeFromSuperview()
    }
    
    private func attachRightIconViewIfNeeded() {
        guard imageViewIconRight.superview == nil, let container = labelTitle.superview else { return }
        
        container.addSubview(imageViewIconRight)
        imageViewIconRight.translatesAutoresizingMaskIntoConstraints = false
        
        imageViewIconRightConstraints = [
            container.trailingAnchor.constraint(equalTo: imageViewIconRight.trailingAnchor, constant: 16),
            imageViewIconRight.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageViewIconRight.leadingAnchor.constraint(greaterThanOrEqualTo: labelTitle.trailingAnchor, constant: 16),
            imageViewIconRight.leadingAnchor.constraint(greaterThanOrEqualTo: labelDescription.trailingAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(imageViewIconRightConstraints)
    }
    
    private func detachRightIconViewIfNeeded() {
        NSLayoutConstraint.deactivate(imageViewIconRightConstraints)
        imageViewIconRightConstraints.removeAll()
        imageViewIconRight.removeFromSuperview()
    }
    
    private func attachTagViewIfNeeded() {
        guard viewTag.superview == nil, let container = labelTitle.superview else { return }
        
        container.addSubview(viewTag)
        viewTag.translatesAutoresizingMaskIntoConstraints = false
        
        viewTagConstraints = [
            viewTag.leadingAnchor.constraint(equalTo: labelTitle.leadingAnchor),
            viewTag.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: 8),
            container.bottomAnchor.constraint(greaterThanOrEqualTo: viewTag.bottomAnchor, constant: 16)
        ]
        
        NSLayoutConstraint.activate(viewTagConstraints)
    }
    
    private func detachTagViewIfNeeded() {
        NSLayoutConstraint.deactivate(viewTagConstraints)
        viewTagConstraints.removeAll()
        viewTag.removeFromSuperview()
    }
    
    
    
}
