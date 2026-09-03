import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/utils/app_assets.dart';
import 'splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final horizontalPadding = size.width * 0.1194; // 11.94% from design

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColor.splashGradientBottom,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColor.splashGradientBottom,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColor.splashGradient,
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Obx(
                  () => AnimatedScale(
                    scale: controller.logoScale.value,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutCubic,
                    child: AnimatedOpacity(
                      opacity: controller.logoOpacity.value,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeOutCubic,
                      child: Image.asset(
                        AppAssets.logo,
                        height: 40,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
