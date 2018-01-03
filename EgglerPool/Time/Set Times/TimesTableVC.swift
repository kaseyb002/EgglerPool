import UIKit

/**
 Displays times of the day
 */
class TimesTableVC: UITableViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return "TimesTableVC" }
    init(minDate: Date,
         maxDate: Date,
         minutesIncrement: Int = 15,
         timeType: TimeType){
        self.minDate = minDate
        self.maxDate = maxDate
        self.minutesIncrement = minutesIncrement
        self.timeType = timeType
        super.init(nibName: nil, bundle:nil)
    }
    
    private let minDate: Date
    private let maxDate: Date
    private let minutesIncrement: Int
    private let timeType: TimeType
    
    enum TimeType {
        case time(callback: (Date) -> ())
        case range(callback: (Date, Date) -> ())
    }
    
    private lazy var times: [Date] = {
        var dates = [Date]()
        dates.append(minDate)
        var currentDate = minDate
        while currentDate.addMinutes(minutesIncrement) < maxDate {
            currentDate = currentDate.addMinutes(minutesIncrement)
            dates.append(currentDate)
        }
        return dates
    }()
}

// MARK: - Table view data source
extension TimesTableVC {

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let startTime = times[indexPath.row]
        let endTime: Date? = {
            switch timeType {
            case .time(_):
                return nil
            case .range(_):
                return startTime.addMinutes(minutesIncrement)
            }
        }()
        return TimesTVCell.makeCell(withStartTime: startTime,
                                    endTime: endTime,
                                    tableView: tableView,
                                    indexPath: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TimesTVCell.rowHeight
    }
}

extension TimesTableVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let startTime = times[indexPath.row]
        switch timeType {
        case .time(let callback):
            callback(startTime)
        case .range(let callback):
            callback(startTime, startTime.addMinutes(minutesIncrement))
        }
    }
}

