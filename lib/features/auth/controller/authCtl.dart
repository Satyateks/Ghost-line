import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/utils_route.dart';
import '../../../data/repositories/repositories_route.dart';
import '../../../data/services/services_route.dart';

class AuthController extends GetxController {
  final AuthRepository _authRepo = AuthRepository();

  final RxBool isLoading = false.obs;

  Future<void> login({
    required String emailOrMobile,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      final response = await _authRepo.login(
        emailOrMobile: emailOrMobile,
        password: password,
      );

      SnackbarHelper.success(
        response['message']?.toString() ?? 'Login successful',
      );

      // Get.offAll(() => HomeScreen());
    } catch (e) {
      final message = ApiErrorHandler.getMessage(e);
      SnackbarHelper.error(message);
    } finally {
      isLoading.value = false;
    }
  }
}

enum AuthCardType { login, createAccount, otp, username }

class AuthUiController extends GetxController {
  final Rx<AuthCardType> currentCard = AuthCardType.login.obs;

  final loginIdCtrl = TextEditingController();
  final loginPasswordCtrl = TextEditingController();

  final createIdCtrl = TextEditingController();
  final createPasswordCtrl = TextEditingController();

  final usernameCtrl = TextEditingController();

  final otpControllers = List.generate(6, (_) => TextEditingController());

  void showLogin() {
    currentCard.value = AuthCardType.login;
  }

  void showCreateAccount() {
    currentCard.value = AuthCardType.createAccount;
  }

  void showOtp() {
    currentCard.value = AuthCardType.otp;
  }

  void showUsername() {
    currentCard.value = AuthCardType.username;
  }

  @override
  void onClose() {
    loginIdCtrl.dispose();
    loginPasswordCtrl.dispose();
    createIdCtrl.dispose();
    createPasswordCtrl.dispose();
    usernameCtrl.dispose();

    for (final controller in otpControllers) {
      controller.dispose();
    }

    super.onClose();
  }
}


