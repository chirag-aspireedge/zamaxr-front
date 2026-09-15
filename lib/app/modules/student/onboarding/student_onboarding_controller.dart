import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';

class StudentOnboardingItem {
  final String title;
  final String description;
  final String image;

  const StudentOnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

class StudentOnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<StudentOnboardingItem> items = const [
    StudentOnboardingItem(
      title: 'Bring Learning to Life',
      description:
          'Explore concepts in an interactive AR experience and see learning beyond the screen.',
      image: AppAssets.studentOnboard1,
    ),
    StudentOnboardingItem(
      title: 'Explore 3D Virtual Worlds',
      description:
          'Dive deep into interactive simulations and visualize complex subjects effortlessly.',
      image: AppAssets.studentOnboard2,
    ),
    StudentOnboardingItem(
      title: 'Learn at Your Own Pace',
      description:
          'Track your progress, take interactive quizzes, and unlock your full academic potential.',
      image: AppAssets.studentOnboard3,
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
    Get.offAllNamed(Routes.STUDENT_DASHBOARD);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
