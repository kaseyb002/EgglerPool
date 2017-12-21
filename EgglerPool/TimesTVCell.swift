import UIKit

class TimesTVCell: UITableViewCell, TableViewCell {
    
    static let nibName = "TimesTVCell"
    static let reuseId = "TimesTVCell"
    static let rowHeight: CGFloat = 70
    
    static func makeCell(withStartTime start: Date,
                         endTime end: Date?,//leave nil if just want a time and not a range
                         tableView: UITableView,
                         indexPath: IndexPath) -> TimesTVCell {
        let cell = make(tableViewCell: self,
                        tableView: tableView,
                        indexPath: indexPath)
        cell.updateCell(withStartTime: start, endTime: end)
        return cell
    }
    
    @IBOutlet weak var timesLabel: UILabel!
    
    private func updateCell(withStartTime start: Date, endTime end: Date?) {
        let startString = start.string("h:mm a").lowercased()
        guard let end = end else {
            timesLabel.text = startString
            return
        }
        let endString = end.string("h:mm a").lowercased()
        timesLabel.text = startString + " – " + endString
    }
}
