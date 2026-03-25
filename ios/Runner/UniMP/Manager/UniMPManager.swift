import UIKit

// 封装 UniMP
final class UniMPManager {
    func prepareAndOpen(
        appID: String, launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) {
        let options = UniMPLaunchOptionsBuilder.build(from: launchOptions)
        DCUniMPSDKEngine.initSDKEnvironment(launchOptions: options)
        ensureResourceInstalled(for: appID)
        openUniMP(appID: appID)
    }

    private func ensureResourceInstalled(for appID: String) {
        let wgtPath = Bundle.main.path(forResource: appID, ofType: "wgt") ?? ""

        if DCUniMPSDKEngine.isExistsUniMP(appID) {
            logVersion(prefix: "小程序：\(appID) 资源已存在，版本信息", appID: appID)
            return
        }

        do {
            try DCUniMPSDKEngine.installUniMPResource(
                withAppid: appID, resourceFilePath: wgtPath, password: nil)
            logVersion(prefix: "✅ 小程序：\(appID) 资源释放成功，版本信息", appID: appID)
        } catch let error as NSError {
            print("❌ 小程序：\(appID) 资源释放失败:\(error)")
        }
    }

    private func openUniMP(appID: String) {
        let configuration = DCUniMPConfiguration()
        configuration.enableBackground = true

        DCUniMPSDKEngine.openUniMP(appID, configuration: configuration) {
            instance, error in
            if instance != nil {
                print("小程序打开成功")
            } else {
                print(error as Any)
            }
        }
    }

    private func logVersion(prefix: String, appID: String) {
        guard
            let version = DCUniMPSDKEngine.getUniMPVersionInfo(withAppid: appID)
        else {
            print("\(prefix)：未获取到版本信息")
            return
        }

        let name = version["name"] ?? version["code"] ?? "unknown"
        let code = version["code"] ?? "unknown"
        print("\(prefix)：name:\(name) code:\(code)")
    }
}
