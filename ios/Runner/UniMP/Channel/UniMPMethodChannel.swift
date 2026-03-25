import Flutter
import UIKit

// 注册提供给 Flutter 使用的 UniMP 通信通道
enum UniMPMethodChannel {
    private static let channelName = "UniMP_mini_apps"

    static func register(
        messenger: FlutterBinaryMessenger,
        manager: UniMPManager,
        launchOptionsProvider: @escaping () -> [UIApplication.LaunchOptionsKey:
            Any]?
    ) -> FlutterMethodChannel {
        let channel = FlutterMethodChannel(
            name: channelName, binaryMessenger: messenger)

        channel.setMethodCallHandler { call, result in
            switch call.method {
            case "open":
                guard
                    let arguments = call.arguments as? [String: Any],
                    let appID = arguments["AppID"] as? String,
                    !appID.isEmpty
                else {
                    result(
                        FlutterError(
                            code: "invalid_arguments",
                            message: "AppID is required",
                            details: call.arguments
                        )
                    )
                    return
                }

                // 打开 UniMP 前会一并完成 SDK 初始化和资源安装检查
                manager.prepareAndOpen(
                    appID: appID, launchOptions: launchOptionsProvider())
                result(nil)
            default:
                result(FlutterMethodNotImplemented)
            }
        }

        return channel
    }
}
