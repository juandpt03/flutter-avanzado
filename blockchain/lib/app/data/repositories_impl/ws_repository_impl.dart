import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/repositories/ws_repository.dart';

class WsRepositoryImpl implements WsRepository {
  final WebSocketChannel Function() builder;
  StreamSubscription? _subscription;
  StreamController<Map<String, String>>? _streamController;

  WebSocketChannel? _channel;

  WsRepositoryImpl({required this.builder});
  @override
  Future<bool> connect() async {
    try {
      _channel = builder();
      await _channel!.ready;
      _subscription = _channel!.stream.listen(
        (event) {
          final map = Map<String, String>.from(jsonDecode(event));

          if (_streamController?.hasListener ?? false) {
            _streamController?.add(map);
          }
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> disconnect() async {
    await _subscription?.cancel();
    await _streamController?.close();
    await _channel?.sink.close();
    _channel = null;
  }

  @override
  StreamController<Map<String, String>> get onPricesChanged =>
      _streamController ??= StreamController.broadcast();
}
