package com.example.moodexample.channel

import com.example.moodexample.unimp.manager.UniMpManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

// 负责解析 Flutter 调用的方法名，并转换成原生侧的具体操作
class UniMpMethodCallHandler(
    private val uniMpManager: UniMpManager,
) : MethodChannel.MethodCallHandler {

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            METHOD_OPEN -> handleOpen(call, result)
            else -> result.notImplemented()
        }
    }

    private fun handleOpen(call: MethodCall, result: MethodChannel.Result) {
        // Flutter 侧通过 AppID 指定需要打开的 UniMP 小程序
        val appId = call.argument<String>(ARGUMENT_APP_ID)

        if (appId.isNullOrBlank()) {
            result.error(ERROR_INVALID_ARGUMENT, "AppID is required", null)
            return
        }

        runCatching {
            uniMpManager.openMiniApp(appId)
        }.onSuccess {
            result.success(null)
        }.onFailure { throwable ->
            result.error(ERROR_OPEN_FAILED, throwable.message, null)
        }
    }

    private companion object {
        const val METHOD_OPEN = "open"
        const val ARGUMENT_APP_ID = "AppID"
        const val ERROR_INVALID_ARGUMENT = "invalid_argument"
        const val ERROR_OPEN_FAILED = "open_failed"
    }
}
