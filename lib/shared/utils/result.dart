/// 数据结果封装
///
/// 例如：使用 `switch` 来处理结果
/// ```dart
/// switch (result) {
///   case Success(): {
///     print(result.value);
///   }
///   case Error(): {
///     print(result.error);
///   }
/// }
/// ```
sealed class Result<T> {
  const Result();

  /// 成功的 [Result]，返回指定的 [value].
  const factory Result.success(T value) = Success._;

  /// 失败的 [Result]，返回指定的 [error].
  const factory Result.error(Exception error) = Error._;
}

/// Result 子类 Success
final class Success<T> extends Result<T> {
  const Success._(this.value);

  /// 返回值
  final T value;

  @override
  String toString() => 'Result<$T>.Success($value)';
}

/// Result 子类 Error
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// 返回值
  final Exception error;

  @override
  String toString() => 'Result<$T>.error($error)';
}
