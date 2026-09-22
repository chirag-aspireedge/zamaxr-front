import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class IndividualQuizzesController extends GetxController {
  final RxString selectedQuickSubject = 'Biology'.obs;
  final RxString selectedQuizCategory = 'All'.obs;
  final TextEditingController quizTopicController =
      TextEditingController(text: 'Photosynthesis & Cellular Respiration');

  final List<String> quickSubjects = const [
    'Biology',
    'Mathematics',
    'Physics',
    'History',
    'English',
    '+ Custom',
  ];

  final List<String> quizCategories = const [
    'All',
    'Biology',
    'Mathematics',
    'Physics',
    'General Science',
  ];

  @override
  void onClose() {
    quizTopicController.dispose();
    super.onClose();
  }

  void onBackTap() {
    Get.back();
  }

  void onSelectQuickSubject(String subject) {
    selectedQuickSubject.value = subject;
    if (subject == 'Biology') {
      quizTopicController.text = 'Photosynthesis & Cellular Respiration';
    } else if (subject == 'Mathematics') {
      quizTopicController.text = 'Quadratic Equations & Polynomials';
    } else if (subject == 'Physics') {
      quizTopicController.text = 'Newtonian Mechanics & Force Vectors';
    } else if (subject == 'History') {
      quizTopicController.text = 'Ancient African Civilizations & Empires';
    } else if (subject == 'English') {
      quizTopicController.text = 'Literary Analysis & Syntax Mastery';
    } else if (subject == '+ Custom') {
      quizTopicController.clear();
    }
  }

  void onSelectQuizCategory(String category) {
    selectedQuizCategory.value = category;
  }

  void onGenerateQuiz() {
    final topic = quizTopicController.text.trim();
    Get.snackbar(
      'Generating AI Quiz',
      topic.isNotEmpty
          ? 'Synthesizing adaptive quiz for "$topic"...'
          : 'Synthesizing adaptive STEM quiz session...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1465A1),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
    Future.delayed(const Duration(milliseconds: 600), () {
      Get.toNamed(Routes.STUDENT_QUIZ);
    });
  }

  void onStartFeaturedQuiz(String title) {
    Get.snackbar(
      'Starting Quiz',
      'Loading "$title"...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF1465A1),
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
    Future.delayed(const Duration(milliseconds: 400), () {
      Get.toNamed(Routes.STUDENT_QUIZ);
    });
  }

  void onUpgradeAllowance() {
    Get.snackbar(
      'Upgrade for Unlimited',
      'Unlock unlimited AI quiz generations and full exam prep!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF11629E),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onViewFullQuizHistory() {
    Get.snackbar(
      'Full Quiz History',
      'Displaying all 12 completed quiz assessments and score analytics.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0A2540),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
