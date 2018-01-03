import UIKit

class TimeslotsTVCell: UITableViewCell {

    //MARK: - Properties
    private var timeslots = [Timeslot]() {
        didSet {
            collectionView.reloadData()
        }
    }
    private var selectTimeslot: ((Timeslot) -> ())!
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

//MARK: - Update Cell
extension TimeslotsTVCell {
    
    private func updateCell(withTimeslots timeslots: [Timeslot],
                            selectTimeslot: @escaping (Timeslot) -> ()) {
        self.timeslots = timeslots
        self.selectTimeslot = selectTimeslot
    }
}

//MARK: - UICollectionViewDataSource
extension TimeslotsTVCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeslots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let timeslot = timeslots[indexPath.row]
        return TimeslotCVCell.makeCell(withTimeslot: timeslot,
                                       collectionView: collectionView,
                                       indexPath: indexPath)
    }
}

//MARK: - UICollectionViewDelegate
extension TimeslotsTVCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let timeslot = timeslots[indexPath.row]
        selectTimeslot(timeslot)
    }
}

//MARK: - Make Cell
extension TimeslotsTVCell {
    
    static let rowHeight: CGFloat = 180.0
    
    static func makeCell(withTimeslots timeslots: [Timeslot],
                         selectTimeslot: @escaping (Timeslot) -> (),
                         tableView: UITableView,
                         indexPath: IndexPath) -> TimeslotsTVCell {
        let cell = make(tableViewCell: self,
                        tableView: tableView,
                        indexPath: indexPath)
        cell.updateCell(withTimeslots: timeslots, selectTimeslot: selectTimeslot)
        return cell
    }
}
