import UIKit

extension UIAlertController {
    
    static func createErrorController(errorMessage: String) -> UIAlertController {
        
        let alertController = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        return alertController
    }
}
