import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';

class IndividualOnboardingItem {
  final String title;
  final String description;
  final String image;

  const IndividualOnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

class IndividualOnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<IndividualOnboardingItem> items = const [
    IndividualOnboardingItem(
      title: 'Explore. Experience. Learn.',
      description:
          'Step into immersive AR & VR learning experiences that make concepts visual, engaging, and interactive.',
      image: AppAssets.individualOnboard1,
    ),
    IndividualOnboardingItem(
      title: 'AI Tutor & Math Solver',
      description:
          'Get instant step-by-step math solutions and 24/7 AI-guided learning assistance whenever you need help.',
      image: AppAssets.individualOnboard2,
    ),
    IndividualOnboardingItem(
      title: 'Test Skills with Quizzes',
      description:
          'Challenge yourself with customized quizzes across STEM topics and track your mastery at your own pace.',
      image: AppAssets.individualOnboard3,
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
    Get.offNamed(Routes.INDIVIDUAL_REGISTRATION);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
