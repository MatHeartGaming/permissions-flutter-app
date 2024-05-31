import UIKit
import Flutter
import GoogleMaps
import workmanager

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyAC1DP9zGre34MciNbT_IV9uAvzJUKJxe4")

    UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(60*15))
    // In AppDelegate.application method
    //WorkmanagerPlugin.registerBGProcessingTask(withIdentifier: "it.matbuompy.miscelaneos.fetch-background-pokemon")
    // Register a periodic task in iOS 13+
    //WorkmanagerPlugin.registerPeriodicTask(withIdentifier: "it.matbuompy.miscelaneos.fetch-background-periodic-pokemon", frequency: NSNumber(value: 15 * 60))

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
