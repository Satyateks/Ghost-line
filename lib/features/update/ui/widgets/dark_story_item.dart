import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/story_model.dart';



class DarkStoryItem extends StatelessWidget {
  final StoryModel story;
  final VoidCallback onTap;

  const DarkStoryItem({
    super.key,
    required this.story,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 85,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  padding: const EdgeInsets.all(2.4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: story.isOwnStory
                        ? null
                        : const LinearGradient(
                            colors: [
                              Color(0xFFFFC107),
                              Color(0xFFE91E63),
                              Color(0xFF9C27B0),
                            ],
                          ),
                    border: story.isOwnStory
                        ? Border.all( color: Colors.white24, width: 1, )
                        : null,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Color(0xFF050505),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: story.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                if (story.isOwnStory)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 19,
                      width: 19,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A84FF),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF050505),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              story.isOwnStory ? "Your story" : story.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


