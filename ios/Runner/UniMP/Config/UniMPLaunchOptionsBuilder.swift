import UIKit

// 将应用启动参数转换成 UniMP SDK 需要的字典格式
enum UniMPLaunchOptionsBuilder {
    static func build(
        from launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> [AnyHashable: Any] {
        var options: [AnyHashable: Any] = [:]

        launchOptions?.forEach { key, value in
            options[key] = value
        }

        options["debug"] = NSNumber(value: true)
        return options
    }
}
