import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/services/network_controller.dart';
import '../theme/app_colors.dart';

class NoInternetBanner extends StatelessWidget {
  const NoInternetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final networkCtrl = Get.find<NetworkController>();

    return Obx(() {
      if (networkCtrl.isConnected.value) {
        return const SizedBox.shrink();
      }

      return Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 8,
          left: 16,
          right: 16,
          bottom: 10,
        ),
        decoration: const BoxDecoration(color: AppColors.warning),
        child: const Row(
          children: [
            Icon(Icons.wifi_off_rounded, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'No internet connection..',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
