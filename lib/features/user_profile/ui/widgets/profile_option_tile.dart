
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../model/profile_option_model.dart';

class ProfileOptionTile extends StatelessWidget {
  final ProfileOptionModel option;
  final VoidCallback onTap;
  final bool showDivider;
  final ValueChanged<bool>? onToggle;

  const ProfileOptionTile({
    super.key,
    required this.option,
    required this.onTap,
    this.showDivider = true,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final subColor = isDark ? Colors.white60 : AppColors.lightTextMuted;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: option.subtitle == null ? 62 : 70,
            child: Row(
              children: [
                Icon(
                  option.icon,
                  color: textColor,
                  size: 27,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: -0.2,
                        ),
                      ),
                      if (option.subtitle != null) ...[
                        const SizedBox(height: 3),
                        Text(
                          option.subtitle!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: subColor,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                if (option.actionType == ProfileOptionActionType.toggle)
                  Switch.adaptive(
                    value: option.value.firstRebuild,
                    activeColor: AppColors.buttonBlue,
                    onChanged: onToggle,
                  )
                else Icon(Icons.arrow_forward_ios_rounded, color: textColor, size: 20),
              ],
            ),
          ),

          if (showDivider) Divider(height: 1, color: isDark ? Colors.white.withOpacity(0.10) : Colors.black.withOpacity(0.08), indent: 42),
        ],
      ),
    );
  }
}

