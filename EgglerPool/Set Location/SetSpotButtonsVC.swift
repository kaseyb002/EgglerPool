import UIKit
import Font_Awesome_Swift

/**
 Widget for displaying and responding to button presses on map spot searches
 */
class SetSpotButtonsVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(buttonTitle: String,
         setSpotButtonPressed: @escaping () -> (),
         currentLocationButtonPressed: @escaping () -> (),
         searchButtonPressed: @escaping () -> (),
         setSpotButtonBgColor: UIColor = Color.mainPurple) {
        self.buttonTitle = buttonTitle
        self.setSpotButtonPressed = setSpotButtonPressed
        self.currentLocationButtonPressed = currentLocationButtonPressed
        self.searchButtonPressed = searchButtonPressed
        self.setSpotButtonBgColor = setSpotButtonBgColor
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    private let buttonTitle: String
    private let setSpotButtonPressed: () -> ()
    private let currentLocationButtonPressed: () -> ()
    private let searchButtonPressed: () -> ()
    private let setSpotButtonBgColor: UIColor
    
    //MARK: - Outlets
    @IBOutlet weak var setSpotButton: UIButton!
    @IBOutlet weak var currentLocationButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setSpotButton.layer.cornerRadius = 16
        setSpotButton.backgroundColor = Color.mainPurple
        searchButton.layer.cornerRadius = searchButton.frame.width / 2
        searchButton.setFAIcon(icon: FAType.FASearch, forState: .normal)
        searchButton.setFATitleColor(color: UIColor.darkGray)
        searchButton.backgroundColor = UIColor.flatGray()
        currentLocationButton.layer.cornerRadius = currentLocationButton.frame.width / 2
        currentLocationButton.setFAIcon(icon: FAType.FALocationArrow, forState: .normal)
        currentLocationButton.setFATitleColor(color: UIColor.darkGray)
        currentLocationButton.backgroundColor = UIColor.flatGray()
        setSpotButton.setTitle(buttonTitle, for: .normal)
    }
    
    //MARK: - Actions
    @IBAction func setSpotButtonPressed(_ sender: UIButton) {
        setSpotButtonPressed()
    }
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        currentLocationButtonPressed()
    }
    
    @IBAction func searchLocationButtonPressed(_ sender: UIButton) {
        searchButtonPressed()
    }
}
