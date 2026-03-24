package com.example.moodexample.channel

import com.example.moodexample.unimp.manager.UniMpManager
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// 统一负责 UniMP 的 MethodChannel 创建和绑定
object UniMpMethodChannel {
    private const val CHANNEL_NAME = "UniMP_mini_apps"

    fun setup(activity: FlutterFragmentActivity, flutterEngine: FlutterEngine) {
        val messenger = flutterEngine.dartExecutor.binaryMessenger
        val uniMpManager = UniMpManager(activity)
        val channel = MethodChannel(messenger, CHANNEL_NAME)
        channel.setMethodCallHandler(UniMpMethodCallHandler(uniMpManager))
    }
}
