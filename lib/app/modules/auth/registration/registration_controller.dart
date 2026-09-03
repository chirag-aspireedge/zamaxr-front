import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class RegistrationController extends GetxController {
  // Institution Details Controllers
  final institutionNameController = TextEditingController();
  final registrationNumberController = TextEditingController();
  final selectedInstitutionType = RxnString();

  final List<String> institutionTypes = [
    'School',
    'College',
    'University',
    'Coaching Institute',
    'Academy',
    'Training Center',
    'Other',
  ];

  // Logo State
  final RxnString logoPath = RxnString();

  // Contact Details Controllers
  final selectedCountryCode = '+1'.obs;
  final List<String> countryCodes = ['+1', '+91', '+44', '+61', '+971', '+81', '+49'];

  final contactNumberController = TextEditingController();
  final officialEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isRePasswordVisible = false.obs;

  // Address Controllers
  final completeAddressController = TextEditingController();
  final cityController = TextEditingController();
  final selectedState = RxnString();
  final pincodeController = TextEditingController();

  final List<String> statesList = [
    'Alabama', 'Alaska', 'Arizona', 'Arkansas', 'California', 'Colorado',
    'Connecticut', 'Delaware', 'Florida', 'Georgia', 'Hawaii', 'Idaho',
    'Illinois', 'Indiana', 'Iowa', 'Kansas', 'Kentucky', 'Louisiana',
    'Maine', 'Maryland', 'Massachusetts', 'Michigan', 'Minnesota',
    'Mississippi', 'Missouri', 'Montana', 'Nebraska', 'Nevada',
    'New Hampshire', 'New Jersey', 'New Mexico', 'New York',
    'North Carolina', 'North Dakota', 'Ohio', 'Oklahoma', 'Oregon',
    'Pennsylvania', 'Rhode Island', 'South Carolina', 'South Dakota',
    'Tennessee', 'Texas', 'Utah', 'Vermont', 'Virginia', 'Washington',
    'West Virginia', 'Wisconsin', 'Wyoming', 'Other'
  ];

  // Actions
  void setInstitutionType(String? value) {
    selectedInstitutionType.value = value;
  }

  void setCountryCode(String value) {
    selectedCountryCode.value = value;
  }

  void setStateValue(String? value) {
    selectedState.value = value;
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRePasswordVisibility() {
    isRePasswordVisible.value = !isRePasswordVisible.value;
  }

  void pickLogo() {
    // In production, integrate image_picker or file_picker
    Get.snackbar(
      'Upload Logo',
      'Image picker ready for integration',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void createInstitution() {
    Get.toNamed(Routes.ONBOARDING);
  }

  @override
  void onClose() {
    institutionNameController.dispose();
    registrationNumberController.dispose();
    contactNumberController.dispose();
    officialEmailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    completeAddressController.dispose();
    cityController.dispose();
    pincodeController.dispose();
    super.onClose();
  }
}
