import 'dart:ffi';

import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:remixicon/remixicon.dart';

import '../../../../widgets/action_button/action_button.dart';
import 'ffi_bindings.dart';

class FFIScreen extends StatefulWidget {
  const FFIScreen({super.key});

  @override
  State<FFIScreen> createState() => _FFIScreenState();
}

class _FFIScreenState extends State<FFIScreen> {
  NativeCallable<NativeResultCallback>? _cb1;
  NativeCallable<NativeResultCallback>? _cb2;

  String testText1 = '';
  String testText2 = '';
  bool testLoading1 = true;
  bool testLoading2 = true;

  @override
  void initState() {
    super.initState();
    ffiTest1();
    ffiTest2();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// FFI 测试 1：3 秒后回调
  void ffiTest1() {
    _cb1 = NativeCallable<NativeResultCallback>.listener((int threadId, int seconds) {
      if (mounted) {
        setState(() {
          testText1 = '这是线程 $threadId\n设定 $seconds 秒后的消息';
          testLoading1 = false;
        });
      }
      _cb1?.close();
      _cb1 = null;
    });
    registerCallback(_cb1!.nativeFunction, 3);
  }

  /// FFI 测试 2：1 秒后回调
  void ffiTest2() {
    _cb2 = NativeCallable<NativeResultCallback>.listener((int threadId, int seconds) {
      if (mounted) {
        setState(() {
          testText2 = '这是线程 $threadId\n设定 $seconds 秒后的消息';
          testLoading2 = false;
        });
      }
      _cb2?.close();
      _cb2 = null;
    });
    registerCallback(_cb2!.nativeFunction, 1);
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
          title: const Text('FFI (Hooks) 异步调用 C/C++'),
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
                const Text('线程 1 信息：', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                testLoading1
                    ? const CupertinoActivityIndicator(color: Colors.grey)
                    : Text(testText1, style: const .new(fontSize: 14)),
                const SizedBox(height: 24),
                const Text('线程 2 信息：', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
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
