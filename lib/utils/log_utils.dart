import 'result.dart';

extension LogColorExtension on String {
  String get red => '\x1B[31m$this\x1B[0m';
  String get green => '\x1B[32m$this\x1B[0m';
  String get blue => '\x1B[34m$this\x1B[0m';
}

abstract final class LogUtils {
  static void log(Object? value, {Result<Object?> result = const .success(null)}) {
    switch (result) {
      case Success<Object?>():
        print('${'[log success]'.green} ${value}');
      case Error<Object?>():
        print('${'[log error]'.red} ${value}');
    }
  }
}
