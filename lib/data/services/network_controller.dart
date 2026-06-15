import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

import '../../core/utils/utils_route.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  final RxBool isConnected = true.obs;
  final RxBool hasCheckedOnce = false.obs;

  StreamSubscription? _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkInitialConnection();
    _listenConnection();
  }

  Future<void> _checkInitialConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
      hasCheckedOnce.value = true;
    } catch (_) {
      isConnected.value = false;
      hasCheckedOnce.value = true;
    }
  }

  void _listenConnection() {
    _subscription = _connectivity.onConnectivityChanged.listen((result) {
      final oldStatus = isConnected.value;

      _updateConnectionStatus(result);

      if (hasCheckedOnce.value && oldStatus != isConnected.value) {
        if (!isConnected.value) {
          SnackbarHelper.error(
            'Please check your internet connection.',
            title: 'No Internet',
          );
        } else {
          SnackbarHelper.success('You are back online.', title: 'Connected');
        }
      }

      hasCheckedOnce.value = true;
    });
  }

  void _updateConnectionStatus(dynamic result) {
    /// connectivity_plus v6 sometimes returns List<ConnectivityResult>
    if (result is List<ConnectivityResult>) {
      isConnected.value = result.isNotEmpty && !result.contains(ConnectivityResult.none);
      return;
    }

    if (result is ConnectivityResult) {
      isConnected.value = result != ConnectivityResult.none;
      return;
    }

    isConnected.value = false;
  }

  bool get offline => !isConnected.value;

  Future<bool> checkConnection() async {
    await _checkInitialConnection();
    return isConnected.value;
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
