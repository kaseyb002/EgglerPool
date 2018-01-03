import UIKit

class DayCVCell: UICollectionViewCell {
    
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var weekdayLabel: UILabel!
    @IBOutlet weak var calDayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
}

//MARK: - Update Cell
extension DayCVCell {
    
    private func updateCell(withDate date: Date, isSelected: Bool) {
        weekdayLabel.text = date.string("EEE")
        calDayLabel.text = date.string("d")
        monthLabel.text = date.string("MMM")
        myView.layer.borderColor = Color.airbnbGray.withAlphaComponent(0.3).cgColor
        myView.layer.borderWidth = 1.0
        myView.backgroundColor = isSelected ? Color.airbnbGray : UIColor.white
        weekdayLabel.textColor = isSelected ? UIColor.white : Color.airbnbGray
        calDayLabel.textColor = isSelected ? UIColor.white : Color.airbnbGray
        monthLabel.textColor = isSelected ? UIColor.white : Color.airbnbGray
    }
}

//MARK: - Make Cell
extension DayCVCell {
    
    static func makeCell(withDate date: Date,
                         isSelected: Bool,
                         collectionView: UICollectionView,
                         indexPath: IndexPath) -> DayCVCell {
        let cell = make(collectionViewCell: self,
                        collectionView: collectionView,
                        indexPath: indexPath)
        cell.updateCell(withDate: date, isSelected: isSelected)
        return cell
    }
}
