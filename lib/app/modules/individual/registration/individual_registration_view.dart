import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/themes/app_textstyle.dart';
import 'individual_registration_controller.dart';

class IndividualRegistrationView
    extends GetView<IndividualRegistrationController> {
  const IndividualRegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<IndividualRegistrationController>()) {
      Get.put(IndividualRegistrationController());
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Ambient Background Blur Spheres
            Positioned(
              right: -100,
              top: -100,
              child: Container(
                width: 256,
                height: 256,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0059BB).withValues(alpha: 0.05),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                  child: const SizedBox(),
                ),
              ),
            ),
            Positioned(
              left: -120,
              bottom: -120,
              child: Container(
                width: 288,
                height: 288,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFD0E7EA).withValues(alpha: 0.35),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                  child: const SizedBox(),
                ),
              ),
            ),

            // Main Content
            SafeArea(
              child: Column(
                children: [
                  // Top Bar with Back Button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            PhosphorIconsRegular.arrowLeft,
                            color: Color(0xFF191C1D),
                            size: 22,
                          ),
                          splashRadius: 24,
                        ),
                      ],
                    ),
                  ),

                  // Scrollable Form
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(24.0, 4.0, 24.0, 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 1. Header Section
                          const Text(
                            'Create Account',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF191C1D),
                              letterSpacing: -0.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Explore AR, VR, AI Tutor, Math Solver, and interactive Quizzes at your own pace.',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 14.5,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF414754),
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 26),

                          // 2. Full Name
                          _buildLabel('Full Name'),
                          const SizedBox(height: 8),
                          _buildTextInput(
                            controller: controller.fullNameController,
                            hintText: 'Enter your full name',
                            icon: PhosphorIconsRegular.user,
                          ),
                          const SizedBox(height: 18),

                          // 3. Email Address
                          _buildLabel('Email Address'),
                          const SizedBox(height: 8),
                          _buildTextInput(
                            controller: controller.emailController,
                            hintText: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            icon: PhosphorIconsRegular.envelopeSimple,
                          ),
                          const SizedBox(height: 18),

                          // 4. Select Your Country
                          _buildLabel('Select Your Country'),
                          const SizedBox(height: 8),
                          _buildCountrySelector(context),
                          const SizedBox(height: 18),

                          // 5. Phone Number
                          _buildLabel('Phone Number'),
                          const SizedBox(height: 8),
                          _buildPhoneInput(),
                          const SizedBox(height: 18),

                          // 6. Password
                          _buildLabel('Password'),
                          const SizedBox(height: 8),
                          Obx(
                            () => _buildPasswordInput(
                              controller: controller.passwordController,
                              hintText: 'Create password',
                              isVisible: controller.isPasswordVisible.value,
                              onToggleVisibility:
                                  controller.togglePasswordVisibility,
                            ),
                          ),
                          const SizedBox(height: 18),

                          // 7. Confirm Password
                          _buildLabel('Confirm Password'),
                          const SizedBox(height: 8),
                          Obx(
                            () => _buildPasswordInput(
                              controller: controller.confirmPasswordController,
                              hintText: 'Confirm password',
                              isVisible:
                                  controller.isConfirmPasswordVisible.value,
                              onToggleVisibility:
                                  controller.toggleConfirmPasswordVisibility,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // 8. Terms and Conditions
                          _buildTermsAndConditions(),
                          const SizedBox(height: 28),

                          // 9. Create Account Button
                          _buildSubmitButton(),
                          const SizedBox(height: 20),

                          // 10. Or Divider
                          _buildOrDivider(),
                          const SizedBox(height: 18),

                          // 11. Social Buttons: Continue with Google & Apple
                          _buildSocialButton(
                            label: 'Continue with Google',
                            icon: _buildGoogleIcon(),
                            onTap: controller.continueWithGoogle,
                          ),
                          const SizedBox(height: 12),
                          _buildSocialButton(
                            label: 'Continue with Apple',
                            icon: const Icon(
                              Icons.apple,
                              size: 22,
                              color: Color(0xFF191C1D),
                            ),
                            onTap: controller.continueWithApple,
                          ),
                          const SizedBox(height: 24),

                          // 12. Already have an account? Log In
                          Center(
                            child: GestureDetector(
                              onTap: controller.navigateToLogin,
                              child: RichText(
                                text: const TextSpan(
                                  text: 'Already have an account? ',
                                  style: TextStyle(
                                    fontFamily: AppTextStyle.fontFamily,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF414754),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Log In',
                                      style: TextStyle(
                                        fontFamily: AppTextStyle.fontFamily,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF0E5E9B),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: AppTextStyle.fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Color(0xFF414754),
        letterSpacing: 0.14,
      ),
    );
  }

  Widget _buildTextInput({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E8EF), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 12.0),
            child: Icon(
              icon,
              size: 18,
              color: const Color(0xFFC1C6D7),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF191C1D),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFC1C6D7),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCountrySelector(BuildContext context) {
    return GestureDetector(
      onTap: () => _showCountryPicker(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE5E8EF), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              PhosphorIconsRegular.globe,
              size: 18,
              color: Color(0xFF414754),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Obx(
                () => Text(
                  controller.selectedCountry.value.name,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF414754),
                  ),
                ),
              ),
            ),
            const Icon(
              PhosphorIconsBold.caretDown,
              size: 14,
              color: Color(0xFF191C1D),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneInput() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E8EF), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 48,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F5),
              borderRadius: BorderRadius.horizontal(left: Radius.circular(11)),
              border: Border(
                right: BorderSide(
                  color: Color.fromRGBO(193, 198, 215, 0.4),
                  width: 1,
                ),
              ),
            ),
            child: Obx(
              () => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    controller.selectedCountry.value.flag,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    controller.selectedCountry.value.code,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF414754),
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    PhosphorIconsBold.caretDown,
                    size: 10,
                    color: Color(0xFFC1C6D7),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF191C1D),
              ),
              decoration: const InputDecoration(
                hintText: 'Enter phone number',
                hintStyle: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFC1C6D7),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordInput({
    required TextEditingController controller,
    required String hintText,
    required bool isVisible,
    required VoidCallback onToggleVisibility,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E8EF), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, right: 12.0),
            child: Icon(
              PhosphorIconsRegular.lock,
              size: 18,
              color: Color(0xFFC1C6D7),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: !isVisible,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF191C1D),
              ),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFC1C6D7),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
              ),
            ),
          ),
          IconButton(
            onPressed: onToggleVisibility,
            icon: Icon(
              isVisible
                  ? PhosphorIconsRegular.eye
                  : PhosphorIconsRegular.eyeSlash,
              size: 18,
              color: const Color(0xFFC1C6D7),
            ),
            splashRadius: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => controller
                .toggleTermsAccepted(!controller.isTermsAccepted.value),
            child: Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(top: 2.0),
              decoration: BoxDecoration(
                color: controller.isTermsAccepted.value
                    ? const Color(0xFF0E5E9B)
                    : Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: controller.isTermsAccepted.value
                      ? const Color(0xFF0E5E9B)
                      : const Color(0xFFC1C6D7),
                  width: 1.5,
                ),
              ),
              child: controller.isTermsAccepted.value
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () => controller
                  .toggleTermsAccepted(!controller.isTermsAccepted.value),
              child: RichText(
                text: const TextSpan(
                  text: 'I agree to the ',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF414754),
                    height: 1.4,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0E5E9B),
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0E5E9B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return GestureDetector(
      onTap: controller.createAccount,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(74),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF56B9E3),
              Color(0xFF0E5E9B),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF0E5E9B).withValues(alpha: 0.28),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Create Account',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrDivider() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Color(0xFFE5E8EF),
            thickness: 1,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.0),
          child: Text(
            'Or continue with',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF727782),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Color(0xFFE5E8EF),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String label,
    required Widget icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE5E8EF),
          width: 1.2,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: Colors.black12,
          highlightColor: Colors.black.withValues(alpha: 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              const SizedBox(width: 12),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF191C1D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE5E8EF), width: 1),
      ),
      child: const Center(
        child: Text(
          'G',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontWeight: FontWeight.w800,
            fontSize: 13,
            color: Color(0xFF0E5E9B),
          ),
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Select Country',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 12),
              const Divider(height: 1),
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.countries.length,
                  itemBuilder: (context, index) {
                    final country = controller.countries[index];
                    return ListTile(
                      leading: Text(country.flag,
                          style: const TextStyle(fontSize: 22)),
                      title: Text(
                        country.name,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                      trailing: Text(
                        country.code,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF727782),
                        ),
                      ),
                      onTap: () {
                        controller.selectCountry(country);
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
