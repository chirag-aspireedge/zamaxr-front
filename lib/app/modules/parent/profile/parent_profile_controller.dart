import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../home/parent_home_controller.dart';

class ParentChildItemModel {
  final String id;
  final String name;
  final String grade;
  final String avatar;
  final bool isLinked;

  const ParentChildItemModel({
    required this.id,
    required this.name,
    required this.grade,
    required this.avatar,
    this.isLinked = true,
  });
}

class ParentProfileController extends GetxController {
  // Parent info
  final RxString name = 'Sarah Mitchell'.obs;
  final RxString email = 'sarah.m@email.com'.obs;
  final RxString avatar = 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?w=200'.obs;

  // Subscription info
  final RxString subscriptionPlan = 'Family Plan'.obs;
  final RxString subscriptionStatus = 'Active'.obs;
  final RxString subscriptionDetails = 'Up to 5 children • 1 Pro Account included'.obs;

  // Children list
  final RxList<ParentChildItemModel> children = <ParentChildItemModel>[
    const ParentChildItemModel(
      id: 'daniel',
      name: 'Daniel Mitchell',
      grade: '8th Grade',
      avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
      isLinked: true,
    ),
    const ParentChildItemModel(
      id: 'emma',
      name: 'Emma Mitchell',
      grade: '4th Grade',
      avatar: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=150',
      isLinked: true,
    ),
  ].obs;

  // Settings state
  final RxString selectedLanguage = 'English'.obs;

  @override
  void onInit() {
    super.onInit();
    // Sync greeting name if parent home controller exists
    if (Get.isRegistered<ParentHomeController>()) {
      final homeController = Get.find<ParentHomeController>();
      if (homeController.userName.value.isNotEmpty && homeController.userName.value != 'Sarah') {
        name.value = homeController.userName.value;
      }
    }
  }

  void onBack() {
    Get.back();
  }

  void onEditProfile() {
    final nameController = TextEditingController(text: name.value);
    final emailController = TextEditingController(text: email.value);

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Profile',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127FD2),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  if (nameController.text.trim().isNotEmpty) {
                    name.value = nameController.text.trim();
                  }
                  if (emailController.text.trim().isNotEmpty) {
                    email.value = emailController.text.trim();
                  }
                  Get.back();
                  Get.snackbar(
                    'Profile Updated',
                    'Your profile details have been saved.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF127FD2),
                    colorText: Colors.white,
                  );
                },
                child: const Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onChangeAvatar() {
    Get.snackbar(
      'Change Photo',
      'Select a new profile photo from your library.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF127FD2),
      colorText: Colors.white,
    );
  }

  void onManageChildren() {
    Get.toNamed(Routes.PARENT_CHILDREN_ACCOUNT);
  }

  void onAddChild() {
    Get.toNamed(Routes.PARENT_ADD_CHILD);
  }

  void onChildTap(ParentChildItemModel child) {
    Get.toNamed(
      Routes.PARENT_CHILD_DETAIL,
      arguments: ChildProgressModel(
        id: child.id,
        name: child.name,
        gradeAndSchool: child.grade,
        avatar: child.avatar,
        status: 'Linked',
        curriculumLessons: '15 of 21 lessons',
        progressPercent: 0.72,
        recentActivity: 'Completed lesson',
        recentIcon: Icons.check_circle_rounded,
      ),
    );
  }

  void onManageSubscription() {
    Get.toNamed(Routes.PARENT_SUBSCRIPTION);
  }

  void onPersonalInformation() {
    onEditProfile();
  }

  void onPasswordSecurity() {
    Get.snackbar(
      'Password & Security',
      'Password change and two-factor authentication options.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF127FD2),
      colorText: Colors.white,
    );
  }

  void onLanguageTap() {
    final languages = ['English', 'Spanish', 'French', 'Arabic'];
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Language',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 16),
            for (final lang in languages)
              ListTile(
                title: Text(lang, style: const TextStyle(fontWeight: FontWeight.w500)),
                trailing: Obx(() => selectedLanguage.value == lang
                    ? const Icon(Icons.check_circle_rounded, color: Color(0xFF127FD2))
                    : const SizedBox.shrink()),
                onTap: () {
                  selectedLanguage.value = lang;
                  Get.back();
                },
              ),
          ],
        ),
      ),
    );
  }

  void onNotificationPreferences() {
    Get.snackbar(
      'Notification Preferences',
      'Manage updates, quiz reports, and streak reminders for your children.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF127FD2),
      colorText: Colors.white,
    );
  }

  void onPrivacyPolicy() {
    Get.snackbar(
      'Privacy Policy',
      'Opening Zama-XR Family Privacy Policy...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF127FD2),
      colorText: Colors.white,
    );
  }

  void onTermsConditions() {
    Get.snackbar(
      'Terms & Conditions',
      'Opening Zama-XR Educational Terms...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF127FD2),
      colorText: Colors.white,
    );
  }

  void onHelpSupport() {
    Get.snackbar(
      'Help & Support',
      'Contact our dedicated 24/7 educational support team.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF127FD2),
      colorText: Colors.white,
    );
  }

  void onLogOut() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Log Out',
          style: TextStyle(
            fontFamily: 'Google Sans Flex',
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
        content: const Text(
          'Are you sure you want to log out of your Parent Account?',
          style: TextStyle(
            fontFamily: 'Google Sans Flex',
            fontSize: 14,
            color: Color(0xFF414754),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF414754))),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBA1A1A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Get.back();
              Get.offAllNamed(Routes.SELECT_ROLE);
            },
            child: const Text('Log Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
