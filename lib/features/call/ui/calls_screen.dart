import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../home/controller/home_controller.dart';
import '../../home/ui/widgets/main_bottom_nav.dart';
import '../controller/calls_controller.dart';
import 'widgets/call_list_tile.dart';
import 'widgets/calls_search_bar.dart';
import 'widgets/floating_call_button.dart';

class CallsScreen extends StatelessWidget {
  CallsScreen({super.key});

  final CallsController callsCtrl = Get.put(CallsController());
  final HomeController homeCtrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeCtrl.selectedBottomTab.value = BottomTabType.calls;

    return GlassScaffold(
      safeArea: true,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: MainBottomNav(controller: homeCtrl),
      floatingActionButton: const FloatingCallButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          _CallsHeader(),

          const SizedBox(height: 14),

          CallsSearchBar(onChanged: callsCtrl.updateSearch),

          const SizedBox(height: 20),

          Expanded(
            child: Obx(
              () => ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 96),
                children: [
                  _SectionTitle('Recents'),
                  const SizedBox(height: 8),

                  ...callsCtrl.recentCalls.map((call) => CallListTile(call: call)),

                  const SizedBox(height: 14),

                  _SectionTitle('Contacts'),
                  const SizedBox(height: 8),

                  ...callsCtrl.contacts.map((call) => CallListTile(call: call)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CallsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          InkWell(
            onTap: Get.back,
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.76),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isDark ? Colors.white.withOpacity(0.10) : Colors.white.withOpacity(0.95),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 15,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Calls',
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
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

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.lightTextPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

