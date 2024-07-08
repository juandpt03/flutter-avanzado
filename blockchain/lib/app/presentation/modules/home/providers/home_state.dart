import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/models/crypto/crypto.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  factory HomeState.loading() = _HomeStateLoading;
  factory HomeState.failed({required String message}) = _HomeStateFailed;
  factory HomeState.success({required List<Crypto> cryptos}) =
      _HomeStateSuccess;
}
