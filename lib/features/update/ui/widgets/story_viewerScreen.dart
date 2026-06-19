import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/story_model.dart';


class StoryViewerScreen extends StatefulWidget {
  const StoryViewerScreen({super.key});

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  final TextEditingController messageController = TextEditingController();

  late StoryModel story;

  @override
  void initState() {
    super.initState();

    story = Get.arguments as StoryModel;

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _progressController.forward();

    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.back();
      }
    });
  }

  void _pauseStory() {
    _progressController.stop();
  }

  void _resumeStory() {
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onLongPressStart: (_) => _pauseStory(),
        onLongPressEnd: (_) => _resumeStory(),
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: story.image,
                child: CachedNetworkImage(
                  imageUrl: story.image,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.broken_image_rounded,
                      color: Colors.white54,
                      size: 42,
                    ),
                  ),
                ),
              ),
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.75),
                      Colors.black.withOpacity(0.08),
                      Colors.transparent,
                      Colors.black.withOpacity(0.20),
                      Colors.black.withOpacity(0.85),
                    ],
                    stops: const [0.0, 0.18, 0.45, 0.72, 1.0],
                  ),
                ),
              ),
            ),

            SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AnimatedBuilder(
                        animation: _progressController,
                        builder: (context, child) {
                          return LinearProgressIndicator(
                            value: _progressController.value,
                            minHeight: 3,
                            backgroundColor: Colors.white.withOpacity(0.28),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          );
                        },
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 14, 6, 0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white24,
                          child: CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                CachedNetworkImageProvider(story.image),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                story.isOwnStory ? "Your story" : story.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                "Today, 10:12 PM",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.72),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_vert_rounded,
                            color: Colors.white,
                          ),
                        ),

                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Positioned(
              left: 0,
              top: 120,
              bottom: 120,
              width: MediaQuery.of(context).size.width * 0.35,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  _progressController
                    ..reset()
                    ..forward();
                },
              ),
            ),

            Positioned(
              right: 0,
              top: 120,
              bottom: 120,
              width: MediaQuery.of(context).size.width * 0.35,
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.back();
                },
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: bottomInset,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.35),
                            borderRadius: BorderRadius.circular(26),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.35),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: messageController,
                            onTap: _pauseStory,
                            cursorColor: Colors.white,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            decoration: InputDecoration(
                              hintText: "Reply to ${story.name}",
                              hintStyle: TextStyle(
                                color: Colors.white.withOpacity(0.65),
                                fontSize: 14,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 12),

                      GestureDetector(
                        onTap: () {
                          // like logic here
                        },
                        child: Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.28),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.white,
                            size: 27,
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      GestureDetector(
                        onTap: () {
                          final text = messageController.text.trim();

                          if (text.isEmpty) {
                            return;
                          }

                          messageController.clear();
                          FocusScope.of(context).unfocus();
                          _resumeStory();

                          // send message logic here
                        },
                        child: Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.28),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



