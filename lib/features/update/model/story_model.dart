class StoryModel {
  final String id;
  final String name;
  final String image;
  final bool isOwnStory;
  final bool isViewed;

  StoryModel({
    required this.id,
    required this.name,
    required this.image,
    this.isOwnStory = false,
    this.isViewed = false,
  });
}
