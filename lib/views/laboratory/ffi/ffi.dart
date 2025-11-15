import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import '../../../widgets/action_button/action_button.dart';

/// 类型定义
/// DartApi 初始化
typedef NativeDartInitializeApiDL = Int32 Function(Pointer<Void> data);
typedef DartInitializeApiDL = int Function(Pointer<Void> data);

/// DartApi 注册线程
typedef NativeRegisterSendPort = Void Function(Int64, Int);
typedef RegisterSendPort = void Function(int, int);

class FFIScreen extends StatefulWidget {
  const FFIScreen({super.key});

  @override
  State<FFIScreen> createState() => _FFIScreenState();
}

class _FFIScreenState extends State<FFIScreen> {
  late DynamicLibrary dl;

  /// 接收端口1
  final ReceivePort receivePort1 = .new();

  /// 接收端口2
  final ReceivePort receivePort2 = .new();

  String testText1 = '';
  String testText2 = '';
  bool testLoading1 = true;
  bool testLoading2 = true;

  @override
  void initState() {
    super.initState();

    ffiInit();
    ffiTest1();
    ffiTest2();
  }

  @override
  void dispose() {
    receivePort1.close();
    receivePort2.close();

    super.dispose();
  }

  /// 初始化 FFI
  void ffiInit() {
    /// 加载库 符号表
    dl = Platform.isAndroid ? .open('libffi.so') : .process();

    /// 查找 DartApi 初始化函数
    final initDartApiDL = dl.lookupFunction<NativeDartInitializeApiDL, DartInitializeApiDL>(
      'InitDartApiDL',
    );

    /// 调用初始化函数，并判断是否成功
    final dartApiInited = initDartApiDL(NativeApi.initializeApiDLData);

    if (dartApiInited == 0) {
      print('初始化 Dart Native API 成功');
    } else {
      print('初始化 Dart Native API 失败');
    }
  }

  /// FFI 测试1
  void ffiTest1() {
    /// 监听接收端口
    receivePort1.listen((message) {
      setState(() {
        testText1 = '$message\ntype=${message.runtimeType}';
        testLoading1 = false;
      });

      /// 关闭端口
      receivePort1.close();
    });

    /// 查找 注册线程函数
    final registerSendPort = dl.lookupFunction<NativeRegisterSendPort, RegisterSendPort>(
      'RegisterSendPort',
    );

    /// 调用 开启线程并传入参数
    registerSendPort(receivePort1.sendPort.nativePort, 3);
  }

  /// FFI 测试2
  void ffiTest2() {
    /// 监听接收端口
    receivePort2.listen((message) {
      setState(() {
        testText2 = '$message\ntype=${message.runtimeType}';
        testLoading2 = false;
      });

      /// 关闭端口
      receivePort2.close();
    });

    /// 查找 注册线程函数
    final registerSendPort = dl.lookupFunction<NativeRegisterSendPort, RegisterSendPort>(
      'RegisterSendPort',
    );

    /// 调用 开启线程并传入参数
    registerSendPort(receivePort2.sendPort.nativePort, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: .new(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF1F2F3),
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: const Color(0xFFF1F2F3),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: const .new(color: Colors.black, fontSize: 14),
          title: const Text('FFI 异步调用 C/C++'),
          leading: ActionButton(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: .only(bottomRight: .circular(18)),
            ),
            child: const Icon(Remix.arrow_left_line, size: 24),
            onTap: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const .all(12),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  '接收端口 ${receivePort1.sendPort.nativePort} 信息：',
                  style: const .new(fontSize: 14, fontWeight: .bold),
                ),
                testLoading1
                    ? const CupertinoActivityIndicator(color: Colors.grey)
                    : Text(testText1, style: const .new(fontSize: 14)),
                const SizedBox(height: 24),
                Text(
                  '接收端口 ${receivePort2.sendPort.nativePort} 信息：',
                  style: const TextStyle(fontSize: 14, fontWeight: .bold),
                ),
                testLoading2
                    ? const CupertinoActivityIndicator(color: Colors.grey)
                    : Text(testText2, style: const .new(fontSize: 14)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
