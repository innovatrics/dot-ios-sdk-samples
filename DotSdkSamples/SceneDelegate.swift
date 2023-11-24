import UIKit

import DotCore
import DotDocument
import DotNfc

import DotFaceCore
import DotFaceDetectionFast
import DotFaceBackgroundUniformity
import DotFaceExpressionNeutral

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func sceneDidBecomeActive(_ scene: UIScene) {
        if !DotSdk.shared.isInitialized {
            DispatchQueue.global().async {
                self.initializeDotSdk()
            }
        }
    }
    
    private func presentErrorAlert(_ errorMessage: String) {
        let alertController = UIAlertController.createErrorController(errorMessage: errorMessage)
        window?.rootViewController?.present(alertController, animated: true)
    }
}

extension SceneDelegate {
    
    private func initializeDotSdk() {
        
        print("Bundle ID: " + DotSdk.shared.bundleId)
        
        if let url = Bundle.main.url(forResource: "dot_license", withExtension: "lic") {
            do {
                let license = try Data(contentsOf: url)
                let dotFaceLibraryConfiguration = createDotFaceLibraryConfiguration()
                let dotSdkConfiguration = createDotSdkConfiguration(license: license, dotFaceLibraryConfiguration: dotFaceLibraryConfiguration)
                try DotSdk.shared.initialize(configuration: dotSdkConfiguration)
            } catch {
                presentErrorAlert("Failed to initialize DotSdk: \(error.localizedDescription)")
            }
        } else {
            presentErrorAlert("Failed to initialize DotSdk: License not found.")
        }
    }
    
    private func createDotFaceLibraryConfiguration() -> DotFaceLibraryConfiguration {
        return .init(
            modules: [
                DotFaceDetectionFastModule.shared,
                DotFaceBackgroundUniformityModule.shared,
                DotFaceExpressionNeutralModule.shared
            ]
        )
    }
    
    private func createDotSdkConfiguration(license: Data, dotFaceLibraryConfiguration: DotFaceLibraryConfiguration) -> DotSdkConfiguration {
        return DotSdkConfiguration(
            licenseBytes: license,
            libraries: [
                DotFaceLibrary(configuration: dotFaceLibraryConfiguration),
                DotDocumentLibrary(),
                DotNfcLibrary()
            ]
        )
    }
}
