package com.example.moodexample.unimp.manager

import com.example.moodexample.unimp.config.UniMpConfigFactory
import io.dcloud.common.adapter.util.Logger
import io.dcloud.feature.sdk.DCUniMPSDK
import io.flutter.embedding.android.FlutterFragmentActivity

// 封装 UniMP SDK 的初始化、打开和回调注册逻辑
class UniMpManager(
    private val activity: FlutterFragmentActivity,
) {
    private val sdk: DCUniMPSDK = DCUniMPSDK.getInstance()
    private var initialized = false

    fun openMiniApp(appId: String) {
        // 打开前确保 SDK 和相关回调都已准备完成
        ensureInitialized()
        sdk.openUniMP(activity, appId)
    }

    private fun ensureInitialized() {
        if (initialized) {
            return
        }

        // SDK 初始化和回调注册只执行一次，避免重复设置带来的额外开销
        sdk.initialize(activity, UniMpConfigFactory.create())
        registerCallbacks()
        initialized = true
    }

    private fun registerCallbacks() {
        // 胶囊菜单点击事件统一在这里处理，后续新增菜单项也从这里扩展
        sdk.setDefMenuButtonClickCallBack { appId, menuId ->
            if (menuId == MENU_ID_ABOUT) {
                Logger.e(LOG_TAG, appId + " 点击了关于")
            }
        }

        // 小程序关闭后的日志或埋点也统一收口在管理类中
        sdk.setUniMPOnCloseCallBack { appId ->
            Logger.e(LOG_TAG, appId + " 被关闭了")
        }
    }

    private companion object {
        const val MENU_ID_ABOUT = "about"
        const val LOG_TAG = "unimp"
    }
}
