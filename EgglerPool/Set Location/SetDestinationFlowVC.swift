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
    private var selectedLocation: Location? {
        didSet {
            updateAddress()
        }
    }
    
    
    //MARK: - Outlets
    @IBOutlet weak private var searchLocationView: UIView!
    @IBOutlet weak private var nextButton: UIButton!
    @IBOutlet weak private var showAddressView: UIView!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        guard let location = selectedLocation else { return }
        goToConfirmDestination(location: location)
    }
    
    //MARK: - Child VCs
    private lazy var searchLocationVC: SearchLocationVC = {
        let searchStart: Callback = {
            self.showAddressView.isHidden = true
            self.nextButton.isHidden = true
        }
        let searchDone: Callback = { self.updateAddress() }
        return SearchLocationVC(title: "Where to?",
                                searchStarting: searchStart,
                                searchDone: searchDone) { place in
                                    self.selectedLocation = place.location
        }
    }()
}

//MARK: - UI Updates
extension SetDestinationFlowVC {
    
    private func updateAddress() {
        guard let location = selectedLocation else {
            showAddressView.isHidden = true
            nextButton.isHidden = true
            return
        }
        showAddressView.isHidden = false
        nextButton.isHidden = false
        let vc = ShowAddressVC(location: location)
        load(vc, into: showAddressView)
    }
}

//MARK: - Go Tos
extension SetDestinationFlowVC {
    
    private func goToConfirmDestination(location: Location) {
        var searchForm = TimeslotSearchForm()
        searchForm.destination = location
        let vc = IntroPickupSpotVC(searchForm: searchForm)
        navigationController?.pushViewController(vc, animated: true)
    }
}
