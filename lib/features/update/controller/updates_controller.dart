import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../model/comment_model.dart';
import '../model/post_model.dart';
import '../model/story_model.dart';

class UpdatesController extends GetxController {
  final stories = <StoryModel>[].obs;
  final posts = <PostModel>[].obs;
  final comments = <CommentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadStories();
    loadPosts();
    loadComments();
  }

  void loadStories() {
    stories.value = [
      StoryModel(
        id: "own",
        name: "Your Story",
        image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
        isOwnStory: true,
      ),
      StoryModel(
        id: "1",
        name: "Rohit",
        image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
      ),
      StoryModel(
        id: "2",
        name: "Aman",
        image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
      ),
      StoryModel(
        id: "3",
        name: "Sneha",
        image: "https://images.unsplash.com/photo-1534528741775-53994a69daeb",
      ),
    ];
  }

  void loadPosts() {
    posts.value = [
      PostModel(
        id: "1",
        userName: "Rohit Sharma",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        title: "New UI Design Concept",
        description: "This is a modern update post with clean layout and media preview.",
        mediaUrl: "https://images.unsplash.com/photo-1498050108023-c5249f4df085",
        likeCount: 120,
        commentCount: 18,
      ),
      PostModel(
        id: "2",
        userName: "Aman Verma",
        userImage: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
        title: "Flutter App Demo",
        description: "Video based update post UI sample.",
        mediaUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        isVideo: true,
        likeCount: 88,
        commentCount: 11,
      ),
    ];
  }

  void loadComments() {
    comments.value = [
      CommentModel(
        id: "1",
        userName: "Sneha",
        userImage: "https://images.unsplash.com/photo-1534528741775-53994a69daeb",
        comment: "Nice update! UI looks very clean.",
        likeCount: 5,
        replies: [
          CommentModel(
            id: "1_r1",
            userName: "Rohit",
            userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
            comment: "Thank you!",
            likeCount: 2,
          ),
        ],
      ),
      CommentModel(
        id: "2",
        userName: "Aman",
        userImage: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
        comment: "Great work bro 🔥",
        likeCount: 3,
      ),
    ];
  }

  void togglePostLike(String postId) {
    final index = posts.indexWhere((e) => e.id == postId);
    if (index == -1) return;

    final post = posts[index];
    post.isLiked = !post.isLiked;
    post.likeCount += post.isLiked ? 1 : -1;

    posts.refresh();
  }

  void toggleCommentLike(String commentId) {
    final index = comments.indexWhere((e) => e.id == commentId);
    if (index == -1) return;

    final comment = comments[index];
    comment.isLiked = !comment.isLiked;
    comment.likeCount += comment.isLiked ? 1 : -1;

    comments.refresh();
  }

  void sharePost(PostModel post) {
    Share.share("${post.title}\n\n${post.description}\n\n${post.mediaUrl}");
  }

  void addComment(String text) {
    if (text.trim().isEmpty) return;

    comments.insert(
      0,
      CommentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userName: "You",
        userImage: "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
        comment: text.trim(),
      ),
    );
  }
}

