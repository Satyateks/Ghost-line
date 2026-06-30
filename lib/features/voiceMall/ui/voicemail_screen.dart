
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/glass_scaffold.dart';
import '../../home/controller/home_controller.dart';
import '../../home/ui/widgets/main_bottom_nav.dart';
import '../controller/voicemail_controller.dart';
import 'voicemail_detail_screen.dart';
import 'voicemail_greetings_screen.dart';
import 'widgets/voicemail_tile.dart';

class VoicemailScreen extends StatelessWidget {
  VoicemailScreen({super.key});

  final VoicemailController controller = Get.put(VoicemailController());
  final HomeController homeCtrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    // return Scaffold( backgroundColor: theme.scaffoldBackgroundColor,
     return GlassScaffold(
      safeArea: true, resizeToAvoidBottomInset: true,
      bottomNavigationBar: MainBottomNav(controller: homeCtrl),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: controller.searchController,
                      cursorColor: theme.colorScheme.primary,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 13,
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 20,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                        hintText: "Search name, numbers",
                        hintStyle: TextStyle(
                          color: theme.colorScheme.onSurface.withOpacity(0.55),
                          fontSize: 13,
                        ),
                        contentPadding: EdgeInsets.zero,
                        filled: true,
                        fillColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(
                            color: isDark ? Colors.white12 : Colors.black12,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 11),
                GestureDetector(
                  onTap: ()=>Get.to(VoicemailGreetingsScreen()),
                  child: Container(
                    height: 40,
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: isDark ? Colors.white12 : Colors.black12,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Greetings",
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
            
          Expanded(
            child: Obx(
              () => ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(8, 18, 8, 96),
                children: [
                  if (controller.recentVoicemails.isNotEmpty) ...[
                    _SectionTitle(title: "Recents"),
                    const SizedBox(height: 6),
                    ...controller.recentVoicemails.map((item) => VoicemailTile(voicemail: item, onTap: () =>Get.to(VoicemailDetailScreen(), arguments: item)))],
            
                  if (controller.olderVoicemails.isNotEmpty) ...[
                    const SizedBox(height: 18),
                    _SectionTitle(title: "Older"),
                    const SizedBox(height: 6),
                    ...controller.olderVoicemails.map((item) => VoicemailTile(voicemail: item, onTap: () =>Get.to(VoicemailDetailScreen(), arguments: item)))],
            
                  if (controller.filteredVoicemails.isEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 120),
                      child: Center(
                        child: Text(
                          "No voicemail found",
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

