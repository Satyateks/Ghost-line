import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../home/controller/home_controller.dart';
import '../../home/ui/widgets/main_bottom_nav.dart';
import '../controller/updates_controller.dart';
import 'comments_screen.dart';
import 'widgets/dark_post_card.dart';
import 'widgets/dark_story_item.dart';
import 'widgets/story_viewerScreen.dart';

class UpdatesScreen extends StatelessWidget {
  UpdatesScreen({super.key});

  final UpdatesController controller = Get.put(UpdatesController());
  final HomeController homeCtrl = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050505),
      bottomNavigationBar: MainBottomNav(controller: homeCtrl),
      body: SafeArea(
        child: Obx(
          () => CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                  child: Row(
                    children: [
                      Text(
                        "Updates",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 22,
                            ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  height: 92,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.stories.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final story = controller.stories[index];

                      return DarkStoryItem(
                        story: story,
                        onTap: () {
                          if (story.isOwnStory) {
                            // TODO: open add story picker
                          } else {
                            Get.to(StoryViewerScreen(),arguments: story);
                          }

                        },
                      );
                    },
                  ),
                ),
              ),

              SliverList.separated(
                itemCount: controller.posts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final post = controller.posts[index];

                  return DarkPostCard(
                    post: post,
                    onLike: () => controller.togglePostLike(post.id),
                   onComment: () {
                      Get.bottomSheet(
                        CommentsBottomSheet(post: post),
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        barrierColor: Colors.black.withOpacity(0.45),
                        enterBottomSheetDuration: const Duration(milliseconds: 260),
                        exitBottomSheetDuration: const Duration(milliseconds: 200),
                      );
                    },
                    onShare: () => controller.sharePost(post),
                  );
                },
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }
}


