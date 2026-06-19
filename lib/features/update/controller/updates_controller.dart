import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../model/comment_model.dart';
import '../model/post_model.dart';
import '../model/story_model.dart';

class UpdatesController extends GetxController {
  final stories = <StoryModel>[].obs;
  final posts = <PostModel>[].obs;



  final RxList<CommentModel> comments = <CommentModel>[].obs;

  final RxnString replyingToCommentId = RxnString();
  final RxnString replyingToUserName = RxnString();

  void startReply(CommentModel comment) {
    replyingToCommentId.value = comment.id;
    replyingToUserName.value = comment.userName;
  }

  void cancelReply() {
    replyingToCommentId.value = null;
    replyingToUserName.value = null;
  }

  void addReply({
    required String parentCommentId,
    required String text,
  }) {
    final index = comments.indexWhere((item) => item.id == parentCommentId);

    if (index == -1) return;

    final parentComment = comments[index];

    final replyText = replyingToUserName.value != null
        ? text.replaceFirst("@${replyingToUserName.value}", "").trim()
        : text.trim();

    parentComment.replies.add(
      CommentModel(
        id: "${parentCommentId}_${DateTime.now().millisecondsSinceEpoch}",
        userName: "You",
        userImage:
            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80",
        comment: replyText,
        likeCount: 0,
        replies: [],
      ),
    );

    comments[index] = parentComment;
    comments.refresh();

    cancelReply();
  }




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
        image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300&q=80",
        isOwnStory: true,
      ),
      StoryModel(
        id: "1",
        name: "Rohit",
        image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&q=80",
      ),
      StoryModel(
        id: "2",
        name: "Aman",
        image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&q=80",
      ),
      StoryModel(
        id: "3",
        name: "Sneha",
        image: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=300&q=80",
      ),
      StoryModel(
        id: "4",
        name: "Priya",
        image: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300&q=80",
      ),
      StoryModel(
        id: "5",
        name: "Karan",
        image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&q=80",
      ),
      StoryModel(
        id: "6",
        name: "Neha",
        image: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=300&q=80",
      ),
      StoryModel(
        id: "7",
        name: "Rahul",
        image: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&q=80",
      ),
      StoryModel(
        id: "8",
        name: "Simran",
        image: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=300&q=80",
      ),
      StoryModel(
        id: "9",
        name: "Arjun",
        image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&q=80",
      ),
      StoryModel(
        id: "10",
        name: "Anjali",
        image: "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=300&q=80",
      ),
      StoryModel(
        id: "11",
        name: "Dev",
        image: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&q=80",
      ),
      StoryModel(
        id: "12",
        name: "Meera",
        image: "https://images.unsplash.com/photo-1546961329-78bef0414d7c?w=300&q=80",
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
        description: " I always have to think so hard to come up with a worthy comment. Looking for more 'gen-z' or 'trendy' terms that are highly expressive/animated but still genuine.",
        mediaUrl: "https://samplelib.com/lib/preview/mp4/sample-5s.mp4",
        isVideo: true,
        likeCount: 88,
        commentCount: 11,
      ),
      PostModel(
        id: "3",
        userName: "Priya Kapoor",
        userImage: "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
        title: "Workspace Setup",
        description: "Finally completed my dream workstation setup.",
        mediaUrl: "https://images.unsplash.com/photo-1516321318423-f06f85e504b3",
        likeCount: 245,
        commentCount: 34,
      ),
      PostModel(
        id: "4",
        userName: "Karan Singh",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        title: "Morning Ride",
        description: "Beautiful weather for a long bike ride today.",
        mediaUrl: "https://images.unsplash.com/photo-1558980664-10ea292f2c9a",
        likeCount: 92,
        commentCount: 9,
      ),
      PostModel(
        id: "5",
        userName: "Neha Gupta",
        userImage: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80",
        title: "Coffee Break",
        description: "Nothing beats a fresh cup of coffee while coding.",
        mediaUrl: "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085",
        likeCount: 177,
        commentCount: 23,
      ),
      PostModel(
        id: "6",
        userName: "Rahul Mehta",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        title: "Nature Vlog",
        description: "Weekend getaway in the mountains.",
        mediaUrl: "https://samplelib.com/lib/preview/mp4/sample-5s.mp4",
        isVideo: true,
        likeCount: 310,
        commentCount: 41,
      ),
      PostModel(
        id: "7",
        userName: "Simran Kaur",
        userImage: "https://images.unsplash.com/photo-1544005313-94ddf0286df2",
        title: "Fashion Shoot",
        description: "Latest photoshoot highlights.",
        mediaUrl: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1",
        likeCount: 428,
        commentCount: 57,
      ),
      PostModel(
        id: "8",
        userName: "Vikas Arora",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        title: "Gym Progress",
        description: "Consistency is the key to success.",
        mediaUrl: "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
        likeCount: 154,
        commentCount: 19,
      ),
      PostModel(
        id: "9",
        userName: "Anjali Sharma",
        userImage: "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
        title: "Travel Diaries",
        description: "Exploring hidden gems around the world.",
        mediaUrl: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
        likeCount: 502,
        commentCount: 68,
      ),
      PostModel(
        id: "10",
        userName: "Dev Malhotra",
        userImage: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
        title: "Startup Journey",
        description: "Sharing lessons learned while building products.",
        mediaUrl: "https://images.unsplash.com/photo-1552664730-d307ca884978",
        likeCount: 231,
        commentCount: 26,
      ),
      PostModel(
        id: "11",
        userName: "Meera Joshi",
        userImage: "https://images.unsplash.com/photo-1544005313-94ddf0286df2",
        title: "Cooking Reel",
        description: "Quick and easy homemade pasta recipe.",
        mediaUrl: "https://samplelib.com/lib/preview/mp4/sample-5s.mp4",
        isVideo: true,
        likeCount: 391,
        commentCount: 49,
      ),
      PostModel(
        id: "12",
        userName: "Arjun Patel",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        title: "Sunset Photography",
        description: "Captured this beautiful sunset yesterday.",
        mediaUrl: "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
        likeCount: 287,
        commentCount: 31,
      ),
    ];
  }
  
  void loadComments() {
    comments.value = [
      CommentModel(
        id: "1",
        userName: "Sneha",
        userImage: "https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&q=80",
        comment: "Nice update! UI looks very clean. 👏",
        likeCount: 12,
        replies: [
          CommentModel(
            id: "1_r1",
            userName: "Rohit",
            userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&q=80",
            comment: "Thank you so much 🙌",
            likeCount: 4,
          ),
          CommentModel(
            id: "1_r2",
            userName: "Aman",
            userImage: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&q=80",
            comment: "Totally agree! 🔥",
            likeCount: 2,
          ),
        ],
      ),

      CommentModel(
        id: "2",
        userName: "Aman",
        userImage: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&q=80",
        comment: "Great work bro 🔥",
        likeCount: 8,
      ),

      CommentModel(
        id: "3",
        userName: "Priya",
        userImage: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80",
        comment: "I always have to think so hard to come up with a worthy comment. Looking for more 'gen-z' or 'trendy' terms that are highly expressive/animated but still genuine.✨",
        likeCount: 15,
        replies: [
          CommentModel(
            id: "3_r1",
            userName: "Neha",
            userImage: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=200&q=80",
            comment: "Exactly! The typography is also very good.",
            likeCount: 3,
          ),
        ],
      ),

      CommentModel(
        id: "4",
        userName: "Rahul",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&q=80",
        comment: "Which package did you use for the video player?",
        likeCount: 6,
      ),

      CommentModel(
        id: "5",
        userName: "Simran",
        userImage: "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=200&q=80",
        comment: "This is one of the cleanest Flutter UIs I've seen recently ❤️",
        likeCount: 27,
      ),

      CommentModel(
        id: "6",
        userName: "Karan",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&q=80",
        comment: "Waiting for dark mode screenshots 😍",
        likeCount: 11,
        replies: [
          CommentModel(
            id: "6_r1",
            userName: "Rohit",
            userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200&q=80",
            comment: "Will share them soon 🚀",
            likeCount: 5,
          ),
        ],
      ),

      CommentModel(
        id: "7",
        userName: "Anjali",
        userImage: "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=200&q=80",
        comment: "Amazing attention to detail 👌",
        likeCount: 9,
      ),

      CommentModel(
        id: "8",
        userName: "Dev",
        userImage: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200&q=80",
        comment: "Saved this post for inspiration. 🙌",
        likeCount: 14,
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
    for (int i = 0; i < comments.length; i++) {
      if (comments[i].id == commentId) {
        comments[i].isLiked = !comments[i].isLiked;

        if (comments[i].isLiked) {
          comments[i].likeCount++;
        } else {
          comments[i].likeCount--;
        }

        comments.refresh();
        return;
      }

      final replyIndex =
          comments[i].replies.indexWhere((reply) => reply.id == commentId);

      if (replyIndex != -1) {
        final reply = comments[i].replies[replyIndex];

        reply.isLiked = !reply.isLiked;

        if (reply.isLiked) {
          reply.likeCount++;
        } else {
          reply.likeCount--;
        }

        comments[i].replies[replyIndex] = reply;
        comments.refresh();
        return;
      }
    }
  }


  void sharePost(PostModel post) {
    Share.share("${post.title}\n\n${post.description}\n\n${post.mediaUrl}");
  }

  void addComment(String text) {
    final cleanText = text.trim();

    if (cleanText.isEmpty) return;

    if (replyingToCommentId.value != null) {
      addReply(
        parentCommentId: replyingToCommentId.value!,
        text: cleanText,
      );
      return;
    }

    comments.insert(
      0,
      CommentModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userName: "You",
        userImage:
            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80",
        comment: cleanText,
        likeCount: 0,
        replies: [],
      ),
    );
  }

}

