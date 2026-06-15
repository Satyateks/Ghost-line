class ChatItemModel {
  final String id;
  final String name;
  final String message;
  final String time;
  final String avatar;
  final int unreadCount;
  final bool isArchived;
  final bool isGroup;
  final bool isOnline;

  ChatItemModel({
    required this.id,
    required this.name,
    required this.message,
    required this.time,
    required this.avatar,
    this.unreadCount = 0,
    this.isArchived = false,
    this.isGroup = false,
    this.isOnline = false,
  });
}
