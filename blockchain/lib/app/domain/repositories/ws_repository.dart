import 'dart:async';

abstract class WsRepository {
  Future<bool> connect();
  Future<void> disconnect();
  StreamController<Map<String, String>> get onPricesChanged;
}
