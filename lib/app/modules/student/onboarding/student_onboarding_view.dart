import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../core/themes/app_textstyle.dart';
import 'student_onboarding_controller.dart';

class StudentOnboardingView extends GetView<StudentOnboardingController> {
  const StudentOnboardingView({super.key});

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
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // PageView for 3 onboarding slides
            PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                final item = controller.items[index];
                return _buildOnboardingPage(context, item);
              },
            ),

            // Fixed Bottom Overlay: Page Indicators, Skip button, and Next circular button
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25.0, 0, 24.0, 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Progress Indicator Dots (3 Dots, 8x8 with 8px gap)
                      Obx(() => _buildPageIndicators()),
                      const SizedBox(height: 24),

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
                                horizontal: 4.0,
                                vertical: 12.0,
                              ),
                              child: Text(
                                'Skip',
                                style: TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF127FD2),
                                ),
                              ),
                            ),
                          ),

                          // Next Circle Button (54x54) with Figma linear-gradient (#51B3DE to #10619D)
                          GestureDetector(
                            onTap: controller.nextPage,
                            child: Container(
                              width: 54,
                              height: 54,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF51B3DE),
                                    Color(0xFF10619D),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x3310619D),
                                    blurRadius: 10,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: CustomPaint(
                                  size: const Size(54, 54),
                                  painter: _FigmaArrowPainter(),
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

  Widget _buildOnboardingPage(BuildContext context, StudentOnboardingItem item) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Full Page Background (402x874 Figma export)
        Positioned.fill(
          child: Image.asset(
            item.image,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFFE8F2FD),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.school_rounded,
                  size: 56,
                  color: Color(0xFF0059BB),
                ),
              );
            },
          ),
        ),

        // Exact Figma Gradient Scrim for seamless bottom fade
        // linear-gradient(0deg, #FFFFFF 13.9%, rgba(248, 249, 250, 0.6) 58.62%, rgba(248, 249, 250, 0) 68.71%)
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: MediaQuery.sizeOf(context).height * 0.75,
          child: IgnorePointer(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.0, 0.14, 0.58, 0.69, 1.0],
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFFFFFFF),
                    Color(0x99F8F9FA),
                    Color(0x00F8F9FA),
                    Color(0x00F8F9FA),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Text Section: Title and Subtitle Description positioned safely above bottom controls
        // Overlay height inside SafeArea = 20(pad) + 54(btn) + 24(gap) + 8(dot) = 106px.
        // bottomInset + 128 guarantees exact 22px gap above dots across all devices.
        Positioned(
          left: 24,
          right: 24,
          bottom: bottomInset + 128,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191C1D),
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 18),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 260),
                child: Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF414754),
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPageIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(controller.items.length, (index) {
        final isSelected = controller.currentPage.value == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? const Color(0xFF127FD2)
                : const Color(0xFFE1E3E4),
          ),
        );
      }),
    );
  }
}

/// CustomPainter drawing the exact Figma SVG arrow path:
/// `<path d="M341 780H361M352 789L361 780L352 771" stroke="white" stroke-width="2"/>`
/// Bounding box: 54x54 (center 27, 27).
class _FigmaArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    final path = Path();
    // Horizontal shaft: 20px length
    path.moveTo(17, 27);
    path.lineTo(37, 27);
    // Chevron upper wing
    path.moveTo(28, 18);
    path.lineTo(37, 27);
    // Chevron lower wing
    path.lineTo(28, 36);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
