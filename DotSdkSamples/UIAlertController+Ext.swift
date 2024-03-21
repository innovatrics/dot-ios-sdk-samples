import UIKit

extension UIAlertController {
    
    static func createErrorController(errorMessage: String, actionHandler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: actionHandler)
        alertController.addAction(action)
        return alertController
    }
}
