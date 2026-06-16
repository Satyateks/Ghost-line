import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/updates_controller.dart';
import '../model/post_model.dart';
import 'widgets/comment_item.dart';


class CommentsScreen extends StatelessWidget {
  CommentsScreen({super.key});

  final UpdatesController controller = Get.find<UpdatesController>();
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PostModel post = Get.arguments as PostModel;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.cardColor,
              border: Border(
                bottom: BorderSide(
                  color: theme.dividerColor.withOpacity(0.4),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  post.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(
              () => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: controller.comments.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final comment = controller.comments[index];

                  return CommentItem(
                    comment: comment,
                    onLike: () => controller.toggleCommentLike(comment.id),
                    onReply: () {
                      commentController.text = "@${comment.userName} ";
                    },
                  );
                },
              ),
            ),
          ),

          SafeArea(
            top: false,
            child: Container(
              padding: EdgeInsets.only(
                left: 14,
                right: 14,
                top: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                border: Border(
                  top: BorderSide(
                    color: theme.dividerColor.withOpacity(0.4),
                  ),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 19,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: commentController,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Write a comment...",
                        filled: true,
                        fillColor: theme.cardColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 11,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: () {
                      controller.addComment(commentController.text);
                      commentController.clear();
                    },
                    icon: const Icon(Icons.send_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}




