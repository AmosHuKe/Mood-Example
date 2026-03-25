import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  // 保存应用启动参数，后续打开 UniMP 时复用
  var savedLaunchOptions: [UIApplication.LaunchOptionsKey: Any]?
  private let uniMPManager = UniMPManager()

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication
      .LaunchOptionsKey: Any]?
  ) -> Bool {
    self.savedLaunchOptions = launchOptions
    return super.application(
      application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(
    _ engineBridge: FlutterImplicitEngineBridge
  ) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)

    // 注册 UniMP 原生接入能力
    UniMPRegistrant.register(
      with: engineBridge,
      manager: uniMPManager,
      launchOptionsProvider: { [weak self] in
        self?.savedLaunchOptions
      },
      delegate: self
    )
  }
}
