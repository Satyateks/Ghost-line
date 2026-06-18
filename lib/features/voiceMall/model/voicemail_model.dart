class VoicemailModel {
  final String id;
  final String name;
  final String image;
  final String message;
  final String date;
  final String time;
  final String duration;
  final bool isRecent;
  bool isPlaying;
  bool isRead;

  VoicemailModel({
    required this.id,
    required this.name,
    required this.image,
    required this.message,
    required this.date,
    required this.time,
    required this.duration,
    required this.isRecent,
    this.isPlaying = false,
    this.isRead = false,
  });
}
