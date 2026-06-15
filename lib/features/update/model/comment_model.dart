class CommentModel {
  final String id;
  final String userName;
  final String userImage;
  final String comment;
  bool isLiked;
  int likeCount;
  final List<CommentModel> replies;

  CommentModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.comment,
    this.isLiked = false,
    this.likeCount = 0,
    this.replies = const [],
  });
}

