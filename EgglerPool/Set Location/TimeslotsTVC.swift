import UIKit

class TimeslotsTVC: UITableViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(timeslotsInWindow: [TimeslotsInWindow],
         selectTimeslot: @escaping (Timeslot) -> ()) {
        self.timeslotsInWindows = timeslotsInWindow
        self.selectTimeslot = selectTimeslot
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    var timeslotsInWindows: [TimeslotsInWindow] {
        didSet {
            tableView.reloadData()
        }
    }
    private let selectTimeslot: (Timeslot) -> ()
}

//MARK: - Data Source
extension TimeslotsTVC {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return timeslotsInWindows.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let timeslots = timeslotsInWindows[indexPath.section].timeslots
        return TimeslotsTVCell.makeCell(withTimeslots: timeslots,
                                        selectTimeslot: selectTimeslot,
                                        tableView: tableView,
                                        indexPath: indexPath)
    }
}

//MARK: - Delegate
extension TimeslotsTVC {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TimeslotsTVCell.rowHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let timeWindow = timeslotsInWindows[section].timeWindow
        return TimeRangeHeaderView.makeView(timeWindow: timeWindow)
    }
}
