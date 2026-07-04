
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghostline/core/theme/theme_route.dart';
import '../../../../core/widgets/glass_scaffold.dart';
import '../../../auth/ui/authGlassCard.dart';
import '../common_settings_screen.dart';


class LanguageController extends GetxController {
  final selectedIndex = 0.obs;

  final languages = <String>[
    'English',
    'हिंदी',
    'বাংলা',
    'অসমীয়া',
    'ગુજરાતી',
    'मराठी',
    'ਪੰਜਾਬੀ',
    'संस्कृत',
    'कोंकणी',
    'डोगरी',
    'मैथिली',
    'नेपाली',
  ];

  void selectLanguage(int index) {selectedIndex.value = index;}
}

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});

  final LanguageController controller = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GlassScaffold(safeArea: true,
    bottomNavigationBar: _buildBottomButton(context),
      body: Padding(
       padding: const EdgeInsets.fromLTRB(8, 11, 8, 8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Header(title: 'Languages '),
            const SizedBox(height: 27),
              
            Text(
              "Select language",
              style: theme.textTheme.titleSmall?.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
                
            Expanded(
              child: GridView.builder(//shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.languages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2.75,
                  mainAxisSpacing: 8, crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  final language = controller.languages[index];
                
                  return Obx(
                    () => LanguageTile(
                      title: language,
                      isSelected: controller.selectedIndex.value == index,
                      onTap: ()=> controller.selectLanguage(index),
                    ),
                  );
                },
              ),
            ),
        
            
          ],
        ),
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
                fontSize: 17,
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
    final unselectedColor = isDark ? const Color(0xff080808) : const Color(0xffF5F6FA);
    final borderColor = isDark ? const Color(0xff1F1F1F) : const Color(0xffE2E4EA);
    final unselectedTextColor = isDark ? const Color(0xffBEBEBE) : const Color(0xff444A57);

    return CustomPaint(
      painter: ProfileHeaderOuterGlowPainter(isDark: isDark),
      foregroundPainter: ProfileHeaderBorderPainter(isDark: isDark),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? theme.colorScheme.primary : unselectedColor,
            borderRadius: BorderRadius.circular(24),
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
            title, textAlign: TextAlign.center,
            style: AppTextStyles.bodyLarge(isSelected ? theme.colorScheme.onPrimary : unselectedTextColor),
          ),
        ),
      ),
    );
  }
}


 
