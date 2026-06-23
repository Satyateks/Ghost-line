import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/updates_controller.dart';
import '../model/comment_model.dart';
import '../model/post_model.dart';


class CommentsBottomSheet extends StatelessWidget {
  final PostModel post;

  CommentsBottomSheet({
    super.key,
    required this.post,
  });

  final UpdatesController controller = Get.find<UpdatesController>();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final bottomInset = media.viewInsets.bottom;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SizedBox(
      height: media.size.height * 0.88,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: () => Get.back(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.12),
                      ),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 62,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.72),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.10),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.45),
                        blurRadius: 30,
                        offset: const Offset(0, -8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 18),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Row(
                          children: [
                            const Text(
                              "Comments",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              height: 4,
                              width: 44,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.20),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      Expanded(
                        child: Obx(
                          () => ListView.separated(
                            padding: EdgeInsets.only(
                              left: 18,
                              right: 18,
                              bottom: bottomInset > 0 ? 90 : 18,
                            ),
                            itemCount: controller.comments.length,
                            separatorBuilder: (_, __) => Divider(
                              height: 28,
                              color: Colors.white.withOpacity(0.16),
                            ),
                            itemBuilder: (context, index) {
                              final comment = controller.comments[index];

                              return _GlassCommentTile(
                                comment: comment,
                                onLike: () {
                                  controller.toggleCommentLike(comment.id);
                                },
                                onReply: () {
                                  controller.startReply(comment);

                                  commentController.text = "@${comment.userName} ";
                                  commentController.selection = TextSelection.fromPosition(
                                    TextPosition(offset: commentController.text.length),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      Obx(() {
                        if (controller.replyingToUserName.value == null) {
                          return const SizedBox.shrink();
                        }

                        return Container(
                          margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.12),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Replying to ${controller.replyingToUserName.value}",
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.82),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.cancelReply();
                                  commentController.clear();
                                },
                                child: const Icon(
                                  Icons.close_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      AnimatedPadding(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        padding: EdgeInsets.only(bottom: bottomInset),
                        child: _CommentInputBar(
                          controller: commentController,
                          onSend: () {
                            final text = commentController.text.trim();

                            if (text.isEmpty) return;

                            controller.addComment(text);
                            commentController.clear();
                          },
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class _CommentInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const _CommentInputBar({
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 10, 18, 14),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              height: 54,
              padding: const EdgeInsets.only(left: 18, right: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.10),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.14),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      minLines: 1,
                      maxLines: 4,
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: "Comment",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.65),
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: onSend,
                    child: Container(
                      height: 42,
                      width: 42,
                      alignment: Alignment.center,
                      child: Transform.rotate(
                        angle: -0.6,
                        child: const Icon(
                          Icons.send_outlined,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class _GlassCommentTile extends StatelessWidget {
  final CommentModel comment;
  final VoidCallback onLike;
  final VoidCallback onReply;

  const _GlassCommentTile({
    required this.comment,
    required this.onLike,
    required this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 21,
              backgroundImage: NetworkImage(comment.userImage),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          comment.userName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        "10:12 PM",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.75),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  Text(
                    comment.comment,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.88),
                      fontSize: 14.5,
                      height: 1.25,
                    ),
                  ),

                  const SizedBox(height: 8),

                  GestureDetector(
                    onTap: onReply,
                    child: Text(
                      "Reply",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.92),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  if (comment.replies.isNotEmpty) ...[
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Container(
                          height: 1,
                          width: 38,
                          color: Colors.white.withOpacity(0.45),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "View ${comment.replies.length} replies",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.70),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    ...comment.replies.map(
                      (reply) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _ReplyTile(
                          reply: reply,
                          onLike: () {
                            final UpdatesController controller =
                                Get.find<UpdatesController>();
                            controller.toggleCommentLike(reply.id);
                          },
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(width: 8),

            Column(
              children: [
                GestureDetector(
                  onTap: onLike,
                  child: Icon(
                    comment.isLiked
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: comment.isLiked
                        ? const Color(0xffFF3158)
                        : Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "${comment.likeCount}",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _ReplyTile extends StatelessWidget {
  final CommentModel reply;
  final VoidCallback onLike;

  const _ReplyTile({
    required this.reply,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 15,
          backgroundImage: NetworkImage(reply.userImage),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    reply.userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "10:12 PM",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.58),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 3),

              Text(
                reply.comment,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.82),
                  fontSize: 13.2,
                  height: 1.25,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 6),

        Column(
          children: [
            GestureDetector(
              onTap: onLike,
              child: Icon(
                reply.isLiked
                    ? Icons.favorite_rounded
                    : Icons.favorite_border_rounded,
                color: reply.isLiked ? const Color(0xffFF3158) : Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              "${reply.likeCount}",
              style: TextStyle(
                color: Colors.white.withOpacity(0.75),
                fontSize: 10.5,
              ),
            ),
          ],
        ),
      ],
    );
  }
}





