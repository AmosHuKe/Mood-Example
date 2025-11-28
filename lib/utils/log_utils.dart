import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'result.dart';

extension LogColorExtension on String {
  String get red {
    /// https://github.com/flutter/flutter/issues/20663
    return switch (defaultTargetPlatform) {
      TargetPlatform.macOS => this,
      _ => '\x1B[31m$this\x1B[0m',
    };
  }

  String get green {
    return switch (defaultTargetPlatform) {
      TargetPlatform.macOS => this,
      _ => '\x1B[32m$this\x1B[0m',
    };
  }

  String get blue {
    return switch (defaultTargetPlatform) {
      TargetPlatform.macOS => this,
      _ => '\x1B[34m$this\x1B[0m',
    };
  }
}

abstract final class LogUtils {
  static void log(Object? value, {Result<Object?> result = const .success(null)}) {
    switch (result) {
      case Success<Object?>():
        print('${'[Log Success]'.green} ${value}');
      case Error<Object?>():
        print('${'[Log Error]'.red} ${value}');
    }
  }

  static void stackTraceLog(
    StackTrace? stackTrace, {
    Result<Object?> result = const .success(null),
    Object? message,
  }) {
    final value = switch (result) {
      Success<Object?>() => result.value,
      Error<Object?>() => result.error,
    };
    final stackLine = stackTrace.toString().split('\n')[0];
    final methodName = RegExp(r'#0\s+([^(]+)').firstMatch(stackLine)?.group(1)?.trim() ?? 'Unknown';
    log('${'[${methodName}]'.blue} ${message != null ? '$message' : '${value}'}', result: result);
  }
}
