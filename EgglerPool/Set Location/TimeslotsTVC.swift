import UIKit

class TimeslotsTVC: UITableViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(searchForm: TimeslotSearchForm) {
        self.searchForm = searchForm
        super.init(nibName: nil, bundle:nil)
    }
    
    private let searchForm: TimeslotSearchForm
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
