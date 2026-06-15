import 'package:flutter/material.dart';
import '../../../../core/theme/theme_route.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/widgets_route.dart';
import '../../model/call_item_model.dart';


class CallListTile extends StatelessWidget {
  final CallItemModel call;

  const CallListTile({
    super.key,
    required this.call,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final nameColor = call.isMissed
        ? AppColors.error
        : isDark
            ? Colors.white
            : AppColors.lightTextPrimary;

    final subColor = isDark ? Colors.white60 : AppColors.lightTextMuted;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          AvatarWidget(
            name: call.name,
            imageUrl: call.avatar,
            size: 48,
            showStatus: false,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  call.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: nameColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 3),

                Row(
                  children: [
                    Image.asset(AppAssets.missedCallIcon,color: isDark ? Colors.white : AppColors.lightTextPrimary,),
                    const SizedBox(width: 4),
                    Text(
                      call.time,
                      style: TextStyle(
                        color: subColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Image.asset(
                call.type == CallType.video ? AppAssets.videoIcon : AppAssets.callIcon,
                width: 24, height: 24,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}