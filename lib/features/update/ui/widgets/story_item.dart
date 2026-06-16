import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/story_model.dart';


class StoryItem extends StatelessWidget {
  final StoryModel story;
  final VoidCallback onTap;

  const StoryItem({
    super.key,
    required this.story,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 72,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 66,
                  width: 66,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: story.isViewed
                        ? null
                        : const LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.orange,
                              Colors.pink,
                            ],
                          ),
                    border: story.isViewed
                        ? Border.all(
                            color: theme.dividerColor,
                            width: 1,
                          )
                        : null,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.scaffoldBackgroundColor,
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
                    bottom: 2,
                    right: 2,
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.scaffoldBackgroundColor,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 6),

            Text(
              story.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

