import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'student_self_paced_controller.dart';

class StudentSelfPacedView extends GetView<StudentSelfPacedController> {
  const StudentSelfPacedView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<StudentSelfPacedController>()) {
      Get.put(StudentSelfPacedController());
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFAFBFC),
        body: Stack(
          children: [
            // Subtle ambient background blur orbs from Figma CSS
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 320,
                height: 320,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0x120059BB),
                      Color(0x000059BB),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 60,
              left: -40,
              child: Container(
                width: 260,
                height: 260,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Color(0x12476083),
                      Color(0x00476083),
                    ],
                  ),
                ),
              ),
            ),

            // Main scrollable content
            SafeArea(
              top: true,
              bottom: true,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  top: 10,
                  bottom: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Top App Bar / Header
                    _buildHeader(),
                    const SizedBox(height: 20),

                    // 2. Central Hero Card with 3D Illustration & Overlapping Content Area
                    _buildHeroCard(),
                    const SizedBox(height: 18),

                    // 3. Bottom Feature Cards (Immersive & Flexible)
                    _buildFeatureCards(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 1. Header with Circular Back Button, Title and Subtitle
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Circular Back Button
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: controller.onBackTap,
            borderRadius: BorderRadius.circular(9999),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Color(0xFFF3F4F5),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.arrow_back_rounded,
                size: 18,
                color: Color(0xFF191C1D),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Title and Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Self-Paced Content',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  color: Color(0xFF191C1D),
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Learn at your own pace',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF414754),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 2. Hero Card: 3D Illustration + Overlapping Rounded White Content Area
  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 31, 63, 0.06),
            blurRadius: 24,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Top 3D Digital Book Illustration
            Container(
              width: double.infinity,
              height: 270,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFFFFF), Color(0xFFF3F4F5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Image.asset(
                AppAssets.selfPacedBookHero,
                width: double.infinity,
                height: 270,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Icon(
                      PhosphorIconsFill.bookOpen,
                      size: 96,
                      color: Color(0x660E5E9B),
                    ),
                  );
                },
              ),
            ),

            // White Content Sheet Overlapping the bottom of the illustration
            Column(
              children: [
                // Spacing to position the white sheet over the bottom 30px of illustration
                const SizedBox(height: 240),

                // Overlapping rounded white content area
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.03),
                        blurRadius: 8,
                        offset: Offset(0, -2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // "INDEPENDENT JOURNEY" Pill Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD3DADB),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(
                              PhosphorIconsFill.sparkle,
                              size: 12,
                              color: Colors.white,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'INDEPENDENT JOURNEY',
                              style: TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.4,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Heading: "Continue Your Learning"
                      const Text(
                        'Continue Your Learning',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF191C1D),
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Subtitle description
                      const Text(
                        'Explore immersive self-paced content and study whenever it works for your schedule.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.5,
                          color: Color(0xFF414754),
                        ),
                      ),
                      const SizedBox(height: 22),

                      // CTA Button: "Explore Now →"
                      Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(74),
                        child: InkWell(
                          onTap: controller.onExploreNow,
                          borderRadius: BorderRadius.circular(74),
                          child: Ink(
                            width: double.infinity,
                            height: 52,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF56B9E3), Color(0xFF0E5E9B)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              borderRadius: BorderRadius.circular(74),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x2E0E5E9B),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Explore Now',
                                  style: TextStyle(
                                    fontFamily: AppTextStyle.fontFamily,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // 3. Bottom Feature Cards (Immersive & Flexible)
  Widget _buildFeatureCards() {
    return Row(
      children: [
        // Card 1: Immersive
        Expanded(
          child: _buildBenefitCard(
            icon: Icons.view_in_ar_rounded,
            iconColor: const Color(0xFF445D80),
            iconBgColor: const Color(0x40BDD6FF),
            title: 'Immersive',
            subtitle: 'XR modules',
            onTap: controller.onImmersiveTap,
          ),
        ),
        const SizedBox(width: 14),

        // Card 2: Flexible
        Expanded(
          child: _buildBenefitCard(
            icon: Icons.schedule_rounded,
            iconColor: const Color(0xFF0070EA),
            iconBgColor: const Color(0x330070EA),
            title: 'Flexible',
            subtitle: '24/7 access',
            onTap: controller.onFlexibleTap,
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0x4DC1C6D7),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 31, 63, 0.03),
                blurRadius: 12,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circle icon badge
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: 17,
                  color: iconColor,
                ),
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 3),

              // Subtitle / Details
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF414754),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
