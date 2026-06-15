import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../core/utils/app_constants.dart';
import 'storage_service.dart';

class SocketService extends GetxService {
  io.Socket? _socket;

  bool get isConnected => _socket?.connected ?? false;

  Future<SocketService> init() async {
    return this;
  }

  void connect() {
    final token = StorageService.instance.token;

    _socket = io.io(
      AppConstants.baseUrl,
      io.OptionBuilder().setTransports(['websocket']).disableAutoConnect().setAuth({'token': token}).build(),
    );

    _socket?.connect();

    _socket?.onConnect((_) {
      debugPrint('Socket connected');
    });

    _socket?.onDisconnect((_) {
      debugPrint('Socket disconnected');
    });

    _socket?.onError((data) {
      debugPrint('Socket error: $data');
    });
  }

  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }

  void emit(String event, dynamic data) {
    if (!isConnected) return;
    _socket?.emit(event, data);
  }

  void listen(String event, Function(dynamic data) callback) {
    _socket?.on(event, callback);
  }

  void off(String event) {
    _socket?.off(event);
  }

  void sendMessage({
    required String chatId,
    required String message,
    String type = 'text',
  }) {
    emit('send_message', {'chat_id': chatId, 'message': message, 'type': type});
  }

  void joinChat(String chatId) {
    emit('join_chat', {'chat_id': chatId});
  }

  void leaveChat(String chatId) {
    emit('leave_chat', {'chat_id': chatId});
  }

  void typing({required String chatId, required bool isTyping}) {
    emit('typing', {'chat_id': chatId, 'is_typing': isTyping});
  }
}
