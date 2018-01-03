import UIKit
import MapKit
import Font_Awesome_Swift

class ViewTimeslotsVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(earliest: Date,
         latest: Date,
         pickupSpot: CLLocationCoordinate2D,
         destination: Location) {
        self.earliest = earliest
        self.latest = latest
        self.pickupSpot = pickupSpot
        self.destination = destination
        self.timeslotsInWindows = MockData.makeRandomTimeslots(inTimeWindow: TimeWindow(startTime: earliest, endTime: latest),
                                                               pickupSpot: pickupSpot,
                                                               count: 15,
                                                               minInEachWindow: 2)
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    var earliest: Date {
        didSet {
            updateDay()
            updateTimeRange()
        }
    }
    var latest: Date {
        didSet {
            updateDay()
            updateTimeRange()
        }
    }
    var pickupSpot: CLLocationCoordinate2D {
        didSet {
            updatePickupLocation()
        }
    }
    var destination: Location {
        didSet {
            updateDestination()
        }
    }
    private var timeslotsInWindows: [TimeslotsInWindow] {
        didSet {
            timeslotsTVC.timeslotsInWindows = timeslotsInWindows
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var timeslotsView: UIView!
    @IBOutlet weak var dayIcon: UILabel!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var timeRangeIcon: UILabel!
    @IBOutlet weak var timeRangeButton: UIButton!
    @IBOutlet weak var pickupIcon: UILabel!
    @IBOutlet weak var pickupLocationButton: UIButton!
    @IBOutlet weak var downIcon: UILabel!
    @IBOutlet weak var destinationIcon: UILabel!
    @IBOutlet weak var destinationButton: UIButton!
    @IBOutlet var grayIcons: [UILabel]!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        downIcon.setFAIcon(icon: FAType.FAArrowDown, iconSize: 12.0)
        pickupIcon.setFAIcon(icon: FAType.FACar, iconSize: 20.0)
        destinationIcon.setFAIcon(icon: FAType.FAMapMarker, iconSize: 20.0)
        dayIcon.setFAIcon(icon: FAType.FACalendar, iconSize: 25.0)
        timeRangeIcon.setFAIcon(icon: FAType.FAClockO, iconSize: 25.0)
        grayIcons.forEach { $0.setFAColor(color: Color.airbnbGray) }
        load(timeslotsTVC, into: timeslotsView)
        updateUI()
    }
    
    //MARK: - Child VCs
    private lazy var timeslotsTVC = TimeslotsTVC(timeslotsInWindow: self.timeslotsInWindows) { timeslot in
        self.view(timeslot: timeslot)
    }
}

//MARK: - Go Tos
extension ViewTimeslotsVC {
    
    private func view(timeslot: Timeslot) {
        okAlert(title: "Coming Soon")
    }
}

//MARK: - UI Updates
extension ViewTimeslotsVC {
    
    private func updateUI() {
        updateDay()
        updateTimeRange()
        updatePickupLocation()
        updateDestination()
    }
    
    private func updateDay() {
        dayButton.setTitle(earliest.string("EEEE, MMM d"), for: .normal)
    }
    
    private func updateTimeRange() {
        timeRangeButton.setTitle(earliest.string("h:mm a").lowercased() + " - " + latest.string("h:mm a").lowercased(), for: .normal)
    }
    
    private func updatePickupLocation() {
        pickupLocationButton.setTitle(pickupSpot.latLngDisplay(), for: .normal)
        CLGeocoder().reverseGeocodeLocation(pickupSpot.cllocation) {
            [weak self] (placemarks, error) in
            placemarks?.first?.name.map {
                self?.pickupLocationButton.setTitle($0, for: .normal)
            }
        }
    }
    
    private func updateDestination() {
        destinationButton.setTitle(destination.name, for: .normal)
    }
}
