import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate, DCUniMPSDKEngineDelegate {
  var savedLaunchOptions: [UIApplication.LaunchOptionsKey: Any]?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    self.savedLaunchOptions = launchOptions
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    let uniMPMiniApps = FlutterMethodChannel(name: "UniMP_mini_apps", binaryMessenger: engineBridge.applicationRegistrar.messenger())
    uniMPMiniApps.setMethodCallHandler({
      [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
      switch(call.method) {
        case "open":
          if let arguments = call.arguments as? Dictionary<String,Any> {
            let AppID: String = arguments["AppID"] as? String ?? ""
            var opts: [AnyHashable: Any] = [:]
            if let saved = self?.savedLaunchOptions {
              for (k, v) in saved {
                opts[k] = v
              }
            }
            let options = NSMutableDictionary.init(dictionary: opts)
            options.setValue(NSNumber.init(value:true), forKey: "debug")
            DCUniMPSDKEngine.initSDKEnvironment(launchOptions: options as! [AnyHashable : Any]);
            self?.checkUniMPResoutce(appid:AppID)
            self?.openUniMP(appid:AppID)
          }
        break
        default:
          result(FlutterMethodNotImplemented)
        break
      }
    })
  }

  func checkUniMPResoutce(appid: String) -> Void {
    let wgtPath = Bundle.main.path(forResource: appid, ofType: "wgt") ?? ""
    if DCUniMPSDKEngine.isExistsUniMP(appid) {
      let version = DCUniMPSDKEngine.getUniMPVersionInfo(withAppid: appid)!
      let name = version["code"]!
      let code = version["code"]!
      print("小程序：\(appid) 资源已存在，版本信息：name:\(name) code:\(code)")
    } else {
      do {
        try DCUniMPSDKEngine.installUniMPResource(withAppid: appid, resourceFilePath: wgtPath, password: nil)
        let version = DCUniMPSDKEngine.getUniMPVersionInfo(withAppid: appid)!
        let name = version["code"]!
        let code = version["code"]!
        print("✅ 小程序：\(appid) 资源释放成功，版本信息：name:\(name) code:\(code)")
      } catch let err as NSError {
        print("❌ 小程序：\(appid) 资源释放失败:\(err)")
      }
    }
  }

  /// 打开uni小程序
  @IBAction func openUniMP(appid: String) {
    let configuration = DCUniMPConfiguration.init()
    configuration.enableBackground = true
    
    DCUniMPSDKEngine.openUniMP(appid, configuration: configuration) { instance, error in
        if instance != nil {
            print("小程序打开成功")
        } else {
            print(error as Any)
        }
    }
  }

  func uniMP(onClose appid: String) {
    print("小程序：\(appid) closed")
  }

  func defaultMenuItemClicked(_ appid: String, identifier: String) {
    print("defaultMenuItemClicked：\(appid) \(identifier)")
  }

  func splashView(forApp appid: String) -> UIView {
      let splashView:UIView = Bundle.main.loadNibNamed("SplashView", owner: self, options: nil)?.last as! UIView
      return splashView
  }
}
