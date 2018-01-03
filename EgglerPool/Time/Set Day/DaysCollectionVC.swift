import UIKit

class DaysCollectionVC: UICollectionViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(startDate: Date,
         endDate: Date,
         daySelected: @escaping (Date) -> ()) {
        self.startDate = startDate.startOfDay
        self.endDate = endDate.startOfDay
        self.daySelected = daySelected
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    private let startDate: Date
    private let endDate: Date
    private let daySelected: (Date) -> ()
    
    private lazy var days: [Date] = {
        var dates = [Date]()
        dates.append(startDate)
        var currentDate = startDate
        while currentDate.addDays(1) < endDate {
            currentDate = currentDate.addDays(1)
            dates.append(currentDate)
        }
        return dates
    }()
}

//MARK: - Data Source
extension DaysCollectionVC {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let day = days[indexPath.row]
        return DayCVCell.makeCell(withDate: day,
                                  isSelected: false,
                                  collectionView: collectionView,
                                  indexPath: indexPath)
    }
}

//MARK: - Delegate
extension DaysCollectionVC {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let day = days[indexPath.row]
        daySelected(day)
    }
}
