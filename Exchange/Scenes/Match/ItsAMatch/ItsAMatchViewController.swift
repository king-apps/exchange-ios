import UIKit
import Kingfisher


protocol ItsAMatchDelegate {
    func itsAMatchDidChat()
}


protocol ItsAMatchDisplayLogic: AnyObject {
    func onLoad(viewModel: ItsAMatch.Load.ViewModel)
}


class ItsAMatchViewController: MainBaseViewController, ItsAMatchDisplayLogic {
  
    
    // Var's
    var interactor: ItsAMatchBusinessLogic?
    var router: (NSObjectProtocol & ItsAMatchRoutingLogic & ItsAMatchDataPassing)?
    
    @IBOutlet var imageViewProduct: UIImageView!
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelDescription: UILabel!
    @IBOutlet var imageViewCategory: UIImageView!
    var delegate: ItsAMatchDelegate?

  
    // Constructor
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
  
    // Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputs()
        load()
    }
  
    
    // Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnalytics()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // Setup inputs
    func setupInputs() {
        
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = ItsAMatch.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: ItsAMatch.Load.ViewModel) {
        imageViewProduct.kf.setImage(with: URL(string: viewModel.image))
        labelName.text = viewModel.name
        labelDescription.text = viewModel.description
        
        if !viewModel.categoryUrl.isEmpty {
            imageViewCategory.layer.cornerRadius = imageViewCategory.bounds.width * 0.5
            imageViewCategory.clipsToBounds = true
            //imageViewCategory.kf.setImage(with: URL(string: viewModel.categoryUrl))
            imageViewCategory.image = UIImage(named: viewModel.categoryUrl)
            imageViewCategory.contentMode = .scaleAspectFit
            imageViewCategory.layer.borderWidth = 3.0
            imageViewCategory.layer.borderColor = UIColor.white.cgColor
        }
        else {
            imageViewCategory.isHidden = true
        }
    }
    
    
    // Handler actions
    @IBAction func didContinue() {
        dismiss(animated: true)
    }
    @IBAction func didChat() {
        dismiss(animated: true) {
            self.delegate?.itsAMatchDidChat()
        }
    }
    
    
}
