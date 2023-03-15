#include <thread>
#include <string>

#include "include/dart_native_api/dart_api.h"
#include "include/dart_native_api/dart_native_api.h"
#include "include/dart_native_api/dart_api_dl.h"

#define DART_API extern "C" __attribute__((visibility("default"))) __attribute__((used))

// 声明执行函数
DART_API void test(Dart_Port sendPort, int seconds);

// 初始化 Dart Native API
// Initialize `dart_api_dl.h`
DART_EXPORT intptr_t InitDartApiDL(void* data) {
  return Dart_InitializeApiDL(data);
}

// 注册发送端口开启线程
DART_EXPORT void RegisterSendPort(Dart_Port sendPort, int seconds) {
  std::thread thread1(test, sendPort, seconds);
  thread1.detach();
}

// 实际操作
DART_API void test(Dart_Port sendPort, int seconds) {
  // 等待设定的时间
  std::this_thread::sleep_for(std::chrono::seconds(seconds));
  std::string text("这是线程 " + std::to_string(sendPort) +"\n设定 " + std::to_string(seconds) + " 秒后的消息");

  // 创建 Dart 对象，发送给 Dart
  Dart_CObject dart_object2;
  // 设置 Dart 对象类型
  dart_object2.type = Dart_CObject_kString;
  // 设置 Dart 对象值
  dart_object2.value.as_string = (char*) text.c_str();
  // 发送给 Dart，并会触发端口的监听
  Dart_PostCObject_DL(sendPort, &dart_object2);
}
