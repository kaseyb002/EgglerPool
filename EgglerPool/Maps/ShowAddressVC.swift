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
    @IBOutlet weak private var streetAddressLabel: UILabel!
    @IBOutlet weak private var cityStateZipLabel: UILabel!
    @IBOutlet weak private var mapView: MKMapView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateAddress()
        updateMap()
    }
}

//MARK: - Update UI
extension ShowAddressVC {
    
    private func updateAddress() {
        streetAddressLabel.text = location.streetAddress ?? location.formattedAddress
        cityStateZipLabel.text = location.cityState
        cityStateZipLabel.isHidden = location.cityState == nil
    }
    
    private func updateMap() {
        let point = MKPointAnnotation()
        point.coordinate = location.coordinate
        mapView.addAnnotation(point)
        mapView.moveTo(location: location.coordinate,
                       metersZoomed: MapZoomLevel.neighborhoodLevel.rawValue)
    }
}

