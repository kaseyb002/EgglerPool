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
    
    func fadeIn(duration: Double = 0.3) {
        alpha = 0.0
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
}
