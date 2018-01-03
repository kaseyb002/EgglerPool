import UIKit

class TimesTVCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak private var timesLabel: UILabel!
}

//MARK: - Update UI
extension TimesTVCell {
    
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

//MARK: - Initializers
extension TimesTVCell {
    
    static let rowHeight: CGFloat = 70
    
    /**
     provide endTime to show a date range
     
     leave endTime nil to show a time only
     */
    static func makeCell(withStartTime start: Date,
                         endTime end: Date?,
                         tableView: UITableView,
                         indexPath: IndexPath) -> TimesTVCell {
        let cell = make(tableViewCell: self,
                        tableView: tableView,
                        indexPath: indexPath)
        cell.updateCell(withStartTime: start, endTime: end)
        return cell
    }
}
