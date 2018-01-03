import UIKit
import Font_Awesome_Swift

class StartVC: UIViewController {
    
    //MARK: - Required inits for Xibs
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) missing")}
    override var nibName: String? { return String(describing: type(of: self)) }
    init() {
        super.init(nibName: nil, bundle:nil)
    }
    
    //MARK: - Outlets
    @IBOutlet weak private var startButton: UIButton!
    @IBOutlet weak private var car: UIImageView!
    @IBOutlet weak private var driverEgg: UIImageView!
    @IBOutlet weak private var shotgunEgg: UIImageView!
    @IBOutlet weak private var backseatEgg: UIImageView!
    
    @IBOutlet private var imagesThatMove: [UIImageView]!
    
    override var prefersStatusBarHidden: Bool { return true }
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.mainPurple
        startButton.setFAText(prefixText: "Start ",
                              icon: FAType.FAAngleRight,
                              postfixText: "",
                              size: 50.0,
                              forState: .normal)
        startButton.setFATitleColor(color: UIColor.white)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setInitialPosition()
        call(after: 0.5) { self.runIntroAnimation() }
    }
    
    //MARK: - Actions
    @IBAction func startButtonPressed(_ sender: UIButton) {
        runTakeOffAnimation() { self.goToSetDestination() }
    }
}

//MARK: - Go Tos
extension StartVC {
    
    private func goToSetDestination() {
        let nav = UINavigationController(rootViewController: SetDestinationFlowVC())
        //nav.modalTransitionStyle = .crossDissolve
        present(nav, animated: true, completion: nil)
    }
}

//MARK: - Animations
extension StartVC {
    
    private func setInitialPosition() {
        imagesThatMove.forEach { $0.isHidden = false }
        self.shotgunEgg.frame = self.shotgunEgg.frame.adjust(xTo: centerScreen.x - 10, yTo: -80)
        self.backseatEgg.frame = self.backseatEgg.frame.adjust(xTo: centerScreen.x - 60, yTo: -80)
        startButton.alpha = 0.0
    }
    
    private func runIntroAnimation() {
        UIView.animate(withDuration: 1.0) {
            self.shotgunEgg.frame = self.shotgunEgg.frame.adjust(yTo: centerScreen.y - 40)
        }
        let dropBackseatEgg = { self.backseatEgg.frame = self.backseatEgg.frame.adjust(yTo: centerScreen.y - 40) }
        let fadeInStartButton: (Bool) -> () = { _ in UIView.animate(withDuration: 0.5, animations: { self.startButton.alpha = CGFloat(1.0) }) }
        call(after: 0.5) {
            UIView.animate(withDuration: 1.0, animations: dropBackseatEgg, completion: fadeInStartButton)
        }
    }
    
    private func runTakeOffAnimation(callback: @escaping () -> ()) {
        let scootchBackDistance: CGFloat = -25
        let scootchBack: () -> Void = {
            self.car.frame = self.car.frame.adjust(xBy: scootchBackDistance)
            self.driverEgg.frame = self.driverEgg.frame.adjust(xBy: scootchBackDistance)
            self.shotgunEgg.frame = self.shotgunEgg.frame.adjust(xBy: scootchBackDistance)
            self.backseatEgg.frame = self.backseatEgg.frame.adjust(xBy: scootchBackDistance)
        }
        
        let travelDistance: CGFloat = 400
        let takeOff: () -> Void = {
            self.car.frame = self.car.frame.adjust(xBy: travelDistance)
            self.driverEgg.frame = self.driverEgg.frame.adjust(xBy: travelDistance)
            self.shotgunEgg.frame = self.shotgunEgg.frame.adjust(xBy: travelDistance)
            self.backseatEgg.frame = self.backseatEgg.frame.adjust(xBy: travelDistance)
        }
        
        let takeOffAnimation: (Bool) -> Void = { finished in
            UIView.animate(withDuration: 0.5,
                           animations: takeOff) { _ in
                            self.imagesThatMove.forEach { $0.isHidden = true }
                            callback()
            }
        }
        UIView.animate(withDuration: 0.5,
                       animations: scootchBack,
                       completion: takeOffAnimation)
    }
}
