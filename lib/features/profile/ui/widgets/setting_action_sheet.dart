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

    return CustomPaint(
      painter: _ProfileHeaderOuterGlowPainter(
        isDark: isDark,
      ),
      foregroundPainter: _ProfileHeaderBorderPainter(
        isDark: isDark,
      ),
      child: InkWell(
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

    return CustomPaint(
      painter: _ProfileHeaderOuterGlowPainter(
        isDark: isDark,
      ),
      foregroundPainter: _ProfileHeaderBorderPainter(
        isDark: isDark,
      ),
      child: Container(
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
                        Icon(
                          item.icon,
                          color: item.isDanger
                              ? AppColors.error
                              : isDark
                                  ? Colors.white
                                  : AppColors.lightTextPrimary,
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
                                  color: item.isDanger
                                      ? AppColors.error
                                      : isDark
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
                    Divider( height: 1, color: isDark ? Colors.white.withOpacity(0.10) : Colors.black.withOpacity(0.08),
                    ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
class _ProfileHeaderOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _ProfileHeaderOuterGlowPainter({
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 24.0;

    final rect = Rect.fromLTWH(
      1.5,
      1.5,
      size.width - 3,
      size.height - 3,
    );

    final rrect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(radius),
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        3.6,
      )
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
          Colors.white.withOpacity(0.13),
          Colors.white.withOpacity(0.035),
          Colors.black.withOpacity(0.32),
        ]
            : [
          Colors.white.withOpacity(0.84),
          Colors.white.withOpacity(0.30),
          Colors.black.withOpacity(0.07),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _ProfileHeaderOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _ProfileHeaderBorderPainter extends CustomPainter {
  final bool isDark;

  const _ProfileHeaderBorderPainter({
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 24.0;

    final rect = Rect.fromLTWH(
      1,
      1,
      size.width - 2,
      size.height - 2,
    );

    final rrect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(radius),
    );

    // Main thin glass border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isDark
            ? [
          Colors.white.withOpacity(0.22),
          Colors.white.withOpacity(0.075),
          Colors.black.withOpacity(0.34),
        ]
            : [
          Colors.white.withOpacity(0.92),
          Colors.white.withOpacity(0.45),
          Colors.black.withOpacity(0.075),
        ],
        stops: const [0.0, 0.48, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, borderPaint);

    // Top soft shine
    final topShinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.05
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.85,
      )
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white.withOpacity(0.00),
          Colors.white.withOpacity(isDark ? 0.10 : 0.34),
          Colors.white.withOpacity(isDark ? 0.20 : 0.68),
          Colors.white.withOpacity(isDark ? 0.08 : 0.28),
          Colors.white.withOpacity(0.00),
        ],
        stops: const [0.0, 0.22, 0.50, 0.78, 1.0],
      ).createShader(rect);

    canvas.drawLine(
      const Offset(30, 2.0),
      Offset(size.width - 30, 2.0),
      topShinePaint,
    );

    // Bottom soft glass edge
    final bottomEdgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.95
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.85,
      )
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: isDark
            ? [
          Colors.white.withOpacity(0.00),
          Colors.white.withOpacity(0.030),
          Colors.white.withOpacity(0.065),
          Colors.white.withOpacity(0.030),
          Colors.white.withOpacity(0.00),
        ]
            : [
          Colors.black.withOpacity(0.00),
          Colors.black.withOpacity(0.025),
          Colors.black.withOpacity(0.050),
          Colors.black.withOpacity(0.025),
          Colors.black.withOpacity(0.00),
        ],
        stops: const [0.0, 0.22, 0.50, 0.78, 1.0],
      ).createShader(rect);

    canvas.drawLine(
      Offset(30, size.height - 2.0),
      Offset(size.width - 30, size.height - 2.0),
      bottomEdgePaint,
    );

    // Inner soft depth
    final innerRect = Rect.fromLTWH(
      4,
      4,
      size.width - 8,
      size.height - 8,
    );

    final innerRRect = RRect.fromRectAndRadius(
      innerRect,
      const Radius.circular(radius - 2),
    );

    final innerShadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        1.1,
      )
      ..color = isDark
          ? Colors.black.withOpacity(0.20)
          : Colors.white.withOpacity(0.24);

    canvas.drawRRect(innerRRect, innerShadowPaint);
  }

  @override
  bool shouldRepaint(covariant _ProfileHeaderBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}


