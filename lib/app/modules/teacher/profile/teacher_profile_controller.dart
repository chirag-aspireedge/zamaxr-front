import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';

class TeacherProfileController extends GetxController {
  final RxString teacherName = 'Sarah Johnson'.obs;
  final RxString email = 'sarah.johnson@example.com'.obs;
  final RxString institution = 'ABC International Institute'.obs;
  final RxString selectedLanguage = 'English'.obs;
  final RxString avatarAsset = AppAssets.teacherProfileAvatar.obs;

  void onEditAvatar() {
    if (Get.context != null) {
      Get.snackbar(
        'Edit Photo',
        'Profile photo update selected',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0E3856),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onLanguageTap() {
    if (Get.context != null) {
      Get.snackbar(
        'Language',
        'Current language: ${selectedLanguage.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0E3856),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onNotificationsTap() {
    if (Get.context != null) {
      Get.snackbar(
        'Notifications',
        'Manage notification preferences',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0E3856),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onChangePasswordTap() {
    if (Get.context != null) {
      Get.snackbar(
        'Change Password',
        'Update your account password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0E3856),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onAccountTap() {
    if (Get.context != null) {
      Get.snackbar(
        'Account',
        'Manage account settings',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0E3856),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onLogoutTap() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF191C1D),
          ),
        ),
        content: const Text(
          'Are you sure you want to log out of your account?',
          style: TextStyle(color: Color(0xFF414754)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF414754)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD00000),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Get.back();
              Get.offAllNamed(Routes.SELECT_ROLE);
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }
}
