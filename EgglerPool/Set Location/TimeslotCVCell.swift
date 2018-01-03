import UIKit

class TimeslotCVCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        priceBackgroundView.layer.cornerRadius = priceBackgroundView.frame.width / 2
        priceBackgroundView.backgroundColor = Color.mainPurple
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.drawCardShadow()
    }

    //MARK: - Outlets
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceBackgroundView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var driverImageView: UIImageView!
    @IBOutlet weak var driverNameLabel: UILabel!
}

//MARK: - Update Cell
extension TimeslotCVCell {
    
    private func updateCell(withTimeslot timeslot: Timeslot) {
        priceLabel.text = "\(Int(timeslot.price))"
        driverNameLabel.text = timeslot.driver.name
        driverImageView.makeRound()
        call(after: 0.1) { self.setNeedsLayout() }
    }
}

//MARK: - Make Cell
extension TimeslotCVCell {
    
    static func makeCell(withTimeslot timeslot: Timeslot,
                         collectionView: UICollectionView,
                         indexPath: IndexPath) -> TimeslotCVCell {
        let cell = make(collectionViewCell: self,
                        collectionView: collectionView,
                        indexPath: indexPath)
        cell.updateCell(withTimeslot: timeslot)
        return cell
    }
}
