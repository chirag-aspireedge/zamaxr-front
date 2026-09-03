import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import 'teacher_introduction_controller.dart';

class TeacherIntroductionView extends GetView<TeacherIntroductionController> {
  const TeacherIntroductionView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),

                        // Title (Everything you need to teach)
                        // Standard: Section 10 Profile/Main Heading at 20px
                        const Text(
                          'Everything you need to teach',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF131313),
                            height: 25 / 20,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Subtitle (Equip yourself with the tools to build the future of learning.)
                        // Standard: Section 10 Subtitle at 13px
                        const Text(
                          'Equip yourself with the tools to build the future of learning.',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF131313),
                            height: 16 / 13,
                          ),
                        ),

                        const SizedBox(height: 28),

                        // List of 4 Feature Cards
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.features.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final feature = controller.features[index];
                            return _buildFeatureCard(feature);
                          },
                        ),

                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),

                // Primary Gradient Continue Button (Pill shaped)
                _buildContinueButton(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- Feature Card Component ---
  Widget _buildFeatureCard(TeacherIntroFeatureItem feature) {
    return Container(
      constraints: const BoxConstraints(minHeight: 92),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE7E7E7),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular 50x50 Pastel Blue Icon Badge
          Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Color(0xFFE0F6FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                feature.icon,
                size: 24,
                color: const Color(0xFF131313),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Title & Description Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Card Title
                // Optical standard: 15.5px - 16px (FontWeight.w600)
                Text(
                  feature.title,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF191C1E),
                    height: 22 / 16,
                  ),
                ),

                const SizedBox(height: 4),

                // Card Description
                // Optical standard: 12.5px - 13px (FontWeight.w400)
                Text(
                  feature.description,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF454652),
                    height: 17 / 13,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Pill-shaped Gradient Action Button ---
  Widget _buildContinueButton() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF56B9E3),
            Color(0xFF0E5E9B),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(27),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(27),
          onTap: controller.onContinue,
          child: const Center(
            child: Text(
              'Continue',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 22 / 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
