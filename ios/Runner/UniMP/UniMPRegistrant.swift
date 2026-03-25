import Flutter
import UIKit

// 统一入口 UniMP 原生注册逻辑
enum UniMPRegistrant {
    static func register(
        with engineBridge: FlutterImplicitEngineBridge,
        manager: UniMPManager,
        launchOptionsProvider: @escaping () -> [UIApplication.LaunchOptionsKey:
            Any]?,
        delegate: DCUniMPSDKEngineDelegate
    ) {
        // 向 Flutter 暴露 UniMP 通信通道
        UniMPMethodChannel.register(
            messenger: engineBridge.applicationRegistrar.messenger(),
            manager: manager,
            launchOptionsProvider: launchOptionsProvider
        )

        // 将 UniMP SDK 回调转发给宿主应用
        DCUniMPSDKEngine.setDelegate(delegate)
    }
}
