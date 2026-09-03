import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaleY = (size.height / 874.0).clamp(0.85, 1.15);

    final cardTopOffset = 277.0 * scaleY;
    final titleTopGap = 62.0 * scaleY;
    final subtitleGap = 7.0 * scaleY;
    final emailGap = 64.0 * scaleY;
    final helperGap = 18.0 * scaleY;
    final bottomGap = 48.0 * scaleY;

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
                          // Top Section with Centered Logo
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
                                SizedBox(height: titleTopGap),

                                // Title (4px extra indent inside 24px padding -> left: 28px)
                                const Padding(
                                  padding: EdgeInsets.only(left: 4.0),
                                  child: Text(
                                    'Forgot Password?',
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

                                // Email Input Field
                                _buildInputField(
                                  controller: controller.emailController,
                                  hintText: 'Email',
                                  keyboardType: TextInputType.emailAddress,
                                ),

                                SizedBox(height: helperGap),

                                // Helper Message
                                const Center(
                                  child: Text(
                                    'We’ll send you an OTP to reset your password',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: AppTextStyle.fontFamily,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: AppColor.white,
                                      height: 17 / 13,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          // Send OTP Button
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0),
                            child: _buildSendOtpButton(),
                          ),

                          SizedBox(height: bottomGap),
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
    TextInputType keyboardType = TextInputType.text,
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
          ),
        ),
      ),
    );
  }

  Widget _buildSendOtpButton() {
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
          onTap: controller.sendOtp,
          borderRadius: BorderRadius.circular(54),
          splashColor: const Color(0x1F000000),
          highlightColor: const Color(0x0D000000),
          child: const Center(
            child: Text(
              'Send OTP',
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

}
