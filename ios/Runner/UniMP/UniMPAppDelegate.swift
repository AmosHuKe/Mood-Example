import Flutter
import UIKit

// 将 UniMP SDK 回调与主 AppDelegate 启动流程分离
extension AppDelegate: DCUniMPSDKEngineDelegate {
    func uniMP(
        onClose appid: String
    ) {
        print(
            "小程序：\(appid) closed"
        )
    }

    func defaultMenuItemClicked(
        _ appid: String,
        identifier: String
    ) {
        print(
            "defaultMenuItemClicked：\(appid) \(identifier)"
        )
    }

    func splashView(
        forApp appid: String
    ) -> UIView {
        // 优先复用宿主 LaunchScreen，避免缺少 SplashView 时崩溃
        if let controller = UIStoryboard(
            name: "LaunchScreen",
            bundle: .main
        ).instantiateInitialViewController() {
            controller.loadViewIfNeeded()
            return controller.view
        }

        let fallbackView = UIView(
            frame: UIScreen.main.bounds
        )
        fallbackView.backgroundColor = .systemBackground
        return fallbackView
    }
}
