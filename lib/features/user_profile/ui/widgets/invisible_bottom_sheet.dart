// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controller/user_profile_controller.dart';


class InvisibleBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required UserProfileController controller,
    String title = 'Invisible?',
    String subtitle = 'hide notification from this person',
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.72),
      builder: (_) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: const SizedBox(),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).padding.top + 14,
              left: 0,
              right: 0,
              child: Center(
                child: InkWell(
                  onTap: Get.back,
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? Colors.black.withOpacity(0.48)
                          : Colors.white.withOpacity(0.72),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.12)
                            : Colors.black.withOpacity(0.08),
                      ),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  12,
                  0,
                  12,
                  12 + MediaQuery.of(context).padding.bottom,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withOpacity(0.54)
                            : Colors.white.withOpacity(0.82),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.12)
                              : Colors.white.withOpacity(0.95),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: isDark ? Colors.white : AppColors.lightTextPrimary,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.4,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            subtitle,
                            style: TextStyle(
                              color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 22),

                          Obx(
                            () => Column(
                              children: [
                                _RadioTile(
                                  title: 'Always',
                                  value: InvisibleOption.always,
                                  groupValue: controller.invisibleOption.value,
                                  onChanged: controller.updateInvisibleOption,
                                ),
                                _SheetDivider(isDark: isDark),
                                _RadioTile(
                                  title: 'Never',
                                  value: InvisibleOption.never,
                                  groupValue: controller.invisibleOption.value,
                                  onChanged: controller.updateInvisibleOption,
                                ),
                                _SheetDivider(isDark: isDark),
                                _RadioTile(
                                  title: 'Specify time',
                                  value: InvisibleOption.specifyTime,
                                  groupValue: controller.invisibleOption.value,
                                  onChanged: controller.updateInvisibleOption,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          Row(
                            children: [
                              Expanded(
                                child: _DateBox(
                                  label: 'From',
                                  date: '26 oct 2023',
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: _DateBox(
                                  label: 'To',
                                  date: '26 oct 2023',
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 28),

                          Row(
                            children: [
                              Expanded(
                                child: _SheetButton(
                                  title: 'Cancel',
                                  isPrimary: false,
                                  onTap: Get.back,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _SheetButton(
                                  title: 'Done',
                                  isPrimary: true,
                                  onTap: Get.back,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RadioTile extends StatelessWidget {
  final String title;
  final InvisibleOption value;
  final InvisibleOption groupValue;
  final ValueChanged<InvisibleOption> onChanged;

  const _RadioTile({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () => onChanged(value),
      child: SizedBox(
        height: 58,
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: selected
                  ? AppColors.buttonBlue
                  : isDark
                      ? Colors.white70
                      : Colors.black54,
              size: 28,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateBox extends StatelessWidget {
  final String label;
  final String date;

  const _DateBox({
    required this.label,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.white : AppColors.lightTextPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 58,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  date,
                  style: TextStyle(
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(
                Icons.calendar_month_outlined,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
                size: 28,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SheetButton extends StatelessWidget {
  final String title;
  final bool isPrimary;
  final VoidCallback onTap;

  const _SheetButton({
    required this.title,
    required this.isPrimary,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      height: 58,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isPrimary ? AppColors.buttonBlue : Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
            side: BorderSide(
              color: isPrimary
                  ? Colors.transparent
                  : isDark
                      ? Colors.white.withOpacity(0.20)
                      : Colors.black.withOpacity(0.14),
            ),
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _SheetDivider extends StatelessWidget {
  final bool isDark;

  const _SheetDivider({
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      color: isDark
          ? Colors.white.withOpacity(0.12)
          : Colors.black.withOpacity(0.10),
    );
  }
}