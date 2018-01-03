import UIKit

class SetDayVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(startDate: Date,
         endDate: Date,
         daySelected: @escaping (Date) -> ()) {
        self.startDate = startDate.startOfDay
        self.endDate = endDate.startOfDay
        self.daySelected = daySelected
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    private let startDate: Date
    private let endDate: Date
    private let daySelected: (Date) -> ()
    
    //MARK: - Outlets
    @IBOutlet weak var daysView: UIView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        load(daysVC, into: daysView)
    }
    
    //MARK: - Child VCs
    private lazy var daysVC: DaysCollectionVC = {
        let callback: (Date) -> () = { date in
            self.daySelected(date)
            self.dismiss(animated: true, completion: nil)
        }
        return DaysCollectionVC(startDate: startDate,
                                endDate: endDate,
                                daySelected: callback)
    }()
}
