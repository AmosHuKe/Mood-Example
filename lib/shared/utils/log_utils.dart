import 'package:flutter/foundation.dart' show TargetPlatform, defaultTargetPlatform, kDebugMode;
import 'package:logging/logging.dart';
import 'result.dart';

extension LogColorExtension on String {
  String get red {
    /// https://github.com/flutter/flutter/issues/20663
    return switch (defaultTargetPlatform) {
      TargetPlatform.macOS || TargetPlatform.iOS => this,
      _ => '\x1B[31m$this\x1B[0m',
    };
  }

  String get green {
    return switch (defaultTargetPlatform) {
      TargetPlatform.macOS || TargetPlatform.iOS => this,
      _ => '\x1B[32m$this\x1B[0m',
    };
  }

  String get blue {
    return switch (defaultTargetPlatform) {
      TargetPlatform.macOS || TargetPlatform.iOS => this,
      _ => '\x1B[34m$this\x1B[0m',
    };
  }
}

class Log {
  Log._();
  static final Log instance = Log._();
  Logger? _instance;
  Logger get root => _instance ??= _init();

  static bool get isDebug => kDebugMode;

  Logger _init() {
    hierarchicalLoggingEnabled = true;
    final rootLogger = Logger('ROOT');
    rootLogger.level = isDebug ? Level.ALL : Level.OFF;
    return rootLogger;
  }

  /// 监听日志记录
  void onRecord() {
    if (!isDebug) return;
    root.onRecord.listen((LogRecord rec) {
      // print('[${rec.time}] ${rec.message}');
      print('${rec.message}');
    });
  }

  void info(Object? value) {
    if (!isDebug) return;
    root.info('${'[Log Info]'.blue} ${value}');
  }

  void success(Object? value) {
    if (!isDebug) return;
    root.info('${'[Log Success]'.green} ${value}');
  }

  void error(Object? value, [Object? error, StackTrace? stackTrace]) {
    if (!isDebug) return;
    root.severe('${'[Log Error]'.red} ${value}', error, stackTrace);
  }

  /// 针对 [Result] 的日志输出
  void resultLog(Result<Object?> result, Object? value) {
    if (!isDebug) return;
    switch (result) {
      case Success<Object?>():
        success(value);
      case Error<Object?>():
        error(value);
    }
  }

  /// 针对 [Result] 带有堆栈信息的日志输出
  void resultStackTraceLog(StackTrace stackTrace, Result<Object?> result, [Object? message]) {
    if (!isDebug) return;
    final value = switch (result) {
      Success<Object?>() => result.value,
      Error<Object?>() => result.error,
    };
    final stackLine = stackTrace.toString().split('\n')[0];
    final methodName = RegExp(r'#0\s+([^(]+)').firstMatch(stackLine)?.group(1)?.trim() ?? 'Unknown';

    resultLog(result, '${'[${methodName}]'.blue} ${message != null ? '$message' : '$value'}');
  }
}
