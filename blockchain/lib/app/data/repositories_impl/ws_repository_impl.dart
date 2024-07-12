import 'package:web_socket_channel/web_socket_channel.dart';

import '../../domain/repositories/ws_repository.dart';

class WsRepositoryImpl implements WsRepository {
  final WebSocketChannel Function() builder;

  WebSocketChannel? _channel;

  WsRepositoryImpl({required this.builder});
  @override
  Future<bool> connect() async {
    try {
      _channel = builder();
      _channel!.ready;
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> disconnect() async {
    await _channel?.sink.close();
    _channel = null;
  }
}
