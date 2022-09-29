import UIKit

import DotFaceCore
import DotFaceDetectionFast
import DotFacePassiveLiveness
import DotFaceVerification
import DotFaceBackgroundUniformity
import DotFaceExpressionNeutral

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func sceneDidBecomeActive(_ scene: UIScene) {
        if !DotFaceLibrary.shared.isInitialized {
            configureDotFace()
        }
    }
    
    private func presentErrorAlert(_ errorMessage: String) {
        let alertController = UIAlertController.createErrorController(errorMessage: errorMessage)
        window?.rootViewController?.present(alertController, animated: true)
    }
}

extension SceneDelegate {
    
    private func configureDotFace() {
        
        print("LicenseId: " + DotFaceLibrary.shared.licenseId)
        
        if let url = Bundle.main.url(forResource: "dot_face_license", withExtension: "lic") {
            do {
                try initializeDotFace(url)
            } catch {
                presentErrorAlert("Failed to initialize DotFace: \(error.localizedDescription)")
            }
        } else {
            presentErrorAlert("Failed to initialize DotFace: License not found.")
        }
    }
    
    private func initializeDotFace(_ licenseUrl: URL) throws {
        let license = try Data(contentsOf: licenseUrl)
        let configuration = DotFaceLibraryConfiguration(license: license,
                                                        modules: [
                                                            DotFaceDetectionFastModule.shared,
                                                            DotFacePassiveLivenessModule.shared,
                                                            DotFaceVerificationModule.shared,
                                                            DotFaceBackgroundUniformityModule.shared,
                                                            DotFaceExpressionNeutralModule.shared])
        DotFaceLibrary.shared.setDelegate(self)
        DotFaceLibrary.shared.initialize(configuration: configuration)
    }
}

extension SceneDelegate: DotFaceLibraryDelegate {
    
    func dotFaceLibraryInitializationFinished(_ dotFaceLibrary: DotFaceLibrary, result: DotFaceLibrary.Result) {
        if result.code == .ok {
            print("DotFace initialization SUCCESS")
        } else {
            presentErrorAlert("DotFace initialization FAILED: " + (result.error?.localizedDescription ?? "Unknown error"))
        }
    }
    
    func dotFaceLibraryDeinitializationFinished(_ dotFaceLibrary: DotFaceLibrary, result: DotFaceLibrary.Result) {
        if result.code == .ok {
            print("DotFace deinitialization SUCCESS")
        } else {
            presentErrorAlert("DotFace deinitialization FAILED: " + (result.error?.localizedDescription ?? "Unknown error"))
        }
    }
}
