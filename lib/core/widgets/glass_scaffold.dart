// ignore_for_file: use_null_aware_elements

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GlassScaffold extends StatelessWidget {
  final Widget body;
  final Widget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool safeArea;
  final bool resizeToAvoidBottomInset;
  final Gradient? gradient;

  const GlassScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.safeArea = true,
    this.resizeToAvoidBottomInset = true,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      backgroundColor: isDark ? AppColors.darkBg : AppColors.lightBg,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomNavigationBar,
      body: Container(
        decoration: BoxDecoration(
          gradient: gradient ??
              (isDark ? AppColors.darkBgGradient : AppColors.lightBgGradient),
        ),
        child: safeArea
            ? SafeArea(
                child: Column(
                  children: [
                    if (appBar != null) appBar!,
                    Expanded(child: body),
                  ],
                ),
              )
            : Column(
                children: [
                  if (appBar != null) appBar!,
                  Expanded(child: body),
                ],
              ),
      ),
    );
  }
}