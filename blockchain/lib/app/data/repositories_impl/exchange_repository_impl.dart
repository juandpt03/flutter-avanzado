import '../../domain/repositories/exchange_repository.dart';
import '../services/remote/exchage_api.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeAPI api;

  ExchangeRepositoryImpl({required this.api});
  @override
  GetPricesFuture getPrices() async {
    return api.getPrices();
  }
}
