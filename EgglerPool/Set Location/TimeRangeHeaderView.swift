import UIKit

class TimeRangeHeaderView: UIView {
    
    var timeWindow: TimeWindow? {
        didSet {
            timeWindow.map {
                timeRangeLabel.text = $0.startTime.string("h:mm") + " - " + $0.endTime.string("h:mma").lowercased()
            }
        }
    }
    
    @IBOutlet weak var timeRangeLabel: UILabel!
}

extension TimeRangeHeaderView {
    
    static let defaultHeight: CGFloat = 50
    
    static func makeView(timeWindow: TimeWindow) -> TimeRangeHeaderView {
        let views = Bundle.main.loadNibNamed("TimeRangeHeaderView", owner: self, options: nil)
        let header = views?.first as! TimeRangeHeaderView
        header.timeWindow = timeWindow
        return header
    }
}

