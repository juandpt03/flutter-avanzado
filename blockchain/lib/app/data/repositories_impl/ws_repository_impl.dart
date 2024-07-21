import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/models/ws_status/ws_status.dart';
import '../../domain/repositories/ws_repository.dart';

class WsRepositoryImpl implements WsRepository {
  final WebSocketChannel Function() builder;
  StreamSubscription? _subscription;
  StreamController<Map<String, String>>? _priceController;
  StreamController<WsStatus>? _wsStatus;
  Timer? _timer;
  final Duration timerDuration;

  WebSocketChannel? _channel;

  WsRepositoryImpl(
      {required this.builder, this.timerDuration = const Duration(seconds: 5)});
  @override
  Future<bool> connect() async {
    try {
      notifyStatus(const WsStatus.connecting());
      _channel = builder();
      await _channel!.ready;
      _subscription = _channel!.stream.listen(
        (event) {
          final map = Map<String, String>.from(jsonDecode(event));
          if (_priceController?.hasListener ?? false) {
            _priceController?.add(map);
          }
        },
        onDone: reconnect,
      );

      notifyStatus(const WsStatus.connected());

      return true;
    } catch (e) {
      reconnect();
      return false;
    }
  }

  void notifyStatus(WsStatus status) {
    if (_subscription == null) return;
    if (_priceController?.hasListener ?? false) {
      _wsStatus?.add(status);
    }
  }

  void reconnect() {
    if (_subscription == null) return;
    _timer?.cancel();
    _timer = Timer(
      timerDuration,
      () async {
        await connect();
      },
    );
  }

  @override
  Future<void> disconnect() async {
    _timer?.cancel();
    _timer = null;
    await _subscription?.cancel();
    _subscription = null;
    await _wsStatus?.close();
    await _priceController?.close();
    await _channel?.sink.close();
    _channel = null;
  }

  @override
  StreamController<Map<String, String>> get onPricesChanged =>
      _priceController ??= StreamController.broadcast();

  @override
  StreamController<WsStatus> get wsStatus =>
      _wsStatus ??= StreamController.broadcast();
}
