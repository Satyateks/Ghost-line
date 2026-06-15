import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class AuthShell extends StatelessWidget {
  final Widget child;
  final String? logoAsset;
  final String? backgroundAsset;
  final double cardTopFactor;
  final EdgeInsetsGeometry cardPadding;
  final bool showLogo;
  final bool showBackgroundImage;

  const AuthShell({
    super.key,
    required this.child,
    this.logoAsset,
    this.backgroundAsset,
    this.cardTopFactor = 0.58,
    this.cardPadding = const EdgeInsets.symmetric(horizontal: 16),
    this.showLogo = true,
    this.showBackgroundImage = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark ? AppColors.darkBgGradient : AppColors.lightBgGradient,
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.only(bottom: bottomInset + AppSpacing.lg),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Stack(
                    children: [
                      if (showLogo && logoAsset != null)
                        Positioned(
                          top: 22,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Image.asset(
                              logoAsset!,
                              height: 30,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),

                      if (showBackgroundImage && backgroundAsset != null)
                        Positioned(
                          top: size.height * 0.10,
                          left: 16,
                          right: 16,
                          child: Image.asset(
                            backgroundAsset!,
                            height: size.height * 0.36,
                            fit: BoxFit.contain,
                          ),
                        ),

                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * cardTopFactor,
                        ).add(cardPadding),
                        child: child,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}


