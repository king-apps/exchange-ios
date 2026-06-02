import UIKit
import Kingfisher


class ChatListCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var viewAvatar: UIView!
    @IBOutlet var imageViewAvatar: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelMessage: UILabel!
    @IBOutlet var viewNotViewed: UIView!
    @IBOutlet var labelNotViewed: UILabel!
    
    
    // Model
    struct Model {
        var id: Int
        var avatarUrl: String?
        var name: String
        var message: String
        var notViewed: Int
    }
    
    
    // Setup
    func setup(model: Model) {
        
        viewAvatar.layer.cornerRadius = viewAvatar.bounds.height / 2
        imageViewAvatar.layer.cornerRadius = imageViewAvatar.bounds.height / 2
        
        if let avatar = model.avatarUrl, let url = URL(string: avatar) {
            imageViewAvatar.kf.setImage(with: url)
            imageViewAvatar.contentMode = .scaleAspectFill
        }
        else {
            imageViewAvatar.image = AppTheme.icon(.user)
            imageViewAvatar.contentMode = .center
        }
        
        labelName.text = model.name
        labelMessage.text = model.message
        
        // Not viewed
        viewNotViewed.layer.masksToBounds = true
        viewNotViewed.layer.cornerRadius = viewNotViewed.bounds.height / 2
        viewNotViewed.isHidden = model.notViewed == 0
        labelNotViewed.text = "\(model.notViewed)"
    }
    
}
