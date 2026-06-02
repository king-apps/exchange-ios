import UIKit
import Foundation
import Kingfisher


struct CardModel {
    var id: Int
    var url: String
    var name: String
    var distance: String
}


class CardView : UIView {
    
    
    // Var's
    @IBOutlet weak var imageViewProduct: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    @IBOutlet weak var imageViewLike: UIImageView!
    @IBOutlet weak var effectViewLike: UIView!
    @IBOutlet weak var imageViewNope: UIImageView!
    @IBOutlet weak var effectViewNope: UIView!
    @IBOutlet weak var imageViewSuperLike: UIImageView!
    @IBOutlet weak var effectViewSuperLike: UIView!
    
    
    // Construct
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeSubviews()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeSubviews()
    }
    func initializeSubviews() {
        if let view = Bundle.main.loadNibNamed("CardView", owner: self, options: nil)?.first as? UIView {
            self.addSubview(view)
            view.frame = self.bounds
            imageViewLike.alpha = 0
            effectViewLike.alpha = 0
            imageViewNope.alpha = 0
            effectViewNope.alpha = 0
            imageViewSuperLike.alpha = 0
            effectViewSuperLike.alpha = 0
            
            imageViewProduct.layer.cornerRadius = AppTheme.Radius.sm
            
            effectViewLike.layer.cornerRadius = AppTheme.Radius.sm
            effectViewLike.backgroundColor = AppTheme.Colors.matchLike.withAlphaComponent(0.7)
            
            effectViewNope.layer.cornerRadius = AppTheme.Radius.sm
            effectViewNope.backgroundColor = AppTheme.Colors.matchNope.withAlphaComponent(0.7)
            
            effectViewSuperLike.layer.cornerRadius = AppTheme.Radius.sm
            effectViewSuperLike.backgroundColor = AppTheme.Colors.matchSuperLike.withAlphaComponent(0.7)
        }
    }
    
    
    // Setup
    func setup(_ model: CardModel) {
        
        tag = model.id
        imageViewProduct.kf.setImage(with: URL(string: model.url))
        labelName.text = model.name
        labelDistance.text = model.distance
        
        layoutIfNeeded()
    }
    
    
    // Handler animation
    func animationDidLike() {
        UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0, options: .curveEaseInOut) {
            self.effectViewLike.alpha = 1.0
            self.imageViewLike.alpha = 1.0
        }
    }
    func animationDidNope() {
        UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0, options: .curveEaseInOut) {
            self.effectViewNope.alpha = 1.0
            self.imageViewNope.alpha = 1.0
        }
    }
    func animationSuperLike() {
        UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0, options: .curveEaseInOut) {
            self.imageViewSuperLike.alpha = 1.0
            self.effectViewSuperLike.alpha = 1.0
        }
    }
    func animationReset() {
        UIView.animate(withDuration: AppConfig.Animation.duration, delay: 0, options: .curveEaseInOut) {
            self.effectViewNope.alpha = 0.0
            self.imageViewNope.alpha = 0.0
            self.effectViewLike.alpha = 0.0
            self.imageViewLike.alpha = 0.0
            self.effectViewSuperLike.alpha = 0.0
            self.imageViewSuperLike.alpha = 0.0
        }
    }
    
    
}
