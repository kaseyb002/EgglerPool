import UIKit

extension UIViewController {
    
    func load(_ childVC: UIViewController, into childContainer: UIView) {
        childContainer.subviews.forEach { $0.removeFromSuperview() }
        addChildViewController(childVC)
        childVC.view.frame = CGRect(x: 0, y: 0, width: childContainer.frame.size.width, height: childContainer.frame.size.height);
        childContainer.addSubview(childVC.view)
        childContainer.backgroundColor = UIColor.clear//IB has default white background which is annoying
        childVC.didMove(toParentViewController: self)
    }
    
    func presentDark(vc: UIViewController, frame: CGRect) {
        //create a dark background that covers the entire view controller
        let darkView = UIView(frame: view.frame)
        darkView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        vc.view.frame = frame
        darkView.addSubview(vc.view)
        darkView.bringSubview(toFront: vc.view)
        
        vc.view = darkView
        
        //present it
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        present(vc, animated: true, completion: nil)
    }
    
    @objc func close() {
        //if modal
        if navigationController == nil {
            dismiss(animated: true, completion: nil)
            return
        }
        //if root view controller in nav controller
        navigationController?.viewControllers.first.map {
            if self == $0 { dismiss(animated: true, completion: nil) }
            return
        }
        let _ = navigationController?.popViewController(animated: true)
    }
    
    func okAlert(title: String, message: String? = nil) {
        alert(title: title, message: message, handlers: [("OK", {})], includeCancel: false)
    }
    
    func alert(title: String,
               message: String? = nil,
               handlers: [(String, () -> Void)],
               includeCancel: Bool = true) {
        
        //let popup = PopupDialog(title: title, message: message)
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        handlers.forEach { tuple in
            let (buttonTitle, callback) = tuple
            alert.addAction(UIAlertAction(title: buttonTitle,
                                          style: UIAlertActionStyle.default,
                                          handler: { _ in callback() }))
        }
        
        if includeCancel {
            alert.addAction(UIAlertAction(title: "Cancel",
                                          style: UIAlertActionStyle.cancel,
                                          handler: nil))
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    func actionSheet(title: String,
                     message: String? = nil,
                     handlers: [(String, () -> Void)],
                     includeCancel: Bool = true) {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        handlers.forEach { tuple in
            let (buttonTitle, callback) = tuple
            let action = UIAlertAction(title: buttonTitle, style: .default, handler: { _ in callback() })
            actionSheet.addAction(action)
        }
        if includeCancel { actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil)) }
        
        present(actionSheet, animated: true, completion: nil)
    }
}
