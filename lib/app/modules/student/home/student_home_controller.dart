import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../routes/app_pages.dart';

class StudentFeatureItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const StudentFeatureItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
  });
}

class StudentNoteItem {
  final String title;
  final String subtitle;

  const StudentNoteItem({
    required this.title,
    required this.subtitle,
  });
}

class StudentHomeController extends GetxController {
  final String userName = 'Alex';
  final String userGreeting = 'Hello, Alex! 👋';
  final String userPrompt = 'What would you like to explore today?';

  final RxBool hasUnreadNotifications = true.obs;

  // 6 Quick Access Features
  final List<StudentFeatureItem> features = [
    StudentFeatureItem(
      title: 'AI Tutor',
      subtitle: 'Instant Answers',
      icon: PhosphorIcons.robot(PhosphorIconsStyle.bold),
      backgroundColor: const Color(0xFFD8E2FF),
      iconColor: const Color(0xFF0059BB),
    ),
    StudentFeatureItem(
      title: 'Quizzes',
      subtitle: 'Practice & Win',
      icon: PhosphorIcons.question(PhosphorIconsStyle.bold),
      backgroundColor: const Color(0xFFD4E3FF),
      iconColor: const Color(0xFF476083),
    ),
    StudentFeatureItem(
      title: 'AR Learning',
      subtitle: '3D Projection',
      icon: PhosphorIcons.cube(PhosphorIconsStyle.bold),
      backgroundColor: const Color(0xFFD0E7EA),
      iconColor: const Color(0xFF4B6062),
    ),
    StudentFeatureItem(
      title: 'VR Learning',
      subtitle: 'Virtual Labs',
      icon: PhosphorIcons.virtualReality(PhosphorIconsStyle.bold),
      backgroundColor: const Color(0xFFD8E2FF),
      iconColor: const Color(0xFF0059BB),
    ),
    StudentFeatureItem(
      title: 'Math Solver',
      subtitle: 'Step-by-Step',
      icon: PhosphorIcons.calculator(PhosphorIconsStyle.bold),
      backgroundColor: const Color(0xFFE7E8E9),
      iconColor: const Color(0xFF414754),
    ),
    StudentFeatureItem(
      title: 'Rewards',
      subtitle: '120 Points',
      icon: PhosphorIcons.trophy(PhosphorIconsStyle.bold),
      backgroundColor: const Color(0xFFBDD6FF),
      iconColor: const Color(0xFF001C3A),
    ),
  ];

  // Continue Learning Active Course
  final String activeCourseTitle = 'Biology: Human Cell Structure';
  final String activeCourseBadge = 'Interactive 3D';
  final double activeCourseProgress = 0.65;
  final String activeCourseProgressText = '65% Completed';
  final String secondaryActivityText = 'AI Tutor: Practiced Photosynthesis';
  final String secondaryActivityTime = 'Today, 10:20 AM';

  // Curriculum Notes
  final List<StudentNoteItem> notes = const [
    StudentNoteItem(
      title: 'Cell Biology: Organelles & Functions',
      subtitle: 'PDF • 14 pgs • Grade 8',
    ),
    StudentNoteItem(
      title: 'Earth Science: Planetary Systems',
      subtitle: 'PDF • 10 pgs • Grade 8',
    ),
  ];

  void onNotificationTap() {
    Get.toNamed(Routes.NOTIFICATIONS);
  }

  void onProfileTap() {
    Get.toNamed(Routes.PROFILE);
  }

  void onExploreVrPressed() {
    Get.toNamed(Routes.STUDENT_VR_VIDEOS);
  }

  void onFeatureTapped(String featureTitle) {
    if (featureTitle == 'AI Tutor') {
      Get.toNamed(Routes.STUDENT_AI_TUTOR);
      return;
    }
    if (featureTitle == 'AR Learning') {
      Get.toNamed(Routes.STUDENT_AR_LEARNING);
      return;
    }
    if (featureTitle == 'VR Experiences' || featureTitle.contains('VR')) {
      Get.toNamed(Routes.STUDENT_VR_VIDEOS);
      return;
    }
    if (featureTitle == 'Quizzes') {
      Get.toNamed(Routes.STUDENT_QUIZ);
      return;
    }
    if (Get.context != null) {
      Get.snackbar(
        featureTitle,
        'Opening $featureTitle...',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onStartSelfPacedPressed() {
    Get.toNamed(Routes.STUDENT_SELF_PACED);
  }

  void onResumeLearningPressed() {
    if (Get.context != null) {
      Get.snackbar(
        'Resume Learning',
        'Resuming Biology: Human Cell Structure...',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onDownloadNotePressed(String title) {
    if (Get.context != null) {
      Get.snackbar(
        'Download',
        'Downloading $title...',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onSearchTap() {
    Get.toNamed(Routes.STUDENT_SEARCH);
  }
}
