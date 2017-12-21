import UIKit

class TimeWindowVC: UIViewController {

    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return "TimeWindowVC" }
    init(timeRangeTitle: String,
         earliest: Date,
         latest: Date,
         setEarliestButtonPressed: @escaping () -> (),
         setLatestButtonPressed: @escaping () -> ()) {
        self.timeRangeTitle = timeRangeTitle
        self.earliest = earliest
        self.latest = latest
        self.setEarliestButtonPressed = setEarliestButtonPressed
        self.setLatestButtonPressed = setLatestButtonPressed
        super.init(nibName: nil, bundle:nil)
    }

    //MARK: - Properties
    var earliest: Date {
        didSet {
            updateEarliestTime(withDate: earliest)
        }
    }
    var latest: Date {
        didSet {
            updateLatestTime(withDate: latest)
        }
    }
    private let timeRangeTitle: String
    private let setEarliestButtonPressed: () -> ()
    private let setLatestButtonPressed: () -> ()
    
    //MARK: - Outlets
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var setEarliestButton: UIButton!
    @IBOutlet weak var setLatestButton: UIButton!
    @IBOutlet weak var middleBar: UIView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setEarliestButton.layer.cornerRadius = 8
        setLatestButton.layer.cornerRadius = 8
        dayButton.layer.cornerRadius = 8
        middleBar.layer.cornerRadius = 1
        updateDay(withDate: earliest)
        updateEarliestTime(withDate: earliest)
        updateLatestTime(withDate: latest)
        setEarliestButton.drawShadow()
        setLatestButton.drawShadow()
        dayButton.drawShadow()
    }
    
    //MARK: - Actions
    @IBAction func setEarliestButtonPressed(_ sender: UIButton) {
        setEarliestButtonPressed()
    }
    
    @IBAction func setLatestButtonPressed(_ sender: UIButton) {
        setLatestButtonPressed()
    }
}

//MARK: - UI Updates
extension TimeWindowVC {
    
    private func updateDay(withDate date: Date) {
        dayButton.setTitle(date.string("EEE, MMM d"), for: .normal)
    }
    
    private func updateEarliestTime(withDate date: Date) {
        setEarliestButton.setTitle(date.string("h:mm a").lowercased(), for: .normal)
    }
    
    private func updateLatestTime(withDate date: Date) {
        setLatestButton.setTitle(date.string("h:mm a").lowercased(), for: .normal)
    }
}
