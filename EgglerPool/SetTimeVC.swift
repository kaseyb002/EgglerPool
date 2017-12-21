import UIKit

/**
 Let's user pick a time of the day
 */
class SetTimeVC: UIViewController {

    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return "SetTimeVC" }
    init(titleForLabel: String = "Set Time",
         minDate: Date,
         maxDate: Date,
         callback: @escaping (Date) -> ()) {
        self.titleForLabel = titleForLabel
        self.minDate = minDate
        self.maxDate = maxDate
        self.callback = callback
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    private let titleForLabel: String
    private let minDate: Date
    private let maxDate: Date
    private let callback: (Date) -> ()
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timesTableView: UIView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleForLabel
        let selectedCallback: (Date) -> () = { time in
            self.callback(time)
            self.dismiss(animated: true, completion: nil)
        }
        let timesVC = TimesTableVC(minDate: minDate,
                                   maxDate: maxDate,
                                   timeType: .time(callback: selectedCallback))
        load(timesVC, into: timesTableView)
    }
}

//MARK: - UIGestureRecognizerDelegate
extension SetTimeVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return !timesTableView.frame.contains(gestureRecognizer.location(in: timesTableView))
    }
}
