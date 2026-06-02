import UIKit
import Kingfisher


protocol MyProductInputImageDisplayLogic: AnyObject {
    func onLoad(viewModel: MyProductInputImage.Load.ViewModel)
    func onSave(viewModel: MyProductInputImage.Save.ViewModel)
    func onSaveError(error: String)
}


class MyProductInputImageViewController: MainBaseViewController, MyProductInputImageDisplayLogic {
  
    
    // Var's
    var interactor: MyProductInputImageBusinessLogic?
    var router: (NSObjectProtocol & MyProductInputImageRoutingLogic & MyProductInputImageDataPassing)?
    
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    //@IBOutlet weak var labelConservation: UILabel!
    //@IBOutlet weak var labelDescription: UILabel!
    @IBOutlet var buttonChange: UIButtonBase!
    @IBOutlet var buttonSave: UIButtonBase!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var imageViewProduct0: UIImageView!
    @IBOutlet var imageViewProduct1: UIImageView!
    @IBOutlet var imageViewProduct2: UIImageView!
    @IBOutlet var imageViewCategory: UIImageView!
    var listImageView = [UIImageView]()
  
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
        if status == .loading {
            status = .ready
            //openCamera()
            openLibary()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "MyProduct.InputImage.Title".localized
        
        if let nav = parent?.parent as? NewProductMainViewController {
            nav.handlerProgress()
        }
    }
    
    
    // Setup inputs
    func setupInputs() {
        status = .loading
        scrollView.delegate = self
        scrollView.isScrollEnabled = false
        pageControl.numberOfPages = 1
        listImageView.append(imageViewProduct0)
        listImageView.append(imageViewProduct1)
        listImageView.append(imageViewProduct2)
        handlerListImageView()
        handlerButtonSave()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = MyProductInputImage.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: MyProductInputImage.Load.ViewModel) {
        labelName.text = viewModel.name
        labelCategory.text = viewModel.category
        //labelConservation.text = viewModel.conservation
        //labelDescription.text = viewModel.description
        
        if let url = viewModel.categoryUrl {
            imageViewCategory.layer.cornerRadius = imageViewCategory.bounds.width * 0.5
            imageViewCategory.clipsToBounds = true
            imageViewCategory.image = UIImage(named: url)
            imageViewCategory.contentMode = .scaleAspectFit
        }
        
        buttonChange.tintColor = viewModel.color
        buttonSave.backgroundColor = viewModel.color
        
    }
    
    
    // Handler save
    func save() {
        let images = [
            imageViewProduct0.image,
            imageViewProduct1.image,
            imageViewProduct2.image
        ]
        let request = MyProductInputImage.Save.Request(images: images)
        interactor?.save(request: request)
    }
    func onSave(viewModel: MyProductInputImage.Save.ViewModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + (AppConfig.Animation.duration * 3), execute: {
            self.buttonSave.hideLoading()
            NotificationCenter.default.post(name: .reloadProductList, object: nil)
            if let nav = self.parent?.parent as? NewProductMainViewController {
                nav.navigationController?.popToRootViewController(animated: true)
            }
        })
    }
    func onSaveError(error: String) {
        buttonSave.hideLoading()
        displayAlert(nil, message: error)
    }
    
    
    // Handler button save
    func handlerButtonSave() {
        let images = listImageView.filter({$0.image != nil})
        buttonSave.isEnabled = images.count > 0
    }
    
    
    // Handler image
    func setImageForCurrentPage(image: UIImage?) {
        let page = pageControl.currentPage
        listImageView[page].image = image
        handlerListImageView()
        handlerButtonSave()
        handlerNexPage()
    }
    func handlerListImageView() {
        for imageView in listImageView {
            if let _ = imageView.image {
                imageView.superview?.isHidden = false
            }
            else {
                imageView.superview?.isHidden = true
            }
        }
    }
    func handlerImage() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        /*
        let didLibrary = UIAlertAction(title: "App.Library".localized, style: .default) { (action) in
            self.openLibary()
        }
        alert.addAction(didLibrary)
        */
        let didCamera = UIAlertAction(title: "App.Camera".localized, style: .default) { (action) in
            self.openCamera()
        }
        alert.addAction(didCamera)
        let didClose = UIAlertAction(title: "App.Close".localized, style: .cancel) { (action) in
            
        }
        alert.addAction(didClose)
        present(alert, animated: true, completion: nil)
    }
    func handlerImageChange() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let didImage = UIAlertAction(title: "App.Change".localized, style: .default) { (action) in
            self.handlerImage()
        }
        alert.addAction(didImage)
        let didRemove = UIAlertAction(title: "App.Remove".localized, style: .default) { (action) in
            self.setImageForCurrentPage(image: nil)
        }
        alert.addAction(didRemove)
        let didClose = UIAlertAction(title: "App.Close".localized, style: .cancel) { (action) in
            
        }
        alert.addAction(didClose)
        present(alert, animated: true, completion: nil)
    }
    func handlerNexPage() {
        
    }
    func openCamera() {
        
        if UIImagePickerController.isCameraDeviceAvailable(.rear) {
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.mediaTypes = ["public.image"]
            vc.allowsEditing = false
            vc.delegate = self
            DispatchQueue.main.async {
                self.present(vc, animated: true)
            }
        }
        else {
            displayAlert(nil, message: "App.Camera.Unavailable".localized)
        }
    }
    func openLibary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.allowsEditing = false
        vc.delegate = self
        DispatchQueue.main.async {
            self.present(vc, animated: true)
        }
    }
    
    
    // Handler actions
    @IBAction func didSave() {
        buttonSave.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
            self.save()
        }
    }
    @IBAction func addProductImage(sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
            self.handlerImage()
        }
    }
    @IBAction func changeProductImage(sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
            self.handlerImageChange()
        }
    }
    
    
}
