import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../individual/home/individual_home_controller.dart';

class StudentProfileController extends GetxController {
  final RxString name = 'Alex Johnson'.obs;
  final RxString email = 'alex.j@email.com'.obs;
  final RxString accountType = 'Individual Account'.obs;
  final RxBool isProgressSynced = true.obs;

  void editAvatar() {
    Get.snackbar(
      'Profile Avatar',
      'Change profile photo coming soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onEditProfile() {
    Get.snackbar(
      'Edit Profile',
      'Profile editing coming soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onPersonalInformationTap() {
    Get.snackbar(
      'Personal Information',
      'Edit name and account details coming soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onLanguageTap() {
    Get.snackbar(
      'Language',
      'Choose preferred app language coming soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onNotificationsTap() {
    Get.snackbar(
      'Notifications',
      'Notification preferences coming soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onSubscriptionTap() {
    Get.toNamed(Routes.STUDENT_SUBSCRIPTION);
  }

  void onRewardsTap() {
    if (Get.isRegistered<IndividualHomeController>()) {
      Get.find<IndividualHomeController>().currentNavIndex.value = 2;
    } else {
      Get.toNamed(Routes.STUDENT_REWARDS);
    }
  }

  void onChangePasswordTap() {
    Get.snackbar(
      'Security',
      'Change Password coming soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onAccountRecoveryTap() {
    Get.snackbar(
      'Security',
      'Account Recovery coming soon',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onLogoutTap() {
    Get.defaultDialog(
      title: 'Log Out',
      titleStyle: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Color(0xFF191C1D),
      ),
      content: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Text(
          'Are you sure you want to log out of your account?',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF414754),
          ),
        ),
      ),
      confirm: TextButton(
        onPressed: () {
          Get.back();
          Get.offAllNamed(Routes.SELECT_ROLE);
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFBA1A1A),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'Log Out',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
      cancel: TextButton(
        onPressed: () => Get.back(),
        child: const Text(
          'Cancel',
          style: TextStyle(color: Color(0xFF414754), fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
