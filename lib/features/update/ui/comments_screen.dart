import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
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
    final nameColor = isDark ? Colors.white : AppColors.lightTextPrimary;
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
                borderRadius: BorderRadius.circular(21),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white70 : Colors.black.withOpacity(0.4),
                      shape: BoxShape.circle,
                      border: Border.all(color:isDark ? Colors.white54 : Colors.black.withOpacity(0.4)),
                    ),
                    child: Icon( Icons.close_rounded, color:isDark ? Colors.white54 : Colors.black, size: 24),
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
              borderRadius: const BorderRadius.vertical( top: Radius.circular(21)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBg : AppColors.lightBg,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(21)),
                    border: Border.all(color: isDark ? Colors.white : Colors.black.withOpacity(0.4)),
                    boxShadow: [
                      BoxShadow(
                        color:isDark ? Colors.white : Colors.black.withOpacity(0.4),
                        blurRadius: 30,
                        offset: const Offset(0, -8),
                      ),
                    ],
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Text("Comments",style: AppTextStyles.h3(nameColor)),
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
                            separatorBuilder: (_, __) => Divider(height: 28, thickness: 0.4, color:isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05), indent: 12, endIndent: 12),
                            itemBuilder: (context, index) {
                              final comment = controller.comments[index];

                              return _GlassCommentTile(
                                comment: comment,
                                onLike: ()=> controller.toggleCommentLike(comment.id),
                                onReply: () {
                                  controller.startReply(comment);

                                  commentController.text = "@${comment.userName} ";
                                  commentController.selection = TextSelection.fromPosition(TextPosition(offset: commentController.text.length));
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      Obx(() {
                        if (controller.replyingToUserName.value == null) return const SizedBox.shrink();


                        return Container(
                          margin: const EdgeInsets.fromLTRB(18, 0, 18, 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withOpacity(0.4) : Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color:isDark ? Colors.white.withOpacity(0.4) : Colors.black.withOpacity(0.4)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Replying to ${controller.replyingToUserName.value}",
                                  style: AppTextStyles.bodyMedium(nameColor).copyWith(fontWeight: FontWeight.w400)
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.cancelReply();
                                  commentController.clear();
                                },
                                child: Icon(
                                  Icons.close_rounded,
                                  color: isDark ? Colors.white : Colors.black,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nameColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            height: 54, width: double.infinity,
                    // padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            decoration: BoxDecoration(
               color: isDark ? Colors.black.withOpacity(0.54) : Colors.white.withOpacity(0.82),
               borderRadius: BorderRadius.circular(28),
               border: Border.all(color: isDark ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.95)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 4,
                    cursorColor:nameColor,
                    style: TextStyle(color: nameColor, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: "Comment",
                      hintStyle: TextStyle(color:nameColor, fontSize: 14),
                      border: InputBorder.none,
                    ),
                  ),
                ),
    
                GestureDetector(
                  onTap: onSend,
                  child: Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: Transform.rotate(
                      angle: -0.6,
                      child: Icon(
                        Icons.send_outlined, size: 26,
                        color:isDark ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nameColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final msgColor = isDark ? Colors.white70 : AppColors.lightTextSecondary;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(radius: 21, backgroundImage: NetworkImage(comment.userImage)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text(comment.userName, overflow: TextOverflow.ellipsis, style: AppTextStyles.bodyLarge(nameColor).copyWith(fontWeight: FontWeight.w700))),
                      Text( "10:12 PM", style:AppTextStyles.bodyMedium(msgColor).copyWith(fontWeight: FontWeight.w400)),
                    ],
                  ),

                  const SizedBox(height: 4),
                  Text( comment.comment,style:AppTextStyles.bodyMedium(msgColor)),
                  const SizedBox(height: 8),

                  GestureDetector(onTap: onReply, child: Text( "Reply", style:AppTextStyles.bodyMedium(nameColor))),

                  if (comment.replies.isNotEmpty) ...[
                    const SizedBox(height: 12),

                    Row(
                      children: [
                        Container( height: 1, width: 38, color: nameColor.withOpacity(0.45)),
                        const SizedBox(width: 8),
                        Text( "View ${comment.replies.length} replies", style:AppTextStyles.bodySmall(nameColor).copyWith(fontWeight: FontWeight.w400)),
                      ],
                    ),

                    const SizedBox(height: 12),

                    ...comment.replies.map(
                      (reply) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _ReplyTile(
                          reply: reply,
                          onLike: () {
                            final UpdatesController controller = Get.find<UpdatesController>();
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
                    comment.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: comment.isLiked ? const Color(0xffFF3158) : isDark ? Colors.white : AppColors.lightTextPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(height: 4),
                Text("${comment.likeCount}",style:AppTextStyles.bodySmall(msgColor)),
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

  const _ReplyTile({required this.reply, required this.onLike});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nameColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final msgColor = isDark ? Colors.white70 : AppColors.lightTextSecondary;
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
                  Text(reply.userName,style: AppTextStyles.bodyLarge(nameColor).copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 8),
                  Text("10:12 PM",style:AppTextStyles.bodyMedium(msgColor).copyWith(fontWeight: FontWeight.w400)),
                ],
              ),
              const SizedBox(height: 3),
              Text(reply.comment,style:AppTextStyles.bodyMedium(msgColor)),
            ],
          ),
        ),

        const SizedBox(width: 6),

        Column(
          children: [
            GestureDetector(
              onTap: onLike,
              child: Icon(
                reply.isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                color: reply.isLiked ? const Color(0xffFF3158) :isDark ? Colors.white : AppColors.lightTextPrimary,
                size: 20,
              ),
            ),
            const SizedBox(height: 3),
            Text("${reply.likeCount}",style:AppTextStyles.bodySmall(msgColor)),
          ],
        ),
      ],
    );
  }
}





