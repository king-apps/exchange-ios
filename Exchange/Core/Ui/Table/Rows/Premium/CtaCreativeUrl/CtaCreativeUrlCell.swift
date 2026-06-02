import UIKit
import Kingfisher


class CtaCreativeUrlCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var imageViewBanner: UIImageView!
    
    
    // Model
    struct Model {
        let creativeUrl: String?
    }
    
    
    // Setup
    func setup(model: Model) {
        
        if let creativeUrl = model.creativeUrl, let url = URL(string: creativeUrl) {
            imageViewBanner.kf.setImage(with: url)
        }
        
    }
    
}
