import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_request_failure.freezed.dart';

@freezed
sealed class HttpRequestFailure with _$HttpRequestFailure {
  const factory HttpRequestFailure.network() = _Network;
  const factory HttpRequestFailure.notFound() = _NotFound;
  const factory HttpRequestFailure.server() = Server;
  const factory HttpRequestFailure.unauthorized() = Unauthorized;
  const factory HttpRequestFailure.badRequest() = BadRequest;
  const factory HttpRequestFailure.local() = Local;
}
