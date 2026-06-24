class GreetingModel {
  final String id;
  final String title;
  final String date;
  final String audioUrl;
  bool isPlaying;

  GreetingModel({
    required this.id,
    required this.title,
    required this.date,
    required this.audioUrl,
    this.isPlaying = false,
  });
}