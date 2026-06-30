import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../model/profile_models.dart';
import '../../../../core/widgets/custom_bottomSheet.dart';


class CommonSettingsScreen extends StatelessWidget {
  final String title;
  final List<SettingItemModel> items;

  const CommonSettingsScreen({
    super.key,
    required this.title,
    required this.items,
  });

  Widget _buildBottomSheetContent(BuildContext context, SettingItemModel item) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    Widget buildRadioSelection(List<String> options, String currentSelection) {
      return StatefulBuilder(
        builder: (context, setState) {
          String selected = currentSelection;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(item.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.lightTextPrimary)),
              const SizedBox(height: 16),
              ...options.map((option) => RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selected,
                onChanged: (val) {
                  setState(() => selected = val!);
                },
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.buttonBlue,
              )),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: Get.back,
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.buttonBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                  ),
                  child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                ),
              ),
            ],
          );
        },
      );
    }

    switch (item.type) {
      case SettingItemType.lastSeenOnline:
      case SettingItemType.profilePhoto:
      case SettingItemType.about:
      case SettingItemType.status:
      case SettingItemType.posts:
      case SettingItemType.phoneNumber:
      case SettingItemType.groups:
        return buildRadioSelection(['Everyone', 'My Contacts', 'Nobody'], item.subtitle ?? 'Everyone');
      
      case SettingItemType.messageNotifications:
      case SettingItemType.groupNotifications:
      case SettingItemType.callNotifications:
        return StatefulBuilder(
          builder: (context, setState) {
            bool useTone = true;
            bool useVibration = true;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(item.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.lightTextPrimary)),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text("Tone"),
                  value: useTone,
                  onChanged: (val) => setState(() => useTone = val),
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.buttonBlue,
                ),
                SwitchListTile(
                  title: const Text("Vibration"),
                  value: useVibration,
                  onChanged: (val) => setState(() => useVibration = val),
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.buttonBlue,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: Get.back,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: AppColors.buttonBlue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                    ),
                    child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
                  ),
                ),
              ],
            );
          },
        );

      case SettingItemType.chatBackup:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.lightTextPrimary)),
            const SizedBox(height: 16),
            const Text("Last Backup: 2:00 AM\nSize: 200 MB"),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.snackbar('Backup', 'Backup started successfully');
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.buttonBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                ),
                child: const Text('Back Up Now', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        );
        
      case SettingItemType.chatWallpaper:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.lightTextPrimary)),
            const SizedBox(height: 16),
            const Text("Select a new wallpaper for your chats."),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: AspectRatio(aspectRatio: 1, child: Container(color: Colors.blue[100], margin: const EdgeInsets.all(4)))),
                Expanded(child: AspectRatio(aspectRatio: 1, child: Container(color: Colors.green[100], margin: const EdgeInsets.all(4)))),
                Expanded(child: AspectRatio(aspectRatio: 1, child: Container(color: Colors.pink[100], margin: const EdgeInsets.all(4)))),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: Get.back,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.buttonBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                ),
                child: const Text('Close', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        );

      case SettingItemType.chatHistory:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.lightTextPrimary)),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.import_export),
              title: const Text("Export Chat"),
              onTap: Get.back,
            ),
            ListTile(
              leading: const Icon(Icons.archive),
              title: const Text("Archive All Chats"),
              onTap: Get.back,
            ),
            ListTile(
              leading: const Icon(Icons.delete_sweep, color: Colors.red),
              title: const Text("Clear All Chats", style: TextStyle(color: Colors.red)),
              onTap: Get.back,
            ),
            ListTile(
              leading: const Icon(Icons.delete_forever, color: Colors.red),
              title: const Text("Delete All Chats", style: TextStyle(color: Colors.red)),
              onTap: Get.back,
            ),
          ],
        );

      default:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : AppColors.lightTextPrimary)),
            const SizedBox(height: 16),
            const Text("Action not implemented yet."),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: Get.back,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: AppColors.buttonBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                ),
                child: const Text('Close', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700)),
              ),
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
            _Header(title: title),
            const SizedBox(height: 20),
            _Card(
              items: items,
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

class _Header extends StatelessWidget {
  final String title;

  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: Get.back,
      borderRadius: BorderRadius.circular(80),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.78),
          borderRadius: BorderRadius.circular(80),
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

class _Card extends StatelessWidget {
  final List<SettingItemModel> items;
  final ValueChanged<SettingItemModel> onTap;

  const _Card({
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
            onTap: () {
              if (item.onTap != null) {
                item.onTap!();
              } else {
                onTap(item);
              }
            },
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      Icon(
                        item.icon,
                        color: isDark ? Colors.white : AppColors.lightTextPrimary,
                        size: 27,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : AppColors.lightTextPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (item.subtitle != null) ...[
                              const SizedBox(height: 3),
                              Text(
                                item.subtitle!,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white60
                                      : AppColors.lightTextMuted,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: isDark ? Colors.white : AppColors.lightTextPrimary,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                if (index != items.length - 1)
                  Divider(
                    height: 1,
                    color: isDark
                        ? Colors.white.withOpacity(0.10)
                        : Colors.black.withOpacity(0.08),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

