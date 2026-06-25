import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/theme_route.dart';
import '../../../../core/utils/utils_route.dart';
import '../../../chat_room/ui/forward_message_screen.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Image.asset(AppAssets.ghostLogo1, height: 40, width: 40, fit: BoxFit.contain),

          const Spacer(),

          InkWell(
            onTap: () => Get.to(
                  () => ForwardMessageScreen(message: 'Satya..'),
            ),
            borderRadius: BorderRadius.circular(999),
            splashColor: Colors.white.withOpacity(0.06),
            highlightColor: Colors.white.withOpacity(0.03),
            child: SizedBox(
              height: 34,
              width: 34,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Outer soft glow
                  Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? Colors.white.withOpacity(0.10)
                              : AppColors.buttonBlue.withOpacity(0.22),
                          blurRadius: 10,
                          spreadRadius: 0.5,
                          offset: const Offset(0, 1),
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.35 : 0.12),
                          blurRadius: 8,
                          spreadRadius: -2,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                  ),

                  // Main glass circle
                  ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 14,
                        sigmaY: 14,
                      ),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: isDark
                                ? [
                              Colors.white.withOpacity(0.16),
                              Colors.white.withOpacity(0.085),
                              Colors.white.withOpacity(0.055),
                            ]
                                : [
                              AppColors.buttonBlue.withOpacity(0.95),
                              AppColors.buttonBlue.withOpacity(0.86),
                              AppColors.buttonBlue.withOpacity(0.78),
                            ],
                          ),
                          border: Border.all(
                            width: 0.9,
                            color: isDark
                                ? Colors.white.withOpacity(0.18)
                                : Colors.white.withOpacity(0.35),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Top shine
                  Positioned(
                    top: 3.8,
                    child: Container(
                      height: 1.2,
                      width: 13,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.white.withOpacity(0.00),
                            Colors.white.withOpacity(0.45),
                            Colors.white.withOpacity(0.00),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Bottom soft depth
                  Positioned(
                    bottom: 3.2,
                    child: Container(
                      height: 1.1,
                      width: 12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(isDark ? 0.22 : 0.10),
                      ),
                    ),
                  ),

                  Icon(
                    Icons.add_rounded,
                    size: 21,
                    color: Colors.white.withOpacity(0.96),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
