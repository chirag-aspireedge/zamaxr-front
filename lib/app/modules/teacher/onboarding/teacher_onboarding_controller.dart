import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';

class TeacherOnboardingItem {
  final String title;
  final String description;
  final String image;

  const TeacherOnboardingItem({
    required this.title,
    required this.description,
    required this.image,
  });
}

class TeacherOnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentPage = 0.obs;

  final List<TeacherOnboardingItem> items = const [
    TeacherOnboardingItem(
      title: 'Teach. Engage. Inspire.',
      description:
          'Create meaningful learning experiences and help your students learn with confidence.',
      image: AppAssets.teacherOnboard1,
    ),
    TeacherOnboardingItem(
      title: 'Manage Learning in One Place',
      description:
          'Access your classes, support student learning, track activities and help learners stay on track',
      image: AppAssets.teacherOnboard2,
    ),
    TeacherOnboardingItem(
      title: 'Make Learning More Engaging',
      description:
          'Bring learning to life with interactive quizzes, AI-supported learning and immersive AR/VR experiences',
      image: AppAssets.teacherOnboard3,
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
    Get.offNamed(Routes.TEACHER_INTRODUCTION);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
