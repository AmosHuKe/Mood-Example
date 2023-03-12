#include <thread>
#include <string>

#include "include/dart_api.h"
#include "include/dart_native_api.h"

#include "include/dart_api_dl.h"

//声明线程执行函数
void thread_func(Dart_Port sendPort, char *name);

// 初始化 Dart Native API
// Initialize `dart_api_dl.h`
DART_EXPORT intptr_t InitDartApiDL(void* data) {
  return Dart_InitializeApiDL(data);
}

//开启线程
DART_EXPORT void NativeAsyncExecute(Dart_Port sendPort, char *name) {
    std::thread thread1(thread_func, sendPort, name);
    thread1.detach();
}

//线程实际操作
void thread_func(Dart_Port sendPort, char *name) {
    printf("thread is running, arg=%s", name);

    //等待一段时间
    std::this_thread::sleep_for(std::chrono::seconds(3));

    std::string greeting("这是 3 秒后的消息，");
    greeting += std::string(name);

    //创建一个Dart对象，然后发给给Dart
    Dart_CObject dart_object;
    dart_object.type = Dart_CObject_kString;	//Dart对象的类型
    dart_object.value.as_string = (char*) greeting.c_str();	//Dart对象的值
    Dart_PostCObject_DL(sendPort, &dart_object);	//发送给Dart

    free(name); //释放内存

    printf("thread is over, return=%s", greeting.c_str());
}