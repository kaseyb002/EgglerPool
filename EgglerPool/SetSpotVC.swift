import UIKit
import Font_Awesome_Swift
import MapKit

class SetSpotVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(spotType: SpotType) {
        self.spotType = spotType
        super.init(nibName: nil, bundle:nil)
    }
    
    enum SpotType {
        case pickup
        case destination
    }
    
    //MARK: - Properties
    private let spotType: SpotType
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        return manager
    }()
    
    //MARK: - Outlets
    @IBOutlet weak var timeRangeView: UIView!
    @IBOutlet weak var timeslotMapView: UIView!
    @IBOutlet weak var setSpotButtonsView: UIView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadChildren()
        getCurrentLocation()
    }
    
    //MARK: - Child VCs
    private let timeslotMapVC = TimeslotMapVC()
    
    private lazy var setSpotButtonsVC: SetSpotButtonsVC = {
        return SetSpotButtonsVC(buttonTitle: spotType.buttonTitle,
                                setSpotButtonPressed: { self.okAlert(title: "Next Part Coming Soon!") },
                                currentLocationButtonPressed: { self.getCurrentLocation() },
                                searchButtonPressed: { self.searchLocation() })
    }()
    
    private lazy var timeWindowVC: TimeWindowVC = {
        return TimeWindowVC(timeRangeTitle: Date().addDays(1).string("EEE, MMM d"),
                            earliest: Date().startOfDay.addHours(6),
                            latest: Date().startOfDay.addHours(8),
                            setEarliestButtonPressed: { self.presentDark(vc: self.earliestVC, frame: self.earliestVCFrame) },
                            setLatestButtonPressed: { self.presentDark(vc: self.latestVC, frame: self.latestVCFrame) })
    }()
}

//MARK: - Actions
extension SetSpotVC {
    
    private func getCurrentLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    private func searchLocation() {
        okAlert(title: "Search coming soon!")
    }
}

//MARK: - Load Child VCs
extension SetSpotVC {
    
    private func loadChildren() {
        load(timeWindowVC, into: timeRangeView)
        load(timeslotMapVC, into: timeslotMapView)
        load(setSpotButtonsVC, into: setSpotButtonsView)
    }
}

//MARK: - Helpers for Transition
extension SetSpotVC {
    
    private var earliestVCFrame: CGRect {
        return self.view.frame.adjust(widthTo: 150).adjust(xBy: 50,
                                                           yBy: 50,
                                                           heightBy: -100)
    }
    
    private var latestVCFrame: CGRect {
        return self.view.frame.adjust(widthTo: 150).adjust(xBy: self.view.frame.width - 200,
                                                           yBy: 50,
                                                           heightBy: -100)
    }
    
    private var earliestVC: SetTimeVC {
        return SetTimeVC(titleForLabel: "Earliest",
                         minDate: Date().startOfDay.addHours(5),
                         maxDate: self.timeWindowVC.earliest) { newEarliest in
                            self.timeWindowVC.earliest = newEarliest
        }
    }
    
    private var latestVC: SetTimeVC {
        return SetTimeVC(titleForLabel: "Latest",
                         minDate: self.timeWindowVC.earliest.addMinutes(15),
                         maxDate: Date().addDays(1).startOfDay.addHours(-2)) { newLatest in
                            self.timeWindowVC.latest = newLatest
        }
    }
}

//MARK: - CLLocationManagerDelegate
extension SetSpotVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let location = manager.location?.coordinate else { return }
        timeslotMapVC.moveTo(location: location)
        timeslotMapVC.showTimeslotsOnMap(MockData.generateMockTimeslots(location: location, count: 8))
    }
}

//MARK: - Search Type + Extensions
extension SetSpotVC.SpotType {
    
    var buttonTitle: String {
        switch self {
        case .pickup:
            return "Set Pick Up Spot"
        case .destination:
            return "Set Destination"
        }
    }
}
