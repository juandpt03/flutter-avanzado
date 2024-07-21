import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/failures/http_request_failure.dart';
import '../../../../domain/models/crypto/crypto.dart';
import '../../../../domain/models/ws_status/ws_status.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState.loading() = _Loading;
  const factory HomeState.failed({required HttpRequestFailure error}) = _Failed;
  const factory HomeState.success({
    required List<Crypto> cryptos,
    @Default(WsStatus.connecting()) WsStatus wsStatus,
  }) = _Success;
}
