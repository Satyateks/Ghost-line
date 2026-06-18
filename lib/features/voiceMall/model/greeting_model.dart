class GreetingModel {
  final String id;
  final String title;
  final String date;
  bool isPlaying;

  GreetingModel({
    required this.id,
    required this.title,
    required this.date,
    this.isPlaying = false,
  });
}