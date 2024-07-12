import 'package:flutter/widgets.dart';

import '../../../../domain/repositories/exchange_repository.dart';
import '../../../../domain/repositories/ws_repository.dart';
import 'home_state.dart';

class HomeProvider extends ChangeNotifier {
  final ExchangeRepository exchangeRepository;
  final WsRepository wsRepository;

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
      right: (cryptos) => HomeState.success(cryptos: cryptos),
    );
  }

  Future<bool> startPricesListening() async {
    final response = await wsRepository.connect();

    return response;
  }

  Future<void> disconnect() async {
    await wsRepository.disconnect();
  }
}
