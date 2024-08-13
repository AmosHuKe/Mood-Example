import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:go_router/go_router.dart';
import 'package:remixicon/remixicon.dart';

import 'package:moodexample/themes/app_theme.dart';

import 'package:moodexample/widgets/action_button/action_button.dart';

/// 类型定义
/// DartApi 初始化
typedef NativeDartInitializeApiDL = Int32 Function(Pointer<Void> data);
typedef DartInitializeApiDL = int Function(Pointer<Void> data);

/// DartApi 注册线程
typedef NativeRegisterSendPort = Void Function(Int64, Int);
typedef RegisterSendPort = void Function(int, int);

class FFIPage extends StatefulWidget {
  const FFIPage({super.key});

  @override
  State<FFIPage> createState() => _FFIPageState();
}

class _FFIPageState extends State<FFIPage> {
  ///
  late DynamicLibrary _dl;

  /// 接收端口1
  final ReceivePort _receivePort1 = ReceivePort();

  /// 接收端口2
  final ReceivePort _receivePort2 = ReceivePort();

  late String _testText1 = '';
  late String _testText2 = '';
  late bool _testLoading1 = true;
  late bool _testLoading2 = true;

  @override
  void initState() {
    super.initState();

    ffiInit();
    ffiTest1();
    ffiTest2();
  }

  @override
  void dispose() {
    _receivePort1.close();
    _receivePort2.close();

    super.dispose();
  }

  /// 初始化 FFI
  void ffiInit() {
    /// 加载库 符号表
    _dl = Platform.isAndroid
        ? DynamicLibrary.open('libffi.so')
        : DynamicLibrary.process();

    /// 查找 DartApi 初始化函数
    final DartInitializeApiDL initDartApiDL =
        _dl.lookupFunction<NativeDartInitializeApiDL, DartInitializeApiDL>(
      'InitDartApiDL',
    );

    /// 调用初始化函数，并判断是否成功
    final int dartApiInited = initDartApiDL(NativeApi.initializeApiDLData);

    if (dartApiInited == 0) {
      print('初始化 Dart Native API 成功');
    } else {
      print('初始化 Dart Native API 失败');
    }
  }

  /// FFI 测试1
  void ffiTest1() {
    /// 监听接收端口
    _receivePort1.listen((message) {
      setState(() {
        _testText1 = '$message\ntype=${message.runtimeType}';
        _testLoading1 = false;
      });

      /// 关闭端口
      _receivePort1.close();
    });

    /// 查找 注册线程函数
    final RegisterSendPort registerSendPort =
        _dl.lookupFunction<NativeRegisterSendPort, RegisterSendPort>(
      'RegisterSendPort',
    );

    /// 调用 开启线程并传入参数
    registerSendPort(_receivePort1.sendPort.nativePort, 3);
  }

  /// FFI 测试2
  void ffiTest2() {
    /// 监听接收端口
    _receivePort2.listen((message) {
      setState(() {
        _testText2 = '$message\ntype=${message.runtimeType}';
        _testLoading2 = false;
      });

      /// 关闭端口
      _receivePort2.close();
    });

    /// 查找 注册线程函数
    final RegisterSendPort registerSendPort =
        _dl.lookupFunction<NativeRegisterSendPort, RegisterSendPort>(
      'RegisterSendPort',
    );

    /// 调用 开启线程并传入参数
    registerSendPort(_receivePort2.sendPort.nativePort, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Scaffold(
        backgroundColor: const Color(0xFFF6F8FA),
        appBar: AppBar(
          elevation: 0,
          forceMaterialTransparency: true,
          backgroundColor: const Color(0xFFF6F8FA),
          foregroundColor: Colors.black87,
          shadowColor: Colors.transparent,
          titleTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
          title: const Text('FFI 异步调用 C/C++'),
          leading: ActionButton(
            decoration: const BoxDecoration(
              color: AppTheme.backgroundColor1,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(18),
              ),
            ),
            child: const Icon(Remix.arrow_left_line, size: 24),
            onTap: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '接收端口 ${_receivePort1.sendPort.nativePort} 信息：',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _testLoading1
                    ? const CupertinoActivityIndicator()
                    : Text(
                        _testText1,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                const SizedBox(height: 24),
                Text(
                  '接收端口 ${_receivePort2.sendPort.nativePort} 信息：',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _testLoading2
                    ? const CupertinoActivityIndicator()
                    : Text(
                        _testText2,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
