import UIKit

import DotCore
import DotFaceCore
import DotDocument
import DotNfc
import DotPalmCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        print("DotSdk version: \(DotSdk.shared.versionName)")
        
        DotFaceCore.Logger.logLevel = .debug
        DotDocument.Logger.logLevel = .debug
        DotNfc.Logger.logLevel = .debug
        DotPalmCore.Logger.logLevel = .debug
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
