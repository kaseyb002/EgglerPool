import UIKit

class TimeslotTVCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var driverNameLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cardView.drawCardShadow()
    }
}

//MARK: - Update UI
extension TimeslotTVCell {
    
    private func updateCell(withTimeslot timeslot: Timeslot) {
        driverNameLabel.text = timeslot.driver.firstName
        call(after: 0.1) { self.setNeedsLayout() }
    }
}

//MARK: - TableViewCell
extension TimeslotTVCell {
    
    static let rowHeight: CGFloat = 200
    
    static func makeCell(withTimeslot timeslot: Timeslot,
                         tableView: UITableView,
                         indexPath: IndexPath) -> TimeslotTVCell {
        let cell = make(tableViewCell: self,
                        tableView: tableView,
                        indexPath: indexPath)
        cell.updateCell(withTimeslot: timeslot)
        return cell
    }
}
