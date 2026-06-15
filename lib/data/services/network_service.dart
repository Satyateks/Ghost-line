// ignore_for_file: unrelated_type_equality_checks

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkService extends GetxService {
  final Connectivity _connectivity = Connectivity();

  final RxBool isConnected = true.obs;

  Future<NetworkService> init() async {
    await _checkConnection();
    _connectivity.onConnectivityChanged.listen((result) { isConnected.value = result != ConnectivityResult.none; });
    return this;
  }

  Future<void> _checkConnection() async { final result = await _connectivity.checkConnectivity(); isConnected.value = result != ConnectivityResult.none;}
}