import UIKit
import GooglePlaces
import Font_Awesome_Swift

class SetDestinationFlowVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init() {
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    private var selectedPlace: GMSPlace? {
        didSet {
            nextButton.isHidden = selectedPlace == nil
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var searchLocationView: UIView!
    @IBOutlet weak var nextButton: UIButton!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        load(searchLocationVC, into: searchLocationView)
        nextButton.layer.cornerRadius = 16
        nextButton.setFAText(prefixText: "Next ",
                             icon: FAType.FAArrowRight,
                             postfixText: "",
                             size: 25.0,
                             forState: .normal)
        nextButton.setFATitleColor(color: UIColor.white)
        nextButton.backgroundColor = Color.mainPurple
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        guard let place = selectedPlace else { return }
        goToConfirmDestination(place: place)
    }
    
    //MARK: - Child VCs
    private lazy var searchLocationVC: SearchLocationVC = {
        return SearchLocationVC(title: "Where would you like to go?") { place in
            self.selectedPlace = place
        }
    }()
}

//MARK: - Go Tos
extension SetDestinationFlowVC {
    
    private func goToConfirmDestination(place: GMSPlace) {
        var searchForm = TimeslotSearchForm()
        searchForm.destination = place
        let vc = SetPickupSpotFlowVC(searchForm: searchForm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
