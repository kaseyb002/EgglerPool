import UIKit
import MapKit

class TimeslotAnnotationView: MKAnnotationView {

    init(price: String) {
        let lbl = UILabel(frame: CGRect(x: 0,
                                        y: 0, 
                                        width: 40,
                                        height: 40))
        lbl.backgroundColor = UIColor.clear
        lbl.font = UIFont(name: "Avenir-Heavy",
                          size: 17.0)
        lbl.textColor = Color.mainPurple.withAlphaComponent(0.8)
        lbl.text = price
        super.init(annotation: nil, reuseIdentifier: "timeslotPoint")
        self.addSubview(lbl)
        self.canShowCallout = true
        self.frame = lbl.frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
