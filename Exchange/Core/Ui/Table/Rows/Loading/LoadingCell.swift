import UIKit
import DotLottie


class LoadingCell: UITableViewCell, NibLoadableCell {
    
    
    // Var's
    @IBOutlet var animationView: UIView!
    private var doLottieAnimationView: DotLottieAnimationView?
    
    
    struct Model {
        var height: CGFloat?
    }
    
    
    // Setup
    func setup(model: LoadingCell.Model) {
        
        doLottieAnimationView?.removeFromSuperview()
        
        let animation = DotLottieAnimation(
            fileName: "loading-list",
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
