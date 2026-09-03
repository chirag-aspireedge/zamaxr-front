import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';

class OnboardingItem {
  final String title;
  final String description;
  final String image;

  const OnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<OnboardingItem> items = const [
    OnboardingItem(
      title: 'Create Class',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      image: AppAssets.onboarding1,
    ),
    OnboardingItem(
      title: 'Assigning Teachers',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      image: AppAssets.onboarding2,
    ),
    OnboardingItem(
      title: 'Monitoring',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      image: AppAssets.onboarding3,
    ),
  ];

  void onPageChanged(int index) {
    currentPage.value = index;
  }

  void nextPage() {
    if (currentPage.value < items.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      skip();
    }
  }

  void skip() {
    Get.offAllNamed(Routes.DASHBOARD);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
