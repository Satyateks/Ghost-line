import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../model/comment_model.dart';
import '../model/post_model.dart';
import '../model/story_model.dart';
import '../model/suggestions_model.dart';

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
        userImage: "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=200&q=80",
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
    _suggestData = SuggestionsModel.fromJson(suggestDataMap);
    loadStories();
    loadPosts();
    loadComments();
  }
  SuggestionsModel? _suggestData;
  SuggestionsModel? get suggestData => _suggestData;

  Map<String, dynamic> suggestDataMap = {
    "data": [
      {
        "userid": 121,
        "name": "Arun Kumar",
        "phone": "9899261043",
        "email": "arunkumar171212@gmail.com",
        "profileImage": "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=300&q=80",
        "designation": 'Software Engineer',
        "following": false
      },
      {
        "userid": 120,
        "name": "Priya",
        "phone": "9991354221",
        "email": "Priya996@gmail.com",
        "profileImage": "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300&q=80",
        "designation": 'UX Designer',
        "following": false
      },
      {
        "userid": 119,
        "name": "Toohina Mishra",
        "phone": "8779889596",
        "email": "Toohina.Mishra-CNT@larsentoubro.com",
        "profileImage":
            "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&q=80",
        "designation": 'Software Engineer',
        "following": false
      },
      {
        "userid": 118,
        "name": "Rahul Sharma",
        "phone": "9876543210",
        "email": "rahul.sharma@gmail.com",
        "profileImage":
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&q=80",
        "designation": "Software Engineer",
        "following": true
      },
      {
        "userid": 117,
        "name": "Neha Verma",
        "phone": "9811122233",
        "email": "neha.verma@gmail.com",
        "profileImage":
            "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=300&q=80",
        "designation": "UI/UX Designer",
        "following": false
      },
      {
        "userid": 116,
        "name": "Amit Singh",
        "phone": "9822233344",
        "email": "amit.singh@gmail.com",
        "profileImage":
            "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=300&q=80",
        "designation": "Product Manager",
        "following": true
      },
      {
        "userid": 115,
        "name": "Sneha Gupta",
        "phone": "9833344455",
        "email": "sneha.gupta@gmail.com",
        "profileImage":
            "https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=300&q=80",
        "designation": "Marketing Lead",
        "following": false
      },
      {
        "userid": 114,
        "name": "Vikas Yadav",
        "phone": "9844455566",
        "email": "vikas.yadav@gmail.com",
        "profileImage":
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&q=80",
        "designation": "Business Analyst",
        "following": false
      },
      {
        "userid": 113,
        "name": "Pooja Kapoor",
        "phone": "9855566677",
        "email": "pooja.kapoor@gmail.com",
        "profileImage":
            "https://images.unsplash.com/photo-1488426862026-3ee34a7d66df?w=300&q=80",
        "designation": "HR Manager",
        "following": true
      },
      {
        "userid": 112,
        "name": "Rohit Mehta",
        "phone": "9866677788",
        "email": "rohit.mehta@gmail.com",
        "profileImage":
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=300&q=80",
        "designation": "DevOps Engineer",
        "following": false
      },
      {
        "userid": 111,
        "name": "Anjali Jain",
        "phone": "9877788899",
        "email": "anjali.jain@gmail.com",
        "profileImage":
            "https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=300&q=80",
        "designation": "QA Engineer",
        "following": false
      }
    ],
    "success": true,
    "totalPages": 12,
    "pageSize": 10,
    "hasPrevious": false,
    "hasNext": true,
    "message": "Follow suggestions retrieved successfully",
    "totalCount": 112,
    "currentPage": 0
  };

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
        postTime: "10:11 PM",
        userName: "Rohit Sharma",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        title: "New UI Design Concept",
        description:
            "Client ne bola tha sirf ek chhota sa update chahiye. "
            "Ab 17 revisions, 3 Zoom calls aur 42 WhatsApp messages baad "
            "hum finally usi design par wapas aa gaye hain jo pehle din approve hua tha. 😂",
        mediaUrl: "https://images.unsplash.com/photo-1498050108023-c5249f4df085",
        likeCount: 120,
        commentCount: 18,
      ),
      PostModel(
        id: "2",
        postTime: "09:45 PM",
        userName: "Aman Verma",
        userImage: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
        title: "Flutter App Demo",
        description:
            "Aaj pura din ek bug fix karne me nikal gaya. "
            "End me pata chala semicolon missing tha. "
            "Software engineering ka asli gym yahi hai, "
            "roz patience ki exercise hoti hai. 🚀😂",
        mediaUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
        isVideo: true,
        likeCount: 88,
        commentCount: 11,
      ),
      PostModel(
        id: "3",
        postTime: "08:30 PM",
        userName: "Priya Kapoor",
        userImage: "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
        title: "Workspace Setup",
        description:
            "Ye workstation setup complete karne me 6 mahine lage. "
            "RGB lights, mechanical keyboard, ultrawide monitor sab aa gaya. "
            "Ab bas kaam karne ka mann bhi aa jaye to setup perfect ho jayega. 😅",
        mediaUrl: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
        likeCount: 245,
        commentCount: 34,
      ),
      PostModel(
        id: "4",
        postTime: "07:15 AM",
        userName: "Karan Singh",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        title: "Morning Ride",
        description:
            "Subah fitness ke liye bike ride par nikla tha. "
            "15 minute baad samajh aaya ki weather enjoy karne se zyada "
            "main traffic aur speed breakers se fight kar raha hoon. 🏍️😂",
        mediaUrl: "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
        likeCount: 92,
        commentCount: 9,
      ),
      PostModel(
        id: "5",
        postTime: "03:20 PM",
        userName: "Neha Gupta",
        userImage: "https://images.unsplash.com/photo-1438761681033-6461ffad8d80",
        title: "Coffee Break",
        description:
            "Coffee lene gaya tha 5 minute ke break ke liye. "
            "Wapas aaya to 45 minute nikal chuke the aur "
            "office gossip ki puri quarterly report mil chuki thi. ☕😂",
        mediaUrl: "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085",
        likeCount: 177,
        commentCount: 23,
      ),
      PostModel(
        id: "6",
        postTime: "06:45 PM",
        userName: "Rahul Mehta",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        title: "Nature Vlog",
        description:
            "Mountain trip plan kiya tha digital detox ke liye. "
            "Result ye hua ki 300 photos, 25 videos aur 8 reels shoot kar li. "
            "Nature kam, content zyada enjoy kiya. 📸😂",
        mediaUrl: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
        isVideo: true,
        likeCount: 310,
        commentCount: 41,
      ),
      PostModel(
        id: "7",
        postTime: "11:00 AM",
        userName: "Simran Kaur",
        userImage: "https://images.unsplash.com/photo-1544005313-94ddf0286df2",
        title: "Fashion Shoot",
        description:
            "Fashion shoot ke liye 4 ghante ready hone me lage. "
            "Photos select karne me 2 ghante aur lag gaye. "
            "Finally jo photo post ki usme aadha face hi visible hai. ✨😂",
        mediaUrl: "https://images.unsplash.com/photo-1524504388940-b1c1722653e1",
        likeCount: 428,
        commentCount: 57,
      ),
      PostModel(
        id: "8",
        postTime: "05:30 PM",
        userName: "Vikas Arora",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        title: "Gym Progress",
        description:
            "Gym join kiye hue 3 mahine ho gaye. "
            "Weight machine abhi bhi wahi number dikha rahi hai, "
            "lekin selfie collection kaafi improve ho gaya hai. 💪📸😂",
        mediaUrl: "https://images.unsplash.com/photo-1517836357463-d25dfeac3438",
        likeCount: 154,
        commentCount: 19,
      ),
      PostModel(
        id: "9",
        postTime: "09:00 PM",
        userName: "Anjali Sharma",
        userImage: "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
        title: "Travel Diaries",
        description:
            "Travel karte waqt ek baat samajh aayi. "
            "Destination se zyada exciting airport ke food prices hote hain. "
            "Ek sandwich dekhkar lagta hai loan apply karna padega. ✈️😂",
        mediaUrl: "https://images.unsplash.com/photo-1500530855697-b586d89ba3ee",
        likeCount: 502,
        commentCount: 68,
      ),
      PostModel(
        id: "10",
        postTime: "02:15 PM",
        userName: "Dev Malhotra",
        userImage: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
        title: "Startup Journey",
        description:
            "Startup build karna roller coaster jaisa hota hai. "
            "Subah lagta hai company unicorn banegi. "
            "Shaam tak lagta hai password reset feature hi launch kar lein to achievement hai. 🚀😂",
        mediaUrl: "https://images.unsplash.com/photo-1552664730-d307ca884978",
        likeCount: 231,
        commentCount: 26,
      ),
      PostModel(
        id: "11",
        postTime: "01:00 PM",
        userName: "Meera Joshi",
        userImage: "https://images.unsplash.com/photo-1544005313-94ddf0286df2",
        title: "Cooking Reel",
        description:
            "Recipe video me sab kuch 30 seconds me ho gaya. "
            "Reality me kitchen saaf karne me cooking se zyada time lag gaya. "
            "Content creators kuch zyada hi optimistic hote hain. 🍝🔥😂",
        mediaUrl: "https://media.istockphoto.com/id/682672086/video/ld-carniolan-honey-bee-hanging-on-to-the-stamens-of-a-white-cherry-blossom.mp4?s=mp4-640x640-is&k=20&c=PFR6kiOEaQxLmfxOPZtb563DG_gBqZWJsI2oVeMNdOk=",
        isVideo: true,
        likeCount: 391,
        commentCount: 49,
      ),
      PostModel(
        id: "12",
        postTime: "06:50 PM",
        userName: "Arjun Patel",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        title: "Sunset Photography",
        description:
            "Sunset dekhne gaya tha thoda relax hone. "
            "Lekin har 2 minute me lag raha tha ki ab wali photo pehle wali se better hai. "
            "Final gallery me 57 almost same photos hain. 🌅📸😂",
        mediaUrl: "https://images.unsplash.com/photo-1506744038136-46273834b3fb",
        likeCount: 287,
        commentCount: 31,
      ),
      PostModel(
        id: "13",
        postTime: "02:15 PM",
        userName: "Meera Malhotra",
        userImage: "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d",
        title: "Startup Journey",
        description:
            "Startup build karna roller coaster jaisa hota hai. "
            "Subah lagta hai company unicorn banegi. "
            "Shaam tak lagta hai password reset feature hi launch kar lein to achievement hai. 🚀😂",
        mediaUrl: "https://cdn.pixabay.com/video/2026/02/23/336253_large.mp4",
        likeCount: 231,isVideo: true,
        commentCount: 26,
      ),      
      PostModel(
        id: "14",
        postTime: "12:30 PM",
        userName: "Vikas Arora",
        userImage: "https://images.unsplash.com/photo-1500648767791-00dcc994a43e",
        title: "Gym Progress",
        description:
            "Gym join kiye hue 3 mahine ho gaye. "
            "Weight machine abhi bhi wahi number dikha rahi hai, "
            "lekin selfie collection kaafi improve ho gaya hai. 💪📸😂",
        mediaUrl: "https://cdn.pixabay.com/video/2025/09/14/304019_large.mp4",
        likeCount: 154,isVideo: true,
        commentCount: 19,
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

        if (comments[i].isLiked) comments[i].likeCount++;
        else comments[i].likeCount--;
        comments.refresh();
        return;
      }

      final replyIndex = comments[i].replies.indexWhere((reply) => reply.id == commentId);

      if (replyIndex != -1) {
        final reply = comments[i].replies[replyIndex];

        reply.isLiked = !reply.isLiked;

        if (reply.isLiked) reply.likeCount++;
        else reply.likeCount--;
        

        comments[i].replies[replyIndex] = reply;
        comments.refresh();
        return;
      }
    }
  }

  Future<Map<String, dynamic>?> followBack(dynamic userId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    if (_suggestData?.data != null) {
      for (var user in _suggestData!.data!) {
        if (user.userid == userId) {
          final isFollowing = user.following ?? false;
          user.following = !isFollowing;
          
          return {
            'action': !isFollowing ? 'followed' : 'unfollowed',
            'message': !isFollowing ? 'Followed successfully' : 'Unfollowed successfully',
          };
        }
      }
    }
    
    return {
      'action': 'followed',
      'message': 'Followed successfully',
    };
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

