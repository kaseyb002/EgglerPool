import UIKit
import MapKit
import Font_Awesome_Swift

/**
 Displays time slots on a mapview
 */
class TimeslotMapVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return "TimeslotMapVC" }
    init(hidePin: Bool = false) {
        self.hidePin = hidePin
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    private let hidePin: Bool
    private var circleOverlay: TimeslotCircle?
    private var circleRenderer: MKCircleRenderer?
    private var timeslotCircles = [MKCircle]()
    private var timeslotPoints = [TimeslotAnnotation]()

    //MARK: - Outlets
    @IBOutlet weak var pinLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pinLabel.setFAIcon(icon: FAType.FAMapMarker, iconSize: 35.0)
        pinLabel.setFAColor(color: UIColor.flatPlum())
        pinLabel.isHidden = hidePin
    }
    
    //MARK: - Public Actions
    func moveTo(location: CLLocationCoordinate2D, spanDegrees: Double = 0.3) {
        mapView.moveTo(location: location, spanDegrees: spanDegrees)
    }
    
    func showTimeslotsOnMap(_ timeslots: [Timeslot]) {
        resetMapView()
        //add new points
        timeslots.forEach { timeslot in
            let annotations = timeslot.pickupArea.map { circleArea in
                return TimeslotAnnotation(coord: circleArea.coordinate,
                                          price: Int(timeslot.price),
                                          infoMsg: timeslot.driver.name)
            }
            timeslotPoints.append(contentsOf: annotations)
        }
        
        mapView.showAnnotations(timeslotPoints, animated: true)
        drawTimeslotRadiuses(timeslots)
    }
    
    private func drawTimeslotRadiuses(_ timeslots: [Timeslot]) {
        //add in new circles
        timeslots.forEach { timeslot in
            timeslot.pickupArea.forEach { circleArea in
                //draw a circle
                let circle = TimeslotCircle(center: circleArea.coordinate,
                                            radius: circleArea.radius)
                circle.price = Int(timeslot.price)
                circle.type = .other
                timeslotCircles.append(circle)
                mapView.add(circle)
            }
        }
    }
    
    private func resetMapView() {
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(timeslotCircles)
        timeslotCircles.removeAll()
        timeslotPoints.removeAll()
    }
}

//MARK: - MKMapViewDelegate
extension TimeslotMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let ov = overlay as? TimeslotCircle {
            let circleRenderer = MKCircleRenderer(overlay: ov)
            if ov.type == .other, let price = ov.price {
                circleRenderer.fillColor = Color.color(forPrice: price).withAlphaComponent(0.2)
                return circleRenderer
            }
        }
        return MKCircleRenderer()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        return TimeslotAnnotationView(price: annotation.title!!)// ?? "?" ?? "?")
    }
}
