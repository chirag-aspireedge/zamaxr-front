import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // Base design dimensions: 402 x 874
    final scaleY = (size.height / 874.0).clamp(0.85, 1.15);

    final cardTopOffset = 277.0 * scaleY;
    final welcomeBackTopGap = 62.0 * scaleY;
    final subtitleGap = 7.0 * scaleY;
    final emailGap = 64.0 * scaleY;
    final passwordGap = 20.0 * scaleY;
    final forgotGap = 10.0 * scaleY;
    final loginGap = 30.0 * scaleY;
    final orGap = 18.0 * scaleY;
    final socialGap = 16.0 * scaleY;
    final bottomGap = 36.0 * scaleY;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF0F5F9C),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Stack(
          children: [
            // Background fallback matching top white and bottom blue
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white,
                      Colors.white,
                      Color(0xFF0F5F9C),
                    ],
                    stops: [0.0, 0.35, 1.0],
                  ),
                ),
              ),
            ),

            // Full Screen Background Image (Top white + Bottom blue gradient wave)
            Positioned.fill(
              child: Image.asset(
                AppAssets.loginScreenBg,
                fit: BoxFit.fill,
                filterQuality: FilterQuality.high,
              ),
            ),

            // Scrollable Content
            Positioned.fill(
              child: SafeArea(
                bottom: false,
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: size.height - MediaQuery.of(context).padding.top,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top Section with Centered Logo (277px top section)
                          SizedBox(
                            height: cardTopOffset - MediaQuery.of(context).padding.top,
                            width: double.infinity,
                            child: Center(
                              child: Image.asset(
                                AppAssets.logoColor,
                                width: 241,
                                height: 38,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          // Blue Card Content Section
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: welcomeBackTopGap),

                                // Title (left: 28px in design -> 4px extra indent inside 24px padding)
                                const Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    'Welcome Back!',
                                    style: TextStyle(
                                      fontFamily: AppTextStyle.fontFamily,
                                      fontSize: 28,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.white,
                                      height: 36 / 28,
                                    ),
                                  ),
                                ),

                                SizedBox(height: subtitleGap),

                                // Subtitle
                                const Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: SizedBox(
                                    width: 265,
                                    child: Text(
                                      'Lorem Ipsum is simply dummy text of the printing and type',
                                      style: TextStyle(
                                        fontFamily: AppTextStyle.fontFamily,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xF2FFFFFF),
                                        height: 17 / 13,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: emailGap),

                                // Email / Phone Number Field
                                _buildInputField(
                                  controller: controller.emailOrPhoneController,
                                  hintText: 'Email/Phone Number',
                                  keyboardType: TextInputType.emailAddress,
                                ),

                                SizedBox(height: passwordGap),

                                // Password Field
                                Obx(
                                  () => _buildInputField(
                                    controller: controller.passwordController,
                                    hintText: 'Password',
                                    obscureText: controller.isPasswordHidden.value,
                                    suffixIcon: IconButton(
                                      splashRadius: 20,
                                      icon: Icon(
                                        controller.isPasswordHidden.value
                                            ? Icons.visibility_off_rounded
                                            : Icons.visibility_rounded,
                                        color: AppColor.white,
                                        size: 22,
                                      ),
                                      onPressed: controller.togglePasswordVisibility,
                                    ),
                                  ),
                                ),

                                SizedBox(height: forgotGap),

                                // Forgot Password Link
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: controller.forgotPassword,
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        fontFamily: AppTextStyle.fontFamily,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.white,
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(height: loginGap),

                                // Login Button
                                _buildLoginButton(),

                                SizedBox(height: orGap),

                                // Or Divider with Exact Figma Gradient (#FFFFFF 0% -> #FFFFFF 100%)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1.0,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0x00FFFFFF), // #FFFFFF 0%
                                              Color(0xFFFFFFFF), // #FFFFFF 100%
                                            ],
                                            stops: [0.0, 1.0],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                                      child: Text(
                                        'Or',
                                        style: TextStyle(
                                          fontFamily: AppTextStyle.fontFamily,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.white,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1.0,
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              Color(0xFFFFFFFF), // #FFFFFF 100%
                                              Color(0x00FFFFFF), // #FFFFFF 0%
                                            ],
                                            stops: [0.0, 1.0],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: socialGap),

                                // Social Buttons Row
                                Row(
                                  children: [
                                    // Google Button
                                    Expanded(
                                      child: _buildSocialButton(
                                        label: 'With Google',
                                        iconWidget: _buildGoogleIcon(),
                                        onTap: controller.loginWithGoogle,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    // Apple Button
                                    Expanded(
                                      child: _buildSocialButton(
                                        label: 'With Apple',
                                        iconWidget: const Icon(
                                          Icons.apple,
                                          color: AppColor.white,
                                          size: 22,
                                        ),
                                        onTap: controller.loginWithApple,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: bottomGap),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: const Color(0x1FFFFFFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0x4DFFFFFF),
          width: 1.2,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: AppColor.white,
          ),
          cursorColor: AppColor.white,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xE6FFFFFF),
            ),
            border: InputBorder.none,
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 24,
              minHeight: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(54),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 14,
            offset: Offset(0, 6),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.login,
          borderRadius: BorderRadius.circular(54),
          splashColor: const Color(0x1F000000),
          highlightColor: const Color(0x0D000000),
          child: const Center(
            child: Text(
              'Login',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                color: Color(0xFF131313),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildSocialButton({
    required String label,
    required Widget iconWidget,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: const Color(0x33D9D9D9),
        borderRadius: BorderRadius.circular(56),
        border: Border.all(
          color: const Color(0x33FFFFFF),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(56),
          splashColor: const Color(0x3DFFFFFF),
          highlightColor: const Color(0x1AFFFFFF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconWidget,
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  color: AppColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
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
      width: 20,
      height: 20,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColor.white,
      ),
      child: const Center(
        child: Text(
          'G',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Color(0xFF0F5F9C),
          ),
        ),
      ),
    );
  }
}
