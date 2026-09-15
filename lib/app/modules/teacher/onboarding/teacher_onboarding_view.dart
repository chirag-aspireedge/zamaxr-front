import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/themes/app_textstyle.dart';
import 'teacher_onboarding_controller.dart';

class TeacherOnboardingView extends GetView<TeacherOnboardingController> {
  const TeacherOnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Color(0xFF10609D),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF10609D),
        body: Stack(
          children: [
            // 1. Fullscreen PageView with Background Image & Gradient Overlay
            PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                final item = controller.items[index];
                return _buildOnboardingPage(context, item);
              },
            ),

            // 2. Fixed Bottom Controls (Indicators, Skip, Next Button)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28.0, 0, 24.0, 28.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Progress Indicators (Active: 20x6 pill, Inactive: 6x6 circle)
                      Obx(() => _buildPageIndicators()),
                      const SizedBox(height: 36),

                      // Bottom Row: Skip & Circular Next Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Skip Button
                          GestureDetector(
                            onTap: controller.skip,
                            behavior: HitTestBehavior.opaque,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.0,
                                vertical: 12.0,
                              ),
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          // Next Circle Button (48x48) with white background & blue arrow
                          GestureDetector(
                            onTap: controller.nextPage,
                            child: Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.18),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  PhosphorIconsBold.arrowRight,
                                  size: 20,
                                  color: Color(0xFF10609D),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Single Slide Page
  Widget _buildOnboardingPage(BuildContext context, TeacherOnboardingItem item) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.asset(
          item.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.topCenter,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFF10609D),
          ),
        ),

        // Deep rich blue gradient from top transparent down to #10609D
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: const [0.0, 0.32, 0.65, 1.0],
              colors: [
                Colors.transparent,
                const Color(0xFF1668A2).withValues(alpha: 0.20),
                const Color(0xFF10609D).withValues(alpha: 0.90),
                const Color(0xFF10609D),
              ],
            ),
          ),
        ),

        // Title and Description text
        Positioned(
          left: 28,
          right: 28,
          bottom: 140, // Positioned right above the indicators and bottom buttons
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.4,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 12),

              // Description
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.95),
                    height: 1.38,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 3-dot page indicator with active pill animation
  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        controller.items.length,
        (index) {
          final isActive = controller.currentPage.value == index;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: isActive ? 20 : 6,
            height: 6,
            decoration: BoxDecoration(
              color: isActive
                  ? Colors.white
                  : Colors.white.withValues(alpha: 0.39),
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
      ),
    );
  }
}
