import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() {
    Get.offAllNamed(Routes.DASHBOARD);
  }

  void forgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

  void loginWithGoogle() {
    Get.offAllNamed(Routes.DASHBOARD);
  }

  void loginWithApple() {
    Get.offAllNamed(Routes.DASHBOARD);
  }


  @override
  void onClose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
