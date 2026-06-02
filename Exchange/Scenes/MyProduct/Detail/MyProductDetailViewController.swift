import UIKit
import Kingfisher


protocol MyProductDetailDisplayLogic: AnyObject {
    func onLoad(viewModel: MyProductDetail.Load.ViewModel)
    func onSave(viewModel: MyProductDetail.Save.ViewModel)
    func onSaveError(error: String)
    func onRemove(viewModel: MyProductDetail.Remove.ViewModel)
    func onRemoveError(error: String)
}


class MyProductDetailViewController: MainBaseViewController, MyProductDetailDisplayLogic {
  
    
    // Var's
    var interactor: MyProductDetailBusinessLogic?
    var router: (NSObjectProtocol & MyProductDetailRoutingLogic & MyProductDetailDataPassing)?
    
    @IBOutlet var labelName: UILabel!
    @IBOutlet var labelCategory: UILabel!
    @IBOutlet var imageViewCategory: UIImageView!
    //@IBOutlet var labelConservation: UILabel!
    //@IBOutlet var labelDescription: UILabel!
    @IBOutlet var buttonSave: UIButtonBase!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var imageViewProduct0: UIImageView!
    @IBOutlet var imageViewProduct1: UIImageView!
    @IBOutlet var imageViewProduct2: UIImageView!
    
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "MyProduct.Detail.Title".localized
    }
    
    
    // Setup inputs
    func setupInputs() {
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
        let request = MyProductDetail.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: MyProductDetail.Load.ViewModel) {
        labelName.text = viewModel.name
        labelCategory.text = viewModel.category
        //labelConservation.text = viewModel.conservation
        //labelDescription.text = viewModel.description
        
        if let url = viewModel.categoryUrl {
            imageViewCategory.layer.cornerRadius = imageViewCategory.bounds.width * 0.5
            imageViewCategory.clipsToBounds = true
            imageViewCategory.kf.setImage(with: URL(string: url))
            imageViewCategory.contentMode = .scaleAspectFit
        }
        
        var i: Int = 0
        for image in viewModel.images {
            if !image.isEmpty {
                if i == 0 {
                    imageViewProduct0.kf.setImage(with: URL(string: image))
                    imageViewProduct0.superview?.isHidden = false
                }
                if i == 1 {
                    imageViewProduct1.kf.setImage(with: URL(string: image))
                    imageViewProduct1.superview?.isHidden = false
                }
                if i == 2 {
                    imageViewProduct2.kf.setImage(with: URL(string: image))
                    imageViewProduct2.superview?.isHidden = false
                }
            }
            i += 1
        }
        
        handlerButtonSave()
    }
    
    
    // Handler save
    func save() {
        let images = [
            imageViewProduct0.image,
            imageViewProduct1.image,
            imageViewProduct2.image
        ]
        let request = MyProductDetail.Save.Request(images: images)
        interactor?.save(request: request)
    }
    func onSave(viewModel: MyProductDetail.Save.ViewModel) {
        buttonSave.hideLoading()
       // NotificationCenter.default.post(Notification(name: kNotificationProductLoad))
        navigationController?.popToRootViewController(animated: true)
    }
    func onSaveError(error: String) {
        buttonSave.hideLoading()
        displayAlert(nil, message: error)
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
        let didLibrary = UIAlertAction(title: "App.Library".localized, style: .default) { (action) in
            self.openLibary()
        }
        alert.addAction(didLibrary)
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
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.mediaTypes = ["public.image"]
        vc.allowsEditing = false
        vc.delegate = self
        DispatchQueue.main.async {
            self.present(vc, animated: true)
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
    
    
    // Handler button save
    func handlerButtonSave() {
        let images = listImageView.filter({$0.image != nil})
        buttonSave.isEnabled = images.count > 0
    }
    
    
    // Handler remove
    func handlerRemove() {
        let alert = UIAlertController(
            title: "MyProduct.Detail.Remove.Title".localized.replacingOccurrences(of: "{$0}", with: labelName.text!),
            message: "MyProduct.Detail.Remove.Message".localized,
            preferredStyle: .actionSheet
        )
        let didRemove = UIAlertAction(title: "App.Delete".localized, style: .destructive) { (action) in
            self.remove()
        }
        alert.addAction(didRemove)
        let didClose = UIAlertAction(title: "App.Cancel".localized, style: .cancel) { (action) in
            
        }
        alert.addAction(didClose)
        present(alert, animated: true, completion: nil)
    }
    func remove() {
        let request = MyProductDetail.Remove.Request()
        interactor?.remove(request: request)
    }
    func onRemove(viewModel: MyProductDetail.Remove.ViewModel) {
     //   NotificationCenter.default.post(Notification(name: kNotificationProductLoad))
        navigationController?.popToRootViewController(animated: true)
    }
    func onRemoveError(error: String) {
        displayAlert(nil, message: error)
    }
    
    
    // Handler actions
    @IBAction func didSave() {
        navigationController?.popToRootViewController(animated: true)
        /*
        buttonSave.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
            self.save()
        }
        */
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
    @IBAction func didRemove() {
        handlerRemove()
    }
    
    
}
