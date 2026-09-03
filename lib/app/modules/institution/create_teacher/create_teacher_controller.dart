import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateTeacherController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  final RxString selectedCountryCode = '+1'.obs;
  final RxString selectedImagePath = ''.obs;

  void setCountryCode(String code) {
    selectedCountryCode.value = code;
  }

  void pickPhoto() {
    // Photo picker trigger placeholder (or mock upload)
    selectedImagePath.value = 'picked';
    Get.snackbar(
      'Photo Selected',
      'Teacher photo attached successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void createTeacher() {
    final name = nameController.text.trim().isEmpty
        ? 'Teacher'
        : nameController.text.trim();

    Get.snackbar(
      'Success',
      'Teacher profile for "$name" created successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );

    Future.delayed(const Duration(milliseconds: 600), () {
      Get.back();
    });
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    super.onClose();
  }
}
