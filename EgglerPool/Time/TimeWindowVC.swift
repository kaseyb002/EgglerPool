import UIKit

class TimeWindowVC: UIViewController {

    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return "TimeWindowVC" }
    init(timeRangeTitle: String,
         day: Date,
         earliest: Date,
         latest: Date,
         setDayButtonPressed: @escaping Callback,
         setEarliestButtonPressed: @escaping Callback,
         setLatestButtonPressed: @escaping Callback) {
        self.timeRangeTitle = timeRangeTitle
        self.day = day
        self.earliest = earliest
        self.latest = latest
        self.setDayButtonPressed = setDayButtonPressed
        self.setEarliestButtonPressed = setEarliestButtonPressed
        self.setLatestButtonPressed = setLatestButtonPressed
        super.init(nibName: nil, bundle:nil)
    }

    //MARK: - Properties
    var day: Date {
        didSet {
            updateDay(withDate: day)
            //update times to make sure they're in sync
            earliest = earliest.update(toDay: day)
            latest = latest.update(toDay: day)
        }
    }
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
    private let setDayButtonPressed: Callback
    private let setEarliestButtonPressed: Callback
    private let setLatestButtonPressed: Callback
    
    //MARK: - Outlets
    @IBOutlet weak private var dayButton: UIButton!
    @IBOutlet weak private var setEarliestButton: UIButton!
    @IBOutlet weak private var setLatestButton: UIButton!
    @IBOutlet weak private var middleBar: UIView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setEarliestButton.layer.cornerRadius = 8
        setLatestButton.layer.cornerRadius = 8
        dayButton.layer.cornerRadius = 8
        middleBar.layer.cornerRadius = 1
        updateDay(withDate: day)
        updateEarliestTime(withDate: earliest)
        updateLatestTime(withDate: latest)
        setEarliestButton.drawShadow()
        setLatestButton.drawShadow()
        dayButton.drawShadow()
    }
    
    //MARK: - Actions
    @IBAction func setDayButtonPressed(_ sender: UIButton) {
        setDayButtonPressed()
    }
    
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
