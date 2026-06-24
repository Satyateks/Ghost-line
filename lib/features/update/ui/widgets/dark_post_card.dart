import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghostline/core/utils/utils_route.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../model/post_model.dart';

class DarkPostCard extends StatelessWidget {
  final PostModel post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const DarkPostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
     final isDark = Theme.of(context).brightness == Brightness.dark;
     final msgColor = isDark ? Colors.white70 : AppColors.lightTextSecondary;
    return Container(
      color:isDark ? AppColors.darkBg : AppColors.lightBg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PostHeader(post: post),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              post.description,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
             style: AppTextStyles.bodyLarge(msgColor)
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: post.isVideo
                ? _VideoPreview(videoUrl: post.mediaUrl)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: CachedNetworkImage(
                      imageUrl: post.mediaUrl,
                      width: double.infinity,
                      height: 199,
                      fit: BoxFit.cover,

                      // Loading state
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return Container(
                          height: 199,
                          color: isDark? Colors.grey.shade100:Colors.black.withOpacity(0.05),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  downloadProgress.progress != null
                                      ? "${(downloadProgress.progress! * 100).toStringAsFixed(0)}%"
                                      : "Loading image...",
                                ),
                              ],
                            ),
                          ),
                        );
                      },

                      // Error state
                      errorWidget: (context, url, error) {
                        debugPrint("Image Error: $error");
                        debugPrint("Image URL: $url");

                        return Container(
                          height: 199,
                          color: isDark? Colors.grey.shade100:Colors.black.withOpacity(0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.broken_image_outlined,
                                size: 40,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "Image unavailable",
                                style: TextStyle(
                                  color: msgColor,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
            child: Row(
              children: [
                _IconAction(
                  icon: post.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: post.isLiked ? Colors.redAccent : isDark ? Colors.white : AppColors.lightTextPrimary,
                  onTap: onLike,
                ),Text("${post.likeCount} likes", style: AppTextStyles.bodyMedium(msgColor)),
                _IconAction(imagePath: AppAssets.commentIcons, onTap: onComment,color: isDark ? Colors.white : AppColors.lightTextPrimary,),
                GestureDetector(onTap: onComment, child: Text( "${post.commentCount}", style: AppTextStyles.bodyMedium(msgColor))),
                _IconAction(imagePath: AppAssets.shareIcon, onTap: onShare,color: isDark ? Colors.white : AppColors.lightTextPrimary,),
              ],
            ),
          ),

          const SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan( text: "${post.userName} ",style: AppTextStyles.bodyMedium(msgColor)),
                  TextSpan(text: post.title,style: AppTextStyles.bodyMedium(msgColor)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Divider(height: 1, thickness: 0.4, color:isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05), indent: 12, endIndent: 12),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  final PostModel post;

  const _PostHeader({required this.post});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nameColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 8, 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 21,
            backgroundImage: CachedNetworkImageProvider(post.userImage),
          ),
          const SizedBox(width: 10),
          Column(mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(post.userName,style: AppTextStyles.bodyHighLarge(nameColor).copyWith(fontWeight: FontWeight.w700)),
              Text(post.postTime, style: AppTextStyles.chatName(nameColor).copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
          // IconButton(onPressed: () {},icon:Icon(Icons.more_horiz_rounded, color:nameColor, size: 22)),
        ],
      ),
    );
  }
}

class _IconAction extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final Color color;
  final VoidCallback onTap;
  final double size;

  const _IconAction({
    this.icon,
    this.imagePath,
    required this.onTap,
    this.color = Colors.white,
    // ignore: unused_element_parameter
    this.size = 25,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: onTap,
      icon: imagePath != null
          ? Image.asset(
              imagePath!,
              width: size,
              height: size,
              color: color,
            )
          : Icon(
              icon,
              color: color,
              size: size,
            ),
    );
  }
}

class _VideoPreview extends StatefulWidget {
  final String videoUrl;
  const _VideoPreview({ required this.videoUrl });

  @override
  State<_VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<_VideoPreview> {
  late VideoPlayerController controller;
  bool isReady = false;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    )..initialize().then((_) {
        if (!mounted) return;
        setState(() => isReady = true);
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isReady) {
      return Container(
        height: 199,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                controller.value.isPlaying
                    ? controller.pause()
                    : controller.play();
              });
            },
            child: CircleAvatar(
              radius: 28,
              backgroundColor: Colors.black.withOpacity(0.45),
              child: Icon(
                controller.value.isPlaying
                    ? Icons.pause_rounded
                    : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

