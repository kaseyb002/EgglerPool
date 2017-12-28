import UIKit

extension UIView {
    
    func drawShadow(color: UIColor = UIColor.black,
                    opacity: Float = 0.3,
                    radius: CGFloat? = nil,
                    offset: CGSize = CGSize(width: 1, height: 1),
                    clearBackground: Bool = false) {
        
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius ?? 5.0
        layer.shadowOffset = offset
        layer.masksToBounds = false
        if !clearBackground {//if filled background
            layer.shadowPath = UIBezierPath(rect: bounds).cgPath
            layer.shadowRadius = layer.cornerRadius
        }
    }
    
    func drawCardShadow() {
        layer.cornerRadius = 5
        layer.shadowOffset = CGSize(width: 0.0, height: 0.5)
        let path = UIBezierPath(rect: bounds)
        layer.shadowPath = path.cgPath
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
        layer.masksToBounds = false
    }
    
    func fadeIn(duration: Double = 0.3) {
        alpha = 0.0
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
}
