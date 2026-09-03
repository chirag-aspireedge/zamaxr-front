import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final RxBool isLoading = false.obs;

  void sendOtp() {
    // Trigger OTP sending flow
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
