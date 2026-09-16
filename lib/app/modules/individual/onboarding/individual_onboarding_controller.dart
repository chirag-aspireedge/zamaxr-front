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
          'Step into immersive AR & VR learning experiences that make every lesson more engaging and interactive.',
      image: AppAssets.individualOnboard1,
    ),
    IndividualOnboardingItem(
      title: 'Manage Learning in One Place',
      description:
          'Access your classes, support student learning, track activities and help learners stay on track',
      image: AppAssets.individualOnboard2,
    ),
    IndividualOnboardingItem(
      title: 'Make Learning More Engaging',
      description:
          'Bring learning to life with interactive quizzes, AI-supported learning and immersive AR/VR experiences',
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
    Get.offNamed(Routes.INDIVIDUAL_HOME);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
