import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';

class ParentOnboardingItem {
  final String title;
  final String description;
  final String image;

  const ParentOnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

class ParentOnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<ParentOnboardingItem> items = const [
    ParentOnboardingItem(
      title: 'Support Your Child’s Learning',
      description:
          'Discover engaging learning experiences and stay connected with your child’s learning journey.',
      image: AppAssets.parentOnboard1,
    ),
    ParentOnboardingItem(
      title: 'Track Progress & Insights',
      description:
          'Monitor your child’s daily learning milestones, strengths, and areas for improvement in real time.',
      image: AppAssets.parentOnboard2,
    ),
    ParentOnboardingItem(
      title: 'Safe & Guided Screen Time',
      description:
          'Empower your child with curated XR simulations, interactive quizzes, and AI-assisted tutoring.',
      image: AppAssets.parentOnboard3,
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
    Get.offNamed(Routes.PARENT_REGISTRATION);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
