import UIKit


class InputSelectCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelValue: UILabel!
    @IBOutlet var labelCount: UILabel!
    @IBOutlet var imageViewIconLeft: UIImageView!
    @IBOutlet var imageViewIconRight: UIImageView!
    
    
    // Model
    struct Model {
        var title: String
        var placeholder: String
        var value: String
        var count: String
        var iconLeft: AppTheme.Icon
        var iconRight: AppTheme.Icon
        var isEnabled: Bool = true
        var identifier: DefaultCell.Identifier
    }
    
    
    // Setup
    func setup(model: Model) {
        
        labelTitle.text = model.title
        labelValue.text = model.value.isEmpty ? model.placeholder : model.value
        labelValue.textColor = model.value.isEmpty ? AppTheme.Colors.textOnSurfaceDisabled : AppTheme.Colors.textOnSurface
        labelCount.text = model.count
        imageViewIconLeft.image = AppTheme.icon(model.iconLeft)
        imageViewIconRight.image = AppTheme.icon(model.iconRight)
        
        if model.isEnabled {
            labelCount.textColor = AppTheme.Colors.textOnSurfaceSecondary
            labelValue.textColor = AppTheme.Colors.textOnSurface
            imageViewIconLeft.tintColor = AppTheme.Colors.iconOnSurface
            imageViewIconRight.tintColor = AppTheme.Colors.brandPrimary500
        }
        else {
            labelCount.textColor = AppTheme.Colors.textOnSurfaceDisabled
            labelValue.textColor = AppTheme.Colors.textOnSurfaceSecondary
            imageViewIconLeft.tintColor = AppTheme.Colors.iconOnSurfaceDisabled
            imageViewIconRight.tintColor = AppTheme.Colors.iconOnSurfaceDisabled
        }
        
    }
    
    
}
