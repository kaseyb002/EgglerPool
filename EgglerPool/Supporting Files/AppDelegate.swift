import UIKit
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupAPIs()
        loadRootVC()
        return true
    }
}

//MARK: - Initial Setup
extension AppDelegate {
    
    private func loadRootVC() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        window?.rootViewController = StartVC()
        window?.makeKeyAndVisible()
    }
    
    private func setupAPIs() {
        //google maps
        GMSServices.provideAPIKey(Secrets.googleMapsAPIKey)
        GMSPlacesClient.provideAPIKey(Secrets.googlePlacesAPIKey)
    }
}

