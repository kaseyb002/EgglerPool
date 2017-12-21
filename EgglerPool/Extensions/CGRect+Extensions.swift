import UIKit

extension CGRect {
    
    func adjust(xTo x: CGFloat? = nil,
                yTo y: CGFloat? = nil,
                widthTo width: CGFloat? = nil,
                heightTo height: CGFloat? = nil) -> CGRect {
        
        return CGRect(x: x ?? origin.x,
                      y: y ?? origin.y,
                      width: width ?? size.width,
                      height: height ?? size.height)
    }
    
    func adjust(xBy x: CGFloat? = nil,
                yBy y: CGFloat? = nil,
                widthBy width: CGFloat? = nil,
                heightBy height: CGFloat? = nil) -> CGRect {
        
        return CGRect(x: origin.x + (x ?? 0),
                      y: origin.y + (y ?? 0),
                      width: size.width + (width ?? 0),
                      height: size.height + (height ?? 0))
    }
}
