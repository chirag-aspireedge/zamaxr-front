import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class TeacherRegistrationController extends GetxController {
  // Text Controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController teacherIdController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  // Avatar state
  final RxnString avatarPath = RxnString();

  // Country Code
  final RxString selectedCountryCode = '+1'.obs;
  final List<String> countryCodes = ['+1', '+91', '+44', '+61', '+971', '+81', '+49'];

  // Institution Selection & Search
  final RxnString selectedInstitution = RxnString();
  final TextEditingController institutionSearchController = TextEditingController();

  final List<String> allInstitutions = [
    'Stanford High School',
    'Apex International Academy',
    'Oakridge Global Institute',
    'Horizon XR College',
    'St. Xavier High School',
    'Cambridge International School',
    'Greenwood High',
    'Columbia Public School',
    'Other',
  ];

  final RxList<String> filteredInstitutions = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredInstitutions.assignAll(allInstitutions);
  }

  void setCountryCode(String code) {
    selectedCountryCode.value = code;
  }

  void setInstitution(String institution) {
    selectedInstitution.value = institution;
  }

  void filterInstitutions(String query) {
    if (query.trim().isEmpty) {
      filteredInstitutions.assignAll(allInstitutions);
    } else {
      filteredInstitutions.assignAll(
        allInstitutions
            .where((inst) => inst.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void pickAvatar() {
    // In production, integrate image_picker
    Get.snackbar(
      'Profile Photo',
      'Photo picker ready for image integration',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
    );
  }

  void onContinue() {
    Get.offAllNamed(Routes.TEACHER_DASHBOARD);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    teacherIdController.dispose();
    contactNumberController.dispose();
    emailController.dispose();
    institutionSearchController.dispose();
    super.onClose();
  }
}
