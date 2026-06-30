import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghostline/core/theme/theme_route.dart';
import '../../data/services/network_controller.dart';


class NoInternetBanner extends StatelessWidget {
  const NoInternetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final networkCtrl = Get.find<NetworkController>();
    final topPadding = MediaQuery.of(context).padding.top;

    return Obx(() {
      final isConnected = networkCtrl.isConnected.value;

      return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          // Slide down from the top transition
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -1),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.fastOutSlowIn,
            )),
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        // AnimatedSwitcher requires unique keys to trigger transitions
        child: isConnected
            ? const SizedBox.shrink(key: ValueKey('connected'))
            : Material(
              type: MaterialType.transparency,
              child: Container(
                  key: const ValueKey('disconnected'),
                  width: double.infinity,
                  
                  padding: EdgeInsets.fromLTRB(16, topPadding - 7, 16, 12),
                  decoration: BoxDecoration(
                    borderRadius:  BorderRadius.all(Radius.circular(AppRadius.authButton)),
                    color: AppColors.error.withOpacity(0.95),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 11,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false, // Handled manually with topPadding
                    bottom: false,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.wifi_off_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'No internet connection',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                        // UX Touch: Show a tiny spinner indicating the app is trying to reconnect
                        SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ),
      );
    });
  }
}