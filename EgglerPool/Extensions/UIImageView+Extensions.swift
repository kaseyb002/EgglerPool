import UIKit
import Kingfisher

extension UIImageView {
    
    func setImageKf(urlString: String?,
                    placeHolder: UIImage,
                    makeRound: Bool = true) {
        if let url = urlString {
            kf.setImage(with: URL(string: url)!, placeholder: placeHolder)
            if makeRound { self.makeRound() }
        } else {
            image = placeHolder
        }
    }
    
    func makeRound() {//from SO
        layer.masksToBounds = true
        layer.cornerRadius = frame.size.width/2
        clipsToBounds = true
    }
}
