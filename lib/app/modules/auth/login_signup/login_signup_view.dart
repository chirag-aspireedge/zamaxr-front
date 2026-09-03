import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'login_signup_controller.dart';

class LoginSignupView extends GetView<LoginSignupController> {
  const LoginSignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image (full screen cover)
            Positioned.fill(
              child: Image.asset(
                AppAssets.loginSignupBg,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),

            // Content & Action Buttons
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    const Spacer(),

                    // Login Button
                    _buildActionButton(
                      title: 'Login',
                      onTap: () => controller.onLoginPressed(),
                    ),

                    const SizedBox(height: 18),

                    // Signup Button
                    _buildActionButton(
                      title: 'Signup',
                      onTap: () => controller.onSignupPressed(),
                    ),

                    const SizedBox(height: 36),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: AppColor.primaryButtonGradient,
        borderRadius: BorderRadius.circular(74),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(74),
          splashColor: Colors.white24,
          highlightColor: Colors.white10,
          child: Center(
            child: Text(
              title,
              style: AppTextStyle.authButton,
            ),
          ),
        ),
      ),
    );
  }
}
