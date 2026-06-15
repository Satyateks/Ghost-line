// ignore_for_file: unnecessary_underscores

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/glass_scaffold.dart';

import 'dart:ui';
import '../contoller/media_links_docs_controller.dart.dart';
import '../model/media_links_docs_model.dart';

class MediaLinksDocsScreen extends StatelessWidget {
  MediaLinksDocsScreen({
    super.key,
    required this.userName,
  });

  final String userName;

  final MediaLinksDocsController controller = Get.put( MediaLinksDocsController(), );

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      safeArea: false,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          const _BlurBg(),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),

                _TopBackChip(),

                const SizedBox(height: 14),

                Expanded(
                  child: _GlassContentCard(
                    child: Column(
                      children: [
                        _TopTabs(controller: controller),

                        Expanded(
                          child: Obx(() {
                            switch (controller.selectedTab.value) {
                              case MediaTabType.media: return _MediaGrid( items: controller.mediaItems);
                              case MediaTabType.docs: return _DocsList( items: controller.docItems);
                              case MediaTabType.links: return _LinksList(items: controller.linkItems);
                            }
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _BlurBg extends StatelessWidget {
  const _BlurBg();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? AppColors.darkBgGradient
                : AppColors.lightBgGradient,
          ),
        ),

        Positioned(
          top: 40,
          left: -30,
          child: _BlurCircle(
            color: AppColors.buttonBlue.withOpacity(0.35),
          ),
        ),

        Positioned(
          bottom: 160,
          right: -40,
          child: _BlurCircle(
            color: AppColors.buttonBlue.withOpacity(0.32),
            size: 160,
          ),
        ),

        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            color: isDark
                ? Colors.black.withOpacity(0.50)
                : Colors.white.withOpacity(0.30),
          ),
        ),
      ],
    );
  }
}

class _BlurCircle extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurCircle({
    required this.color,
    this.size = 130,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
      child: Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _TopBackChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: Get.back,
          borderRadius: BorderRadius.circular(999),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.10)
                      : Colors.white.withOpacity(0.72),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.12)
                        : Colors.white.withOpacity(0.95),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 15,
                      color: textColor,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Media',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 13.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class _GlassContentCard extends StatelessWidget {
  final Widget child;

  const _GlassContentCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(22),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withOpacity(0.48)
                : Colors.white.withOpacity(0.76),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(22),
            ),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.10)
                  : Colors.white.withOpacity(0.95),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _TopTabs extends StatelessWidget {
  final MediaLinksDocsController controller;

  const _TopTabs({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _TabData(Icons.image_outlined, MediaTabType.media),
      _TabData(Icons.description_outlined, MediaTabType.docs),
      _TabData(Icons.link_rounded, MediaTabType.links),
    ];

    return SizedBox(
      height: 54,
      child: Obx(
        () => Row(
          children: tabs.map((tab) {
            final selected = controller.selectedTab.value == tab.type;

            return Expanded(
              child: GestureDetector(
                onTap: () => controller.changeTab(tab.type),
                behavior: HitTestBehavior.opaque,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      tab.icon,
                      color: _tabColor(context, selected),
                      size: 23,
                    ),
                    const SizedBox(height: 11),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      height: 2,
                      width: selected ? 78 : 0,
                      decoration: BoxDecoration(
                        color: _tabColor(context, true),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Color _tabColor(BuildContext context, bool selected) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (selected) {
      return isDark ? Colors.white : AppColors.lightTextPrimary;
    }

    return isDark ? Colors.white60 : Colors.black45;
  }
}

class _TabData {
  final IconData icon;
  final MediaTabType type;

  _TabData(this.icon, this.type);
}


class _MediaGrid extends StatelessWidget {
  final List<MediaItemModel> items;

  const _MediaGrid({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
        childAspectRatio: 0.92,
      ),
      itemBuilder: (_, index) {
        final item = items[index];

        return InkWell(
          onTap: () {},
          child: Image.network(
            item.imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                color: Colors.white.withOpacity(0.08),
                child: const Icon(Icons.image_not_supported_outlined),
              );
            },
          ),
        );
      },
    );
  }
}

class _DocsList extends StatelessWidget {
  final List<DocItemModel> items;

  const _DocsList({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(12, 18, 12, 12),
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (_, index) {
        return _DocTile(item: items[index]);
      },
    );
  }
}

class _DocTile extends StatelessWidget {
  final DocItemModel item;

  const _DocTile({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final subColor = isDark ? Colors.white60 : AppColors.lightTextMuted;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          _FileIcon(extension: item.extension),
          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  item.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: subColor,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Text(
            item.date,
            style: TextStyle(
              color: subColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _FileIcon extends StatelessWidget {
  final String extension;

  const _FileIcon({
    required this.extension,
  });

  @override
  Widget build(BuildContext context) {
    final color = switch (extension.toUpperCase()) {
      'PDF' => Colors.red,
      'MP4' => Colors.purple,
      'JPG' => Colors.grey,
      'PNG' => Colors.grey,
      _ => AppColors.buttonBlue,
    };

    return Container(
      height: 34,
      width: 28,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      alignment: Alignment.center,
      child: Text(
        extension.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 8.5,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}


class _LinksList extends StatelessWidget {
  final List<LinkItemModel> items;

  const _LinksList({
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(10, 18, 10, 12),
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 14),
      itemBuilder: (_, index) {
        return _LinkTile(item: items[index]);
      },
    );
  }
}

class _LinkTile extends StatelessWidget {
  final LinkItemModel item;

  const _LinkTile({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final subColor = isDark ? Colors.white60 : AppColors.lightTextMuted;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LinkIcon(url: item.iconUrl),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  item.subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: subColor,
                    fontSize: 11.5,
                    height: 1.22,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  item.url,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.buttonBlue,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkIcon extends StatelessWidget {
  final String url;

  const _LinkIcon({
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: Container(
        height: 38,
        width: 38,
        color: Colors.white,
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) {
            return const Icon(
              Icons.link_rounded,
              color: AppColors.buttonBlue,
            );
          },
        ),
      ),
    );
  }
}




