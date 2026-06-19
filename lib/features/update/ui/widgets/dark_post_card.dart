import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ghostline/core/utils/utils_route.dart';

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
    return Container(
      color: const Color(0xFF050505),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PostHeader(post: post),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: post.mediaUrl,
                    width: double.infinity,
                    height: 310,
                    fit: BoxFit.cover,
                  ),

                  if (post.isVideo)
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          height: 54,
                          width: 54,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.45),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: Colors.white,
                            size: 36,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
            child: Row(
              children: [
                _IconAction(
                  icon: post.isLiked
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  color: post.isLiked ? Colors.redAccent : Colors.white,
                  onTap: onLike,
                ),
                _IconAction(imagePath: AppAssets.commentIcons, onTap: onComment),
                _IconAction(imagePath: AppAssets.shareIcon, onTap: onShare),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              "${post.likeCount} likes",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "${post.userName} ",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: post.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 4),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Text(
              post.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 12,
                height: 1.35,
              ),
            ),
          ),

          const SizedBox(height: 6),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: GestureDetector(
              onTap: onComment,
              child: Text(
                "View all ${post.commentCount} comments",
                style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 8, 8, 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: CachedNetworkImageProvider(post.userImage),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              post.userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_horiz_rounded,
              color: Colors.white,
              size: 22,
            ),
          ),
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

