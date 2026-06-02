import UIKit


protocol MatchFilterDisplayLogic: AnyObject {
    func onLoad(viewModel: MatchFilter.Load.ViewModel)
    func onFetch(viewModel: MatchFilter.Fetch.ViewModel)
    func onSave(viewModel: MatchFilter.Save.ViewModel)
}


protocol MatchFilterDelegate {
    func matchFilterDidClose()
}


class MatchFilterViewController: MainBaseViewController, MatchFilterDisplayLogic {
  
    
    // Var's
    var interactor: MatchFilterBusinessLogic?
    var router: (NSObjectProtocol & MatchFilterRoutingLogic & MatchFilterDataPassing)?
    
    var delegate: MatchFilterDelegate?
    
  
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
        load()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Match.Filter.Title".localized
    }
    
    
    // Disappear
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        delegate?.matchFilterDidClose()
    }
    
    
    // Setup inputs
    func setupInputs() {
        registerTableView()
        applyTableViewInsetsLg()
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = MatchFilter.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: MatchFilter.Load.ViewModel) {
        fetch()
    }
    
    
    // Handler fetch
    func fetch() {
        let request = MatchFilter.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: MatchFilter.Fetch.ViewModel) {
        rows = viewModel.rows
        tableView?.reloadData()
    }
    
    
    // Handler save
    func save() {
        let radius = rows.inputSliderValue(identifier: .radius)
        let request = MatchFilter.Save.Request(radius: radius)
        interactor?.save(request: request)
    }
    func onSave(viewModel: MatchFilter.Save.ViewModel) {
        
    }
    
    
    // Handler actions
    @IBAction func didClose() {
        dismiss(animated: true)
    }
    @IBAction func didSave() {
        dismiss(animated: true)
    }
    
    
    // Hooks
    override func configureCell(_ cell: UITableViewCell, for row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .inputSlider:
            (cell as? InputSliderCell)?.delegate = self
            break
        default: break
        }
    }
    override func didSelect(row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .inputSelect(let model):
            if model.identifier == .category {
                performSegue(withIdentifier: "Categories", sender: nil)
            }
            break
        default:
            break
        }
    }
    
    
}
