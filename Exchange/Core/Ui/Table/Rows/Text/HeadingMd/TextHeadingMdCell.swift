import Foundation
import UIKit


class TextHeadingMdCell: UITableViewCell, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var labelText: UILabel!
    @IBOutlet var imageViewIcon: UIImageView!
    
    
    // Models
    struct Model {
        var text: String
        var align: NSTextAlignment?
        var image: String?
    }
    
    
    // Setup
    func setup(model: TextHeadingMdCell.Model) {
        
        labelText.text = model.text
        labelText.textAlignment = model.align ?? .center
        
        if let image = model.image {
            imageViewIcon.layer.cornerRadius = imageViewIcon.bounds.height / 2
            imageViewIcon.image = UIImage(named: image)
        }
        else {
            DispatchQueue.main.async {
                self.imageViewIcon.isHidden = true
                self.imageViewIcon.removeFromSuperview()
            }
        }
        
    }
    
    
}
