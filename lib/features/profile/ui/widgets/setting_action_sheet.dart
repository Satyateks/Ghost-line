import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghostline/core/theme/theme_route.dart';

import '../../../../core/widgets/custom_bottomSheet.dart';
import '../../../../core/widgets/glass_scaffold.dart';
import '../../contoller/profile_controller.dart';
import '../../model/profile_models.dart';



class AccountSettingsScreen extends StatelessWidget {
  AccountSettingsScreen({super.key});

  final ProfileController controller = Get.find<ProfileController>();

  Widget _buildBottomSheetContent(BuildContext context, SettingItemModel item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (item.type) {
      case SettingItemType.changeUserName:
        return Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.title, style:AppTextStyles.h3(isDark ? Colors.white : AppColors.lightTextPrimary)),
            const SizedBox(height: 16),
            const TextField(decoration: InputDecoration(hintText: 'First Name')),
            const SizedBox(height: 10),
            const TextField(decoration: InputDecoration(hintText: 'Last Name')),
            const SizedBox(height: 16),
            SizedBox(width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: Get.back,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.buttonBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        );
      case SettingItemType.changeNumber:
        bool isOtpSent = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.title, style:AppTextStyles.h3(isDark ? Colors.white : AppColors.lightTextPrimary)),
                const SizedBox(height: 16),
                if (!isOtpSent) ...[
                  const TextField(
                    decoration: InputDecoration(hintText: 'New Phone Number'),
                    keyboardType: TextInputType.phone, maxLength: 10,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:()=> setState(()=> isOtpSent = true),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.buttonBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: const Text(
                        'Send OTP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  const TextField(
                    decoration: InputDecoration(hintText: 'Enter 6-digit OTP'),
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed:Get.back,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: AppColors.buttonBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        );
      case SettingItemType.deleteAccount:
      case SettingItemType.removeAccount:
        return Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.title,style:AppTextStyles.h3(isDark ? Colors.white : AppColors.lightTextPrimary)),
            const SizedBox(height: 16),
            Text(
              item.subtitle ?? "Are you sure?",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context),
              child: Text(
                item.type == SettingItemType.deleteAccount ? "Delete" : "Remove",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      default: return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text("Action not implemented yet."),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      safeArea: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SettingsHeader(title: 'Account'),
            const SizedBox(height: 20),
            _SettingsCard(
              items: controller.accountItems(),
              onTap: (item) {
                CustomContentBottomSheet.show(
                  context: context,
                  child: _buildBottomSheetContent(context, item),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsHeader extends StatelessWidget {
  final String title;

  const _SettingsHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: Get.back,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.78),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 15,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<SettingItemModel> items;
  final ValueChanged<SettingItemModel> onTap;

  const _SettingsCard({
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.12)
            : Colors.white.withOpacity(0.86),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.12)
              : Colors.white.withOpacity(0.95),
        ),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];

          return InkWell(
            onTap: () => onTap(item),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      Icon( item.icon, color: item.isDanger ? AppColors.error : isDark ? Colors.white : AppColors.lightTextPrimary, size: 27),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title, style:AppTextStyles.bodyHighLarge(item.isDanger ? AppColors.error : isDark ? Colors.white : AppColors.lightTextPrimary)),
                            if (item.subtitle != null) ...[
                              const SizedBox(height: 3),
                              Text(
                                item.subtitle!,
                                style:AppTextStyles.bodySmall(item.isDanger ? AppColors.error : isDark ? Colors.white60 : AppColors.lightTextMuted)
                              ),
                            ],
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: isDark ? Colors.white : AppColors.lightTextPrimary,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                if (index != items.length - 1) Divider(height: 1, color: isDark ? Colors.white.withOpacity(0.10) : Colors.black.withOpacity(0.08)),
              ],
            ),
          );
        }),
      ),
    );
  }
}


