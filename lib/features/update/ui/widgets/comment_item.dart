import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/comment_model.dart';


class CommentItem extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onLike;
  final VoidCallback onReply;

  const CommentItem({
    super.key,
    required this.comment,
    required this.onLike,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: CachedNetworkImageProvider(comment.userImage),
        ),
        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.userName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      comment.comment,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 6),

              Row(
                children: [
                  GestureDetector(
                    onTap: onLike,
                    child: Text(
                      comment.isLiked ? "Liked" : "Like",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: comment.isLiked
                            ? Colors.red
                            : theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: onReply,
                    child: Text(
                      "Reply",
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "${comment.likeCount} likes",
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.textTheme.bodySmall?.color?.withOpacity(0.55),
                    ),
                  ),
                ],
              ),

              if (comment.replies.isNotEmpty) ...[
                const SizedBox(height: 10),
                ...comment.replies.map(
                  (reply) => Padding(
                    padding: const EdgeInsets.only(left: 18, top: 8),
                    child: CommentItem(
                      comment: reply,
                      onLike: () {},
                      onReply: () {},
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}







