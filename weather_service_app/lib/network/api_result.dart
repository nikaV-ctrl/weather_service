import 'package:freezed_annotation/freezed_annotation.dart';
import 'network_exceptions.dart';

part 'api_result.freezed.dart';

@freezed
class Result<T> with _$Result<T> {
  /// Create an `Success` result with the given value
  const factory Result.success(T data) = _Success<T>;

  /// Create an `Failure` result with the given Exception
  const factory Result.failure(NetworkExceptions error) = _Failure<T>;
}
