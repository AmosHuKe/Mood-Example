package com.example.moodexample

import io.dcloud.common.adapter.util.Logger
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

import io.dcloud.feature.sdk.DCUniMPSDK;
import io.dcloud.feature.sdk.Interface.IUniMP
import io.dcloud.feature.sdk.DCSDKInitConfig

import io.dcloud.feature.sdk.MenuActionSheetItem
import io.flutter.Log

class MainActivity: FlutterFragmentActivity() {
    /* ======================================================= */
    /* Override/Implements Methods                             */
    /* ======================================================= */
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        // Channel 对象
        val channel = MethodChannel(messenger, "UniMP_mini_apps")
        // Channel 设置回调
        channel.setMethodCallHandler { call, res ->
            // 根据方法名，分发不同的处理
            when (call.method) {
                // 打开指定的 UniMP 小程序
                "open" -> {
                    try {
                        // 接收 Flutter 传入的参数
                        val argument = call.argument<String>("AppID")
                        // 设置右上角胶囊操作菜单
                        val item = MenuActionSheetItem("关于", "about")
                        val sheetItems: MutableList<MenuActionSheetItem> = ArrayList()
                        sheetItems.add(item)
                        // 初始化uniMPSDK
                        val config = DCSDKInitConfig.Builder()
                            .setCapsule(true)
                            .setMenuDefFontSize("16px")
                            .setMenuDefFontColor("#2D2D2D")
                            .setMenuDefFontWeight("normal")
                            .setMenuActionSheetItems(sheetItems)
                            .build()
                        DCUniMPSDK.getInstance().initialize(this, config)

                        // 打开小程序
                        DCUniMPSDK.getInstance().openUniMP(this, argument)
                        // 监听胶囊菜单点击事件
                        DCUniMPSDK.getInstance().setDefMenuButtonClickCallBack { argumentAppID, id ->
                            when (id) {
                                "about" -> {
                                    Logger.e(argumentAppID + "点击了关于")
                                }
                            }
                        }
                        // 监听小程序关闭
                        DCUniMPSDK.getInstance()
                            .setUniMPOnCloseCallBack { argumentAppID -> Log.e("unimp", argumentAppID + "被关闭了") }
                    } catch (e: Exception) {
                        e.printStackTrace()
                    }
                }

                else -> {
                    // 如果有未识别的方法名，通知执行失败
                    res.error("error_code", "error_message", null)
                }
            }
        }
    }
}
