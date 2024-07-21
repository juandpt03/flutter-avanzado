import 'dart:async';

import '../models/ws_status/ws_status.dart';

abstract class WsRepository {
  Future<bool> connect();
  Future<void> disconnect();
  StreamController<Map<String, String>> get onPricesChanged;
  StreamController<WsStatus> get wsStatus;
}
