import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xFF10609D),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: Stack(
          children: [
            // PageView for slides with background images and text content
            PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.items.length,
              itemBuilder: (context, index) {
                final item = controller.items[index];
                return _buildOnboardingPage(context, item);
              },
            ),

            // Bottom Navigation Overlay (Indicators, Skip, and Next Button)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated Indicator Dots
                      Obx(() => _buildPageIndicators()),

                      const SizedBox(height: 32),

                      // Bottom Row: Skip & Next Button
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
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.white,
                                ),
                              ),
                            ),
                          ),

                          // Next Circle Button (54x54)
                          GestureDetector(
                            onTap: controller.nextPage,
                            child: Container(
                              width: 54,
                              height: 54,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 8,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  AppAssets.iconArrowNext,
                                  width: 22,
                                  height: 22,
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

  Widget _buildOnboardingPage(BuildContext context, OnboardingItem item) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image (full bleed)
        Image.asset(
          item.image,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),

        // Title and Description Overlay (Aligned above indicators)
        Positioned(
          left: 24,
          right: 24,
          bottom: 160,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title (24px Bold)
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColor.white,
                  height: 30 / 24,
                ),
              ),

              const SizedBox(height: 12),

              // Description (14px Regular)
              Container(
                constraints: const BoxConstraints(maxWidth: 295),
                child: Text(
                  item.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.white,
                    height: 18 / 14,
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
          margin: const EdgeInsets.symmetric(horizontal: 2.5),
          width: isSelected ? 20.0 : 6.0,
          height: 6.0,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColor.white
                : AppColor.white.withValues(alpha: 0.39),
            borderRadius: BorderRadius.circular(10.0),
          ),
        );
      }),
    );
  }
}
