import UIKit


protocol AuthInputEmailDisplayLogic: AnyObject {
    func onLoad(viewModel: AuthInputEmail.Load.ViewModel)
    func onSave(viewModel: AuthInputEmail.Save.ViewModel)
    func onSave(error: String)
}


class AuthInputEmailViewController: AuthMainBaseViewController, AuthInputEmailDisplayLogic {
  
    
    // Var's
    var interactor: AuthInputEmailBusinessLogic?
    var router: (NSObjectProtocol & AuthInputEmailRoutingLogic & AuthInputEmailDataPassing)?
    
    @IBOutlet var buttonSave: UIButtonBase!

  
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
        handlerProgress()
    }
    
    
    // Setup inputs
    func setupInputs() {
        registerTableView()
        addTapToDismissKeyboard()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        AppAnalytics.shared.log(.authInputEmailViewed)
    }
    
    
    // Handler load
    func load() {
        let request = AuthInputEmail.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: AuthInputEmail.Load.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
        handlerButtonSave()
    }
    
    
    // Handler progress
    func handlerProgress() {
        if let nav = parent?.parent as? AuthMainViewController {
            nav.handlerProgress()
        }
    }

    
    // Handler save
    func save() {
        
        if rowsIsValid() {
            showLoading()
            let email = rows.inputTextValue(identifier: .Email)
            let request = AuthInputEmail.Save.Request(email: email)
            interactor?.save(request: request)
        }
        
    }
    func onSave(viewModel: AuthInputEmail.Save.ViewModel) {
        hideLoading()
        AppHaptics.success()
        performSegue(withIdentifier: "Next", sender: nil)
    }
    func onSave(error: String) {
        hideLoading()
        AppHaptics.error()
    }
    
    
    // Handler button save
    func handlerButtonSave() {
        buttonSave.isEnabled = !rowsIsEmpty()
    }
    
    // Handler loading
    func showLoading() {
        self.buttonSave.isEnabled = false
    }
    func hideLoading() {
        self.buttonSave.isEnabled = true
    }
    
    
    // Handler actions
    @IBAction func didBack() {
        if let nav = parent?.parent as? AuthMainViewController {
            nav.navigationController?.popViewController(animated: true)
        }
    }
    @IBAction func didSave() {
        AppHaptics.tap()
        save()
    }
    
    
    // Hook
    override
    func configureCell(_ cell: UITableViewCell, for row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .inputText:
            (cell as? InputTextCell)?.delegate = self
        default:
            break
        }
    }
    
    
}
