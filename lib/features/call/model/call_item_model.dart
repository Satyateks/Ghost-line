enum CallType { audio, video}

class CallItemModel {
  final String id;
  final String name;
  final String avatar;
  final String time;
  final CallType type;
  final bool isRecent;
  final bool isMissed;

  CallItemModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.time,
    this.type = CallType.audio,
    this.isRecent = true,
    this.isMissed = false,
  });
}
