// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../model/profile_option_model.dart';


class GroupsCommonCard extends StatelessWidget {
  final List<CommonGroupModel> groups;

  const GroupsCommonCard({
    super.key,
    required this.groups,this.onTap,
  });
final ValueChanged<CommonGroupModel>? onTap;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;

    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.12)
                : Colors.white.withOpacity(0.78),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.12)
                  : Colors.white.withOpacity(0.95),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Groups in common',
                style: TextStyle(
                  color: textColor,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 14),

              ...List.generate(groups.length, (index) {
                final group = groups[index];

                return Column(
                  children: [
                    InkWell(
                      onTap: () => onTap?.call(group),
                      child: SizedBox(
                        height: 68,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                group.imageUrl,
                                height: 56,
                                width: 56,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                group.title,
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: textColor,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (index != groups.length - 1)
                      Divider(
                        height: 1,
                        color: isDark
                            ? Colors.white.withOpacity(0.10)
                            : Colors.black.withOpacity(0.08),
                        indent: 78,
                      ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}