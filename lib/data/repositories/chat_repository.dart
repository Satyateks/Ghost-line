
import 'package:get/get.dart';


import '../../core/utils/network_guard.dart';
import '../services/services_route.dart';

class ChatRepository {
  final ApiService _api = ApiService.instance;
  final SocketService _socket = Get.find<SocketService>();

  Future<List<dynamic>> getChats() async {
    final response = await _api.get('/chats');

    final data = response.data;

    if (data is List) return data;

    if (data is Map && data['data'] is List) {
      return data['data'];
    }

    return [];
  }

  Future<List<dynamic>> getMessages({
    required String chatId,
    int page = 1,
  }) async {
    final response = await _api.get(
      '/chats/$chatId/messages',
      query: {
        'page': page,
      },
    );

    final data = response.data;

    if (data is List) return data;

    if (data is Map && data['data'] is List) {
      return data['data'];
    }

    return [];
  }

  Future<Map<String, dynamic>> sendMessage({
    required String chatId,
    required String message,
    String type = 'text',
  }) async {
    final response = await _api.post(
      '/chats/$chatId/messages',
      data: {
        'message': message,
        'type': type,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> createChat({
    required String receiverId,
  }) async { 
    final response = await _api.post(
      '/chats',
      data: {
        'receiver_id': receiverId,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<void> markAsRead({
    required String chatId,
  }) async {
    if (!await NetworkGuard.canProceed()) return;
    await _api.post('/chats/$chatId/read');
  }

  void connectSocket() {
    _socket.connect();
  }

  void disconnectSocket() {
    _socket.disconnect();
  }

  void joinChat(String chatId) {
    _socket.joinChat(chatId);
  }

  void leaveChat(String chatId) {
    _socket.leaveChat(chatId);
  }

  void sendSocketMessage({
    required String chatId,
    required String message,
    String type = 'text',
  }) {
    _socket.sendMessage(
      chatId: chatId,
      message: message,
      type: type,
    );
  }

  void listenNewMessage(Function(dynamic data) callback) {
    _socket.listen('new_message', callback);
  }

  void listenTyping(Function(dynamic data) callback) {
    _socket.listen('typing', callback);
  }

  void typing({
    required String chatId,
    required bool isTyping,
  }) {
    _socket.typing(
      chatId: chatId,
      isTyping: isTyping,
    );
  }
}