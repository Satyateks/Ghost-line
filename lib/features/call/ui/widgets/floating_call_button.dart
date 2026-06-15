import 'package:flutter/material.dart';
import '../../../../core/theme/theme_route.dart';

class FloatingCallButton extends StatelessWidget {
  const FloatingCallButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: AppColors.buttonBlue,
      onPressed: () {},
      shape: const CircleBorder(),
      child: const Icon(
        Icons.add_call,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}