import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../home/parent_home_controller.dart';

class CountryInfo {
  final String name;
  final String code;
  final String flag;

  const CountryInfo({
    required this.name,
    required this.code,
    required this.flag,
  });
}

class ParentRegistrationController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;
  final isTermsAccepted = false.obs;

  final Rx<CountryInfo> selectedCountry = const CountryInfo(
    name: 'United States',
    code: '+1',
    flag: '🇺🇸',
  ).obs;

  final List<CountryInfo> countries = const [
    CountryInfo(name: 'United States', code: '+1', flag: '🇺🇸'),
    CountryInfo(name: 'United Kingdom', code: '+44', flag: '🇬🇧'),
    CountryInfo(name: 'Canada', code: '+1', flag: '🇨🇦'),
    CountryInfo(name: 'India', code: '+91', flag: '🇮🇳'),
    CountryInfo(name: 'Australia', code: '+61', flag: '🇦🇺'),
    CountryInfo(name: 'Germany', code: '+49', flag: '🇩🇪'),
    CountryInfo(name: 'United Arab Emirates', code: '+971', flag: '🇦🇪'),
    CountryInfo(name: 'Japan', code: '+81', flag: '🇯🇵'),
    CountryInfo(name: 'France', code: '+33', flag: '🇫🇷'),
    CountryInfo(name: 'Singapore', code: '+65', flag: '🇸🇬'),
  ];

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleTermsAccepted(bool? value) {
    isTermsAccepted.value = value ?? !isTermsAccepted.value;
  }

  void selectCountry(CountryInfo country) {
    selectedCountry.value = country;
  }

  void createAccount() {
    // If a full name is entered, update parent's profile name
    if (fullNameController.text.trim().isNotEmpty && Get.isRegistered<ParentHomeController>()) {
      final homeController = Get.find<ParentHomeController>();
      final name = fullNameController.text.trim();
      homeController.parentFullName.value = name;
      final firstName = name.split(' ').first;
      homeController.userName.value = firstName;
    }

    // Navigate directly to Parent Home
    Get.offAllNamed(Routes.PARENT_HOME);
  }

  void navigateToLogin() {
    Get.toNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
