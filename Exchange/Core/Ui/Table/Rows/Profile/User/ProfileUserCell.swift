import UIKit
import Kingfisher


class ProfileUserCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var imageViewAvatar: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelEmail: UILabel!
    
    
    // Model
    struct Model {
        var avatar: String?
        var name: String
        var email: String?
    }
    
    
    // Setup
    func setup(model: Model) {
        
        imageViewAvatar.layer.cornerRadius = imageViewAvatar.bounds.height / 2
        imageViewAvatar.layer.borderColor = AppTheme.Colors.baseWhite.cgColor
        imageViewAvatar.layer.borderWidth = 2.0
        
        if let avatar = model.avatar, let url = URL(string: avatar) {
            var options: KingfisherOptionsInfo?
            if User.shared.getNeedUpdateAvatar() {
                User.shared.setNeedUpdateAvatar(false)
                options = [.forceRefresh, .forceTransition, .waitForCache]
            }
            imageViewAvatar.kf.setImage(with: url, options: options)
            imageViewAvatar.contentMode = .scaleAspectFill
        }
        
        labelName.text = model.name
        labelEmail.text = model.email
    }
}
