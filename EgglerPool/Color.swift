import UIKit

struct Color {
    
    /**
     Creates a color based on the price
     
     lower = more red
     
     medium = yellow
     
     higher = more green
     */
    static func color(forPrice price: Int) -> UIColor {
        if price.isBetween(0, and: 11) {
            let green = Float(Double(price) * 23.0 / 255.0)
            return UIColor(red: 255/255,
                           green: CGFloat(green),
                           blue: 0/255,
                           alpha: 1.0)
        } else if price.isBetween(12, and: 24) {
            let red = Float(Double(24 - price) * 23.0 / 255.0)
            return UIColor(red: CGFloat(red),
                           green: 255/255,
                           blue: 0/255,
                           alpha: 1.0)
        }
        return UIColor(red: 0/255,
                       green: 255/255,
                       blue: 0/255,
                       alpha: 1.0)
    }
}
