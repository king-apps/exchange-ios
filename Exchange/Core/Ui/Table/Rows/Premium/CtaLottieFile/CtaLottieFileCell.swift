import UIKit
import DotLottie

class CtaLottieFileCell: UITableViewCellBase, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var animationView: UIView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var labelCta: UILabel!
    private var doLottieAnimationView: DotLottieAnimationView?
    
    
    // Model
    struct Model {
        let title: String?
        let description: String?
        let cta: String?
        let lottieFile: String?
    }
    
    
    // Setup
    func setup(model: Model) {
        
        labelTitle.text = model.title
        
        if let description = model.description, !description.isEmpty {
            labelDescription.text = model.description
        }
        else {
            labelDescription.removeFromSuperview()
        }
        
        if let cta = model.cta, !cta.isEmpty {
            labelCta.text = cta
        }
        else {
            labelCta.removeFromSuperview()
        }
        
        
       
        doLottieAnimationView?.removeFromSuperview()
        if let lottie = model.lottieFile {
            let animation = DotLottieAnimation(
                fileName: lottie,
                config: .init(
                    autoplay: true,
                    loop: true
                )
            )
            let view = DotLottieAnimationView(dotLottieViewModel: animation)
            animationView.addSubview(view)
            
            view.translatesAutoresizingMaskIntoConstraints = false
            view.contentMode = .scaleAspectFit
            
            NSLayoutConstraint.activate([
                view.leadingAnchor.constraint(equalTo: animationView.leadingAnchor),
                view.trailingAnchor.constraint(equalTo: animationView.trailingAnchor),
                view.topAnchor.constraint(equalTo: animationView.topAnchor),
                view.bottomAnchor.constraint(equalTo: animationView.bottomAnchor)
            ])
            
            doLottieAnimationView = view
        }
        
    }
    
}
