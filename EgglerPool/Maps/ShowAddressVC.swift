import UIKit
import MapKit

class ShowAddressVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(location: Location) {
        self.location = location
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    private let location: Location
    
    //MARK: - Outlets
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var cityStateZipLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAddress()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateMap()//will crash if we call it before appearing
    }
}

//MARK: - Update UI
extension ShowAddressVC {
    
    private func updateAddress() {
        streetAddressLabel.text = location.streetAddress
        cityStateZipLabel.text = location.city + ", " + location.state
    }
    
    private func updateMap() {
        let point = MKPointAnnotation()
        point.coordinate = location.coordinate
        mapView.addAnnotation(point)
        mapView.moveTo(location: location.coordinate,
                       metersZoomed: MapZoomLevel.streetLevel.rawValue)
    }
}

