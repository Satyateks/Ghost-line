import 'package:flutter/material.dart';
import '../theme/app_text_styles.dart';

class AppLogo extends StatelessWidget {
  final String? asset;
  final String? title;
  final double size;
  final bool showTitle;

  const AppLogo({
    super.key,
    this.asset,
    this.title,
    this.size = 30,
    this.showTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onSurface;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (asset != null)
          Image.asset(
            asset!,
            height: size,
            width: size,
            fit: BoxFit.contain,
          ),
        if (showTitle && title != null) ...[
          const SizedBox(width: 8),
          Text(
            title!,
            style: AppTextStyles.h3(textColor),
          ),
        ],
      ],
    );
  }
}