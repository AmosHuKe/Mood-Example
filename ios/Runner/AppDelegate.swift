import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let uniMPMiniApps = FlutterMethodChannel(name: "UniMP_mini_apps",
                                             binaryMessenger: controller.binaryMessenger)
    uniMPMiniApps.setMethodCallHandler({
        [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
        print(call.arguments!)
        guard call.method == "open" else {
          result(FlutterMethodNotImplemented)
          return
        }
        print("233")
    })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
