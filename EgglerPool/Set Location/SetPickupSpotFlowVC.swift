import UIKit
import MapKit

class SetPickupSpotFlowVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(searchForm: TimeslotSearchForm) {
        self.searchForm = searchForm
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    private var searchForm: TimeslotSearchForm
    
    //MARK: - Outlets
    @IBOutlet weak var setPickupSpotView: UIView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        load(setSpotVC, into: setPickupSpotView)
    }

    //MARK: - Child VCs
    private lazy var setSpotVC: SetSpotVC = {
        let callback: (Date, Date, CLLocationCoordinate2D) -> () = { (earliest, latest, location) in
            self.goToTimeslots(earliest: earliest, latest: latest, location: location)
        }
        return SetSpotVC(spotType: .pickup,
                         initialLocation: nil,
                         setSpot: callback)
    }()
}

//MARK: - Go Tos
extension SetPickupSpotFlowVC {
    
    private func goToTimeslots(earliest: Date, latest: Date, location: CLLocationCoordinate2D) {
        searchForm.earliest = earliest
        searchForm.latest = latest
        searchForm.pickupSpot = location
        let vc = TimeslotsTVC(searchForm: searchForm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
