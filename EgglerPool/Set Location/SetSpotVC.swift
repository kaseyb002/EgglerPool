import UIKit
import Font_Awesome_Swift
import MapKit

class SetSpotVC: UIViewController, LocationManager {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(spotType: SpotType,
         initialLocation: CLLocationCoordinate2D?,
         setSpot: @escaping (Date, Date, CLLocationCoordinate2D) -> ()) {
        self.spotType = spotType
        self.initialLocation = initialLocation
        self.setSpot = setSpot
        super.init(nibName: nil, bundle:nil)
    }
    
    enum SpotType {
        case pickup
        case destination
    }
    
    //MARK: - Properties
    private let spotType: SpotType
    private let initialLocation: CLLocationCoordinate2D?
    private let setSpot: (Date, Date, CLLocationCoordinate2D) -> ()
    internal lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
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
        if let initialLocation = initialLocation {
            updateLocation(initialLocation)
        } else {
            getLocation()
        }
    }
    
    //MARK: - Child VCs
    private let timeslotMapVC = TimeslotMapVC()
    
    private lazy var setSpotButtonsVC: SetSpotButtonsVC = {
        return SetSpotButtonsVC(buttonTitle: spotType.buttonTitle,
                                setSpotButtonPressed: { self.setSpotPressed() },
                                currentLocationButtonPressed: { self.getLocation() },
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
    
    private func searchLocation() {
        okAlert(title: "Search coming soon!")
    }
    
    private func updateLocation(_ location: CLLocationCoordinate2D) {
        timeslotMapVC.moveTo(location: location, zoomLevel: spotType.mapZoomLevel)
        timeslotMapVC.showTimeslotsOnMap(MockData.generateMockTimeslots(location: location, count: 8))
    }
    
    private func setSpotPressed() {
        setSpot(timeWindowVC.earliest, timeWindowVC.latest, timeslotMapVC.center)
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

//MARK: - Set Time VCs
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
        updateLocation(location)
    }
}

//MARK: - Search Type + Extensions
extension SetSpotVC.SpotType {
    
    var buttonTitle: String {
        switch self {
        case .pickup:
            return "Set Pick Up Spot"
        case .destination:
            return "Confirm"
        }
    }
    
    var mapZoomLevel: MapZoomLevel {
        switch self {
        case .pickup:
            return .cityLevel
        case .destination:
            return .neighborhoodLevel
        }
    }
}
