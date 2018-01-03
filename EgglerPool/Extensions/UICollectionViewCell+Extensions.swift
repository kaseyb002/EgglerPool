import UIKit

extension UICollectionViewCell {
    
    static func make<T: UICollectionViewCell>(collectionViewCell: T.Type,
                                              collectionView: UICollectionView,
                                              indexPath: IndexPath) -> T {
        let className = String(describing: T.self)
        let nib = UINib(nibName: className, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: className)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: className, for: indexPath) as! T
        return cell
    }
}
