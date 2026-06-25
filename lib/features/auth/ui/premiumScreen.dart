import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghostline/core/theme/theme_route.dart';
import 'package:ghostline/features/home/ui/home_screen.dart';

import '../../../core/utils/app_assets.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:isDark ? Colors.black : AppColors.lightBg,
      body: Stack(
        children: [
          Positioned( top: 0, left: -60, right: -60,
            child:isDark? Image.asset(AppAssets.premiumBg): Image.asset(AppAssets.premiumBgl),
          ),

          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 52),
               SizedBox(height: 111, width: 100, child:isDark?Image.asset(AppAssets.ghostLogo, fit: BoxFit.contain): Image.asset(AppAssets.ghostLogo1, fit: BoxFit.contain)),

                const Spacer(),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  child: _PremiumCard(isDark: isDark),
                ),

                const SizedBox(height: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _PremiumCard extends StatefulWidget {
  final bool isDark;

  const _PremiumCard({required this.isDark});

  @override
  State<_PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<_PremiumCard> {
  int selectedIndex = 0;

  final plans = ["1 Month", "3 Months", "6 Months", "1 year"];

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    final cardColor = isDark ? const Color(0xff242424) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xff161616);
    final subTextColor = isDark ? Colors.white70 : Colors.black54;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 11),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.45 : 0.12),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Gradient
          Container(
            height: 48,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              image: const DecorationImage(image: AssetImage(AppAssets.premiumheader), fit: BoxFit.cover),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              // gradient: LinearGradient(
              //   colors: [
              //     isDark ? const Color(0xff2C2C2C) : const Color(0xffEEF2FF),
              //     const Color(0xff3B82F6).withOpacity(0.65),
              //     const Color(0xffEF4444).withOpacity(0.75),
              //   ],
              // ),
            ),
            child: Text(
              "GhostLine Premium",
              style: TextStyle(
                color: textColor,
                fontSize: 20,height: 1,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// Plans
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Row(
              children: List.generate(plans.length, (index) {
                final isSelected = selectedIndex == index;
            
                return Expanded(
                  child: GestureDetector(
                    onTap: ()=> setState(() => selectedIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      margin: EdgeInsets.only(right: index == plans.length - 1 ? 0 : 7),
                      height: 28,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xff3B82F6).withOpacity(0.65)
                            : isDark
                                ? Colors.black
                                : const Color(0xffEEF2F7),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xff60A5FA)
                              : Colors.transparent,
                        ),
                      ),
                      child: Text(
                        plans[index],
                        style: AppTextStyles.bodyMedium(isSelected ? Colors.white : isDark ? Colors.white : Colors.black87),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 18),

          /// Price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "₹500",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text("/month", style:AppTextStyles.bodyLarge(subTextColor)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          _PremiumFeature(text: "100% Local Data Storage", isDark: isDark),
          _PremiumFeature(text: "End-to-End Data Protection", isDark: isDark),
          _PremiumFeature(text: "Advanced App Lock Options", isDark: isDark),
          _PremiumFeature(text: "Encrypted Local Backups", isDark: isDark),
          _PremiumFeature(text: "Ad-Free Experience", isDark: isDark),
          _PremiumFeature(text: "Export & Restore Data Anytime", isDark: isDark),

          const SizedBox(height: 16),

          /// Bottom Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 11),
            child: Row(
              children: [
                TextButton(
                  onPressed: ()=>Get.back(),
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: Color(0xff3B82F6),
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            
                const SizedBox(width: 8),
            
                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: ElevatedButton(
                      onPressed: ()=>Get.offAll(() => HomeScreen()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:AppColors.buttonBlue,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                        ),
                      ),
                      child: const Text(
                        "Continue",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class _PremiumFeature extends StatelessWidget {
  final String text;
  final bool isDark;

  const _PremiumFeature({
    required this.text,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final nameColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 11,left: 16),
      child: Row(
        children: [
          Image.asset(AppAssets.premiumImg),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style:AppTextStyles.bodyLarge(nameColor)),
          ),
        ],
      ),
    );
  }
}

