import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/theme_route.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../contact/ui/save_contact_screen.dart';

class FloatingCallButton extends StatelessWidget {
  const FloatingCallButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: AppColors.buttonBlue,
      onPressed: ()=>Get.to(SaveContactScreen()),
      shape: const CircleBorder(),
      child:Image.asset(AppAssets.addCallIcon,color:  Colors.white,height: 24)
    );
  }
}

