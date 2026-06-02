import UIKit


protocol MatchFilterTagListDisplayLogic: AnyObject {
    func onLoad(viewModel: MatchFilterTagList.Load.ViewModel)
    func onLoadError(error: String)
    func onSelect(viewModel: MatchFilterTagList.Select.ViewModel)
    func onSave(viewModel: MatchFilterTagList.Save.ViewModel)
}


class MatchFilterTagListViewController: MainBaseViewController, MatchFilterTagListDisplayLogic {
  
    
    // Var's
    var interactor: MatchFilterTagListBusinessLogic?
    var router: (NSObjectProtocol & MatchFilterTagListRoutingLogic & MatchFilterTagListDataPassing)?

    @IBOutlet var viewLoading: UIActivityIndicatorView!
    @IBOutlet var buttonCount: UIBarButtonItem!
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
        self.navigationItem.title = "Match.Filter.Tags.Title".localized
    }
    
    
    // Setup inputs
    func setupInputs() {
       
        registerTableView()
        applyTableViewInsetsLg()
        
        if #available(iOS 13.0, *) {
            isModalInPresentation = true
        }
        
        buttonCount.title = "..."
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Handler load
    func load() {
        let request = MatchFilterTagList.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: MatchFilterTagList.Load.ViewModel) {
        rows = viewModel.list
        tableView?.reloadData()
        viewLoading.isHidden = true
        handlerCount()
    }
    func onLoadError(error: String) {
        displayAlert(nil, message: error)
        navigationController?.popViewController(animated: true)
    }
    
    
    // Handler save
    func save() {
        let request = MatchFilterTagList.Save.Request()
        interactor?.save(request: request)
        
    }
    func onSave(viewModel: MatchFilterTagList.Save.ViewModel) {
       // navigationController?.popViewController(animated: true)
    }
    
    
    // Handler count
    func handlerCount() {
        
        let total = rows.count
        let selected = rows.reduce(0) { result, row in
            guard case .default(let model) = row, model.style == .selected else {
                return result
            }
            return result + 1
        }
        
        if total == selected || selected == 0 {
            buttonCount.title = "Match.Filter.Tags.All".localized
        }
        else {
            buttonCount.title = "\(selected)/\(total)"
        }
        
    }


    // Handler select
    func select(index: Int) {
        selectionFeedback()
        let request = MatchFilterTagList.Select.Request(index: index)
        interactor?.select(request: request)
    }
    func onSelect(viewModel: MatchFilterTagList.Select.ViewModel) {
        rows = viewModel.list
        tableView?.reloadData()
        handlerCount()
        save()
    }
    
    
    // Handler clear
    func clear() {
        
        let alert = UIAlertController(
            title: "Match.Filter.Tags.Alert.Title".localized,
            message: "Match.Filter.Tags.Alert.Message".localized,
            preferredStyle: .actionSheet
        )
        
        let yes = UIAlertAction(title: "Match.Filter.Tags.Alert.Yes".localized, style: .default) { action in
            self.clearYes()
        }
        alert.addAction(yes)
        
        let cancel = UIAlertAction(title: "App.Cancel".localized, style: .cancel)
        alert.addAction(cancel)
        
        present(alert, animated: true)
        
    }
    func clearYes() {
        for index in rows.indices.reversed() {
            if case .default(let model) = rows[index], model.style == .selected {
                select(index: index)
            }
        }
        self.handlerCount()
        self.tableView?.reloadData()
    }
    
    
    // Handler actions
    @IBAction func didClear() {
        clear()
    }
    @IBAction func didSave() {
        buttonSave.showLoading()
        DispatchQueue.main.asyncAfter(deadline: .now() + (AppConfig.Animation.duration * 2)) {
            self.save()
        }
    }


    // Hooks
    override func didSelect(row: MainTableRow, at indexPath: IndexPath) {
        switch row {
        case .default:
            select(index: indexPath.row)
        default:
            break
        }
    }
    
    
    
}
