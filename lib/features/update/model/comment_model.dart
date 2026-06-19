


class CommentModel {
  final String id;
  final String userName;
  final String userImage;
  final String comment;
  int likeCount;
  bool isLiked;
  List<CommentModel> replies;

  CommentModel({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.comment,
    this.likeCount = 0,
    this.isLiked = false,
    List<CommentModel>? replies,
  }) : replies = replies ?? [];
}