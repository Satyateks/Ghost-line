enum MessageType { text, audio, image, document }

class MessageModel {
  final String id;
  final String message;
  final String time;
  final bool isMe;
  final MessageType type;
  final String? audioDuration;
  final bool isRead;
  final String? filePath;

  MessageModel({
    required this.id,
    required this.message,
    required this.time,
    required this.isMe,
    this.type = MessageType.text,
    this.audioDuration,
    this.isRead = false,
    this.filePath,
  });
}
