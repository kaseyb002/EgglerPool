import UIKit
import GooglePlaces
import GoogleMaps

class SearchLocationVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init(title: String = "Search Location",
         placeSelectedCallback: @escaping (GMSPlace) -> ()) {
        self.titleForLabel = title
        self.placeSelectedCallback = placeSelectedCallback
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Properties
    private let titleForLabel: String
    private let placeSelectedCallback: (GMSPlace) -> ()
    
    //MARK: - Google Places Properties
    lazy var resultsViewController: GMSAutocompleteResultsViewController = {
        let resultsVC = GMSAutocompleteResultsViewController()
        resultsVC.delegate = self
        //bound results to united states
        resultsVC.autocompleteBounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2DMake(-172.265625, 18.1458517717),
                                                           coordinate: CLLocationCoordinate2DMake(-56.6015625, 52.3755991767))
        return resultsVC
    }()
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: resultsViewController)
        searchController.searchResultsUpdater = resultsViewController
        return searchController
    }()
    
    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleForLabel
        loadGoogleMapsAutocomplete()
    }
}

//MARK: - Google Places Search Delegate
extension SearchLocationVC: GMSAutocompleteResultsViewControllerDelegate {
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController.isActive = false
        searchController.searchBar.text = place.formattedAddress
        placeSelectedCallback(place)
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
}

//MARK: - Load Google Maps
extension SearchLocationVC {
    
    private func loadGoogleMapsAutocomplete() {
        let subView = UIView(frame: CGRect(x: 0,
                                           y: 60,
                                           width: view.frame.width,
                                           height: 56.0))
        
        subView.addSubview((searchController.searchBar))
        view.addSubview(subView)
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        
        // When UISearchController presents the results view, present it in
        // this view controller, not one further up the chain.
        definesPresentationContext = true
        navigationController?.navigationBar.isTranslucent = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        // This makes the view area include the nav bar even though it is opaque.
        // Adjust the view placement down.
        extendedLayoutIncludesOpaqueBars = true
        edgesForExtendedLayout = .top
    }
}
