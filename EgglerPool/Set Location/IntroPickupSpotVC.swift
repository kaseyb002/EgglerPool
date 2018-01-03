import UIKit
import MapKit
import Font_Awesome_Swift

class IntroPickupSpotVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(searchForm: TimeslotSearchForm) {
        self.searchForm = searchForm
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    private let searchForm: TimeslotSearchForm
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    //MARK: - Outlets
    @IBOutlet weak private var timeslotMapView: UIView!
    @IBOutlet weak private var findDriversButton: UIButton!
    
    override func viewDidLayoutSubviews() {
        timeslotMapView.drawCardShadow()
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        load(timeslotMapVC, into: timeslotMapView)
        view.backgroundColor = Color.mainPurple
        findDriversButton.setFAText(prefixText: "Find Drivers ",
                                    icon: FAType.FAAngleRight,
                                    postfixText: "",
                                    size: 50.0,
                                    forState: .normal)
        findDriversButton.setFATitleColor(color: UIColor.white)
        let coordinate: CLLocationCoordinate2D = {
            guard let location = searchForm.destination else { return MockData.spanishFork }
            return location.coordinate
        }()
        let mockSlots = MockData.generateMockTimeslots(coordinate: coordinate, count: 2)
        timeslotMapVC.showTimeslotsOnMap(mockSlots)
        timeslotMapVC.moveTo(location: coordinate, zoomLevel: MapZoomLevel.cityLevel)
    }
    
    @IBAction func findDriversButtonPressed(_ sender: UIButton) {
        goToSetPickupSpot()
    }
    
    private lazy var timeslotMapVC = TimeslotMapVC(hidePin: true, mapIsInteractive: false)
}

//MARK: - Go To
extension IntroPickupSpotVC {
    
    private func goToSetPickupSpot() {
        let vc = SetPickupSpotFlowVC(searchForm: searchForm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
