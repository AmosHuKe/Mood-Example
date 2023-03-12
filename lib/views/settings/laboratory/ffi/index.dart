import 'dart:ffi';
import 'dart:io';
import 'package:ffi/ffi.dart' as ffi;
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

///
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

///
import 'package:moodexample/themes/app_theme.dart';
import 'package:moodexample/widgets/action_button/action_button.dart';

typedef NativeDartInitializeApiDL = Int32 Function(Pointer<Void> data);
typedef FFIDartInitializeApiDL = int Function(Pointer<Void> data);

typedef NativeNativeAsyncExecute = Void Function(Int64, Pointer<Int8>);
typedef FFINativeAsyncExecute = void Function(int, Pointer<Int8>);

class FFIPage extends StatefulWidget {
  const FFIPage({super.key});

  @override
  State<FFIPage> createState() => _FFIPageState();
}

class _FFIPageState extends State<FFIPage> {
  late DynamicLibrary _dl;
  late ReceivePort _receivePort;
  late bool ffiLoading = false;
  String? testText;

  @override
  void initState() {
    super.initState();

    testNative();
  }

  /// 测试 FFI
  void testNative() {
    setState(() {
      ffiLoading = true;
    });

    /// 加载符号表
    _dl = Platform.isAndroid
        ? DynamicLibrary.open("libffi.so")
        : DynamicLibrary.process();

    /// 查找初始化函数
    FFIDartInitializeApiDL initFunc =
        _dl.lookupFunction<NativeDartInitializeApiDL, FFIDartInitializeApiDL>(
            "InitDartApiDL");

    /// 调用初始化函数，并判断是否成功
    final int nativeInited = initFunc(NativeApi.initializeApiDLData);

    if (nativeInited == 0) {
      print("初始化 Dart Native API 成功");
    } else {
      print("初始化 Dart Native API 失败");
      return;
    }

    /// 创建 ReceivePort，用于接收 Native 异步返回的数据
    _receivePort = ReceivePort();
    _receivePort.listen((message) {
      setState(() {
        testText = "ReceivePort, message=$message, type=${message.runtimeType}";
        ffiLoading = false;
      });
      _receivePort.close();
    });

    /// 查找 Native 异步函数
    FFINativeAsyncExecute asyncExecuteFunc =
        _dl.lookupFunction<NativeNativeAsyncExecute, FFINativeAsyncExecute>(
            "NativeAsyncExecute");

    /// 调用 Native 异步函数
    final name = "测试一下 FFI".toNativeUtf8().cast<Int8>();
    asyncExecuteFunc(_receivePort.sendPort.nativePort, name);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        backgroundColor: const Color(0xFFE2DDE4),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFFF6F8FA),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
          title: const Text("FFI"),
          leading: ActionButton(
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppTheme.backgroundColor1,
                    AppTheme.backgroundColor1
                  ],
                ),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(18.w))),
            child: Icon(
              Remix.arrow_left_line,
              size: 24.sp,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
          child: Align(
            child: ffiLoading
                ? const CupertinoActivityIndicator()
                : Text(testText!),
          ),
        ),
      ),
    );
  }
}
