import 'dart:async';

import 'package:flutter/widgets.dart';

import '../../../../domain/repositories/exchange_repository.dart';
import '../../../../domain/repositories/ws_repository.dart';
import 'home_state.dart';

class HomeProvider extends ChangeNotifier {
  final ExchangeRepository exchangeRepository;
  final WsRepository wsRepository;
  StreamSubscription<Map<String, String>>? _subscription;

  HomeState _state = const HomeState.loading();
  HomeProvider({
    required this.exchangeRepository,
    required this.wsRepository,
  }) {
    _init();
  }

  HomeState get state => _state;

  set state(HomeState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> _init() async {
    state.maybeWhen(
      loading: () {},
      orElse: () {
        state = const HomeState.loading();
      },
    );

    final response = await exchangeRepository.getPrices();

    state = response.when(
      left: (error) => HomeState.failed(error: error),
      right: (cryptos) {
        startPricesListening();
        _onPricesChanged();
        return HomeState.success(cryptos: cryptos);
      },
    );
  }

  Future<bool> startPricesListening() async {
    final response = await wsRepository.connect();

    state.mapOrNull(
      success: (state) {
        this.state = state.copyWith(
          wsStatus:
              response ? const WsStatus.connected() : const WsStatus.failed(),
        );
      },
    );

    return response;
  }

  Future<void> disconnect() async {
    await wsRepository.disconnect();
  }

  Future<void> _onPricesChanged() async {
    _subscription?.cancel();
    _subscription = wsRepository.onPricesChanged.stream.listen(
      (changes) {
        state.mapOrNull(
          success: (state) {
            this.state = state.copyWith(
              cryptos: [
                ...state.cryptos.map(
                  (crypto) {
                    if (changes.containsKey(crypto.id)) {
                      return crypto.copyWith(priceUsd: changes[crypto.id]!);
                    }
                    return crypto;
                  },
                ).toList()
              ],
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
