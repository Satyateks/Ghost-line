
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_scaffold.dart';


class LanguageController extends GetxController {
  final selectedIndex = 0.obs;

  final languages = <String>[
    'English',
    'हिंदी',
    'বাংলা',
    'অসমীয়া',
    'ગુજરાતી',
    'অসমীয়া',
    'English',
    'हिंदी',
    'বাংলা',
    'অসমীয়া',
    'ગુજરાતી',
    'অসমীয়া',
  ];

  void selectLanguage(int index) {
    selectedIndex.value = index;
  }
}

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final LanguageController controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassScaffold(safeArea: true,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [const SizedBox(height: 22),
          _Header(title: 'Languages '),
          const SizedBox(height: 22),
      
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select language",
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 12),
      
                  Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: controller.languages.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: 2.75,
                      ),
                      itemBuilder: (context, index) {
                        final language = controller.languages[index];
      
                        return Obx(
                          () => LanguageTile(
                            title: language,
                            isSelected:
                                controller.selectedIndex.value == index,
                            onTap: () {
                              controller.selectLanguage(index);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
      
          _buildBottomButton(context),
        ],
      ),
    );
  }


  Widget _buildBottomButton(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 21),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        // border: Border( top: BorderSide(color: theme.dividerColor, width: 1,), ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              final selectedLanguage = controller.languages[controller.selectedIndex.value];
              Get.back(result: selectedLanguage);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            child: const Text(
              "Done",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LanguageTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const LanguageTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final unselectedColor =
        isDark ? const Color(0xff080808) : const Color(0xffF5F6FA);

    final borderColor =
        isDark ? const Color(0xff1F1F1F) : const Color(0xffE2E4EA);

    final unselectedTextColor =
        isDark ? const Color(0xffBEBEBE) : const Color(0xff444A57);

    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : unselectedColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? theme.colorScheme.primary : borderColor,
              width: 1,
            ),
            boxShadow: [
              if (!isDark)
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected
                  ? theme.colorScheme.onPrimary
                  : unselectedTextColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
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



 
