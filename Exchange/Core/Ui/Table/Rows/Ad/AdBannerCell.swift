import UIKit


class AdBannerCell: UITableViewCell, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var adBannerView: AdBannerView!
    
    
    struct Model {
        var placement: AdPlacement
    }
    
    
    // Setup
    func setup(model: AdBannerCell.Model, viewController: UIViewController) {
        adBannerView.load(model.placement, viewController: viewController)
    }
    
    
}
