package com.example.moodexample

import androidx.annotation.NonNull
import com.example.moodexample.channel.UniMpMethodChannel
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

// Android 侧入口，仅负责 FlutterEngine 注册和原生通道接入。
class MainActivity : FlutterFragmentActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        // 将 UniMP 的 MethodChannel 设置在 FlutterEngine 配置阶段
        UniMpMethodChannel.setup(this, flutterEngine)
    }
}
