class PostModel {
  final String id;
  final String userName;
  final String postTime;
  final String userImage;
  final String title;
  final String description;
  final String mediaUrl;
  final bool isVideo;
  bool isLiked;
  int likeCount;
  int commentCount;

  PostModel({
    required this.id,
    required this.userName,
    required this.postTime,
    required this.userImage,
    required this.title,
    required this.description,
    required this.mediaUrl,
    this.isVideo = false,
    this.isLiked = false,
    this.likeCount = 0,
    this.commentCount = 0,
  });
}

