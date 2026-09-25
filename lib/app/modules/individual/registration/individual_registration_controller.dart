import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../parent/registration/parent_registration_controller.dart' show CountryInfo;

class IndividualRegistrationController extends GetxController {
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
    Get.offAllNamed(Routes.INDIVIDUAL_HOME);
  }

  void continueWithGoogle() {
    Get.offAllNamed(Routes.INDIVIDUAL_HOME);
  }

  void continueWithApple() {
    Get.offAllNamed(Routes.INDIVIDUAL_HOME);
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
