import UIKit


protocol MyProductListDisplayLogic: AnyObject {
    func onLoad(viewModel: MyProductList.Load.ViewModel)
    func onFetch(viewModel: MyProductList.Fetch.ViewModel)
    func onFetch(error: String)
    func onDetail(viewModel: MyProductList.Detail.ViewModel)
    func onDelete(viewModel: MyProductList.Delete.ViewModel)
}


class MyProductListViewController: MainBaseViewController, MyProductListDisplayLogic {
  
    
    // Var's
    var interactor: MyProductListBusinessLogic?
    var router: (NSObjectProtocol & MyProductListRoutingLogic & MyProductListDataPassing)?
    
    @IBOutlet var buttonAdd: UIButton!

  
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
        setupNotification()
    }
  
    
    // Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAnalytics()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "MyProduct.List.Title".localized
    }
    
    
    // Setup inputs
    func setupInputs() {
        registerTableView()
        status = .loading
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.addSubview(UIActivityIndicatorView(style: .medium))
        refreshControl.tintColor = UIColor(named: "BrandPrimary500")
        tableView?.refreshControl = refreshControl
    }
    
    
    // Setup analytics
    func setupAnalytics() {
        
    }
    
    
    // Setup notification
    func setupNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refresh),
            name: .reloadProductList,
            object: nil
        )
    }
    
    
    // Handler load
    func load() {
        let request = MyProductList.Load.Request()
        interactor?.load(request: request)
    }
    func onLoad(viewModel: MyProductList.Load.ViewModel) {
        fetch()
    }
  
    
    // Handler fetch
    @objc
    func fetch() {
        let request = MyProductList.Fetch.Request()
        interactor?.fetch(request: request)
    }
    func onFetch(viewModel: MyProductList.Fetch.ViewModel) {
        status = .ready
        self.rows = viewModel.rows
        self.tableView?.refreshControl?.endRefreshing()
        tableView?.reloadData()
    }
    func onFetch(error: String) {
        displayAlert(nil, message: error)
        status = .ready
        self.tableView?.refreshControl?.endRefreshing()
        self.tableView?.reloadData()
    }
    
    
    
    // Handler delete
    func delete(indexPath: IndexPath) {
        /*
        let id = list[indexPath.section].products[indexPath.row].id
        list[indexPath.section].products.remove(at: indexPath.row)
        
        if list[indexPath.section].products.count == 0 && list.count == 1 {
            list.removeAll()
            tableView.reloadData()
        }
        else {
            DispatchQueue.main.async {
                self.tableView.beginUpdates()
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.endUpdates()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
                if self.list[indexPath.section].products.count == 0 {
                    self.list.remove(at: indexPath.section)
                    self.tableView.beginUpdates()
                    self.tableView.deleteSections([indexPath.section], with: .fade)
                    self.tableView.endUpdates()
                }
            }
        }
        
        let request = MyProductList.Delete.Request(id: id)
        interactor?.delete(request: request)
        */
    }
    func onDelete(viewModel: MyProductList.Delete.ViewModel) {
    }
    
    
    // Handler refresh
    @objc
    func refresh() {
        fetch()
    }
    
    
    // Handler detail
    func detail(id: Int) {
        let request = MyProductList.Detail.Request(id: id)
        interactor?.detail(request: request)
    }
    func onDetail(viewModel: MyProductList.Detail.ViewModel) {
        DispatchQueue.main.asyncAfter(deadline: .now() + AppConfig.Animation.duration) {
            self.performSegue(withIdentifier: "Detail", sender: nil)
        }
    }
    
    
}
