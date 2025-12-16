import UIKit

import DotCore
import DotDocument
import DotNfc

import DotPalmCore
import DotPalmDetection

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
}

extension SceneDelegate {
    
    private func initializeDotSdk() {
        
        print("Bundle ID: " + DotSdk.shared.bundleId)
        
        if let url = Bundle.main.url(forResource: "dot_license", withExtension: "lic") {
            do {
                let license = try Data(contentsOf: url)
                let dotSdkConfiguration = createDotSdkConfiguration(
                    license: license,
                    dotFaceLibraryConfiguration: createDotFaceLibraryConfiguration(),
                    dotPalmLibraryConfiguration: createDotPalmLibraryConfiguration()
                )
                try DotSdk.shared.initialize(configuration: dotSdkConfiguration)
            } catch {
                fatalError("Failed to initialize DotSdk: \(error.localizedDescription)")
            }
        } else {
            fatalError("Failed to initialize DotSdk: License not found.")
        }
    }
    
    private func createDotFaceLibraryConfiguration() -> DotFaceLibraryConfiguration {
        return .init(
            modules: .init(
                detection: DotFaceDetectionModuleConfiguration.Fast(),
                expressionNeutral: DotFaceExpressionNeutralModuleConfiguration(),
                backgroundUniformity: DotFaceBackgroundUniformityModuleConfiguration()
            )
        )
    }
    
    private func createDotPalmLibraryConfiguration() -> DotPalmLibraryConfiguration {
        return .init(modules: .init(detection: DotPalmDetectionModuleConfiguration()))
    }
    
    private func createDotSdkConfiguration(
        license: Data,
        dotFaceLibraryConfiguration: DotFaceLibraryConfiguration,
        dotPalmLibraryConfiguration: DotPalmLibraryConfiguration
    ) -> DotSdk.Configuration {
        return DotSdk.Configuration(
            licenseBytes: license,
            libraries: .init(
                document: DotDocumentLibraryConfiguration(),
                face: dotFaceLibraryConfiguration,
                nfc: DotNfcLibraryConfiguration(),
                palm: dotPalmLibraryConfiguration
            )
        )
    }
}
