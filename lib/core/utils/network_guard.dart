import 'package:get/get.dart';

import '../../data/services/network_controller.dart';
import 'utils_route.dart';


class NetworkGuard {
  NetworkGuard._();

  static Future<bool> canProceed() async {
    final networkCtrl = Get.find<NetworkController>();

    final connected = await networkCtrl.checkConnection();

    if (!connected) {
      SnackbarHelper.error('Please connect to internet and try again.', title: 'No Internet');
      return false;
    }

    return true;
  }
}