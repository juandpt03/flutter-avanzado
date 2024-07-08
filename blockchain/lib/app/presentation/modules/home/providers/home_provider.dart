import 'package:flutter/widgets.dart';

import '../../../../domain/repositories/exchange_repository.dart';
import 'home_state.dart';

class HomeProvider extends ChangeNotifier {
  final ExchangeRepository exchangeRepository;

  HomeState _state = HomeState.loading();
  HomeProvider({required this.exchangeRepository}) {
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
        state = HomeState.loading();
      },
    );

    final response = await exchangeRepository.getPrices();

    state = response.when(
      left: (error) => HomeState.failed(message: error.name),
      right: (cryptos) => HomeState.success(cryptos: cryptos),
    );
  }
}
