import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../routes/app_pages.dart';
import '../widgets/in_app_browser_sheet.dart';

class RecommendedModuleItem {
  final String category;
  final String categoryColor; // hex color string or identifier
  final String categoryBg;
  final String categoryBorder;
  final String typeTag;
  final String title;
  final String description;
  final String duration;
  final String actionLabel;
  final VoidCallback onTap;

  const RecommendedModuleItem({
    required this.category,
    required this.categoryColor,
    required this.categoryBg,
    required this.categoryBorder,
    required this.typeTag,
    required this.title,
    required this.description,
    required this.duration,
    required this.actionLabel,
    required this.onTap,
  });
}

class IndividualActivityItem {
  final String title;
  final String subtitle;
  final String pointsEarned;
  final String timeAgo;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final VoidCallback onTap;

  const IndividualActivityItem({
    required this.title,
    required this.subtitle,
    required this.pointsEarned,
    required this.timeAgo,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.onTap,
  });
}

class IndividualHomeController extends GetxController {
  final RxString userName = 'Alex'.obs;
  final RxInt streakDays = 7.obs;
  final RxInt rewardsTokens = 245.obs;
  final RxInt currentNavIndex = 0.obs;
  final RxBool isLowBandwidth = false.obs;

  late final List<RecommendedModuleItem> recommendedModules;
  late final List<IndividualActivityItem> recentActivities;

  @override
  void onInit() {
    super.onInit();
    _initRecommendedModules();
    _initRecentActivities();
  }

  void _initRecommendedModules() {
    // 5 Feature entry points replacing curriculum/lesson cards
    recommendedModules = [
      RecommendedModuleItem(
        category: 'AR',
        categoryColor: '#127FD2',
        categoryBg: '#EFF6FF',
        categoryBorder: '#BFDBFE',
        typeTag: '3D Simulation',
        title: 'AR',
        description:
            'Explore interactive 3D simulations and place models directly in real-world environments.',
        duration: 'Interactive',
        actionLabel: 'Explore AR',
        onTap: onOpenAr,
      ),
      RecommendedModuleItem(
        category: 'VR',
        categoryColor: '#7C3AED',
        categoryBg: '#F5F3FF',
        categoryBorder: '#DDD6FE',
        typeTag: '360° Spatial',
        title: 'VR',
        description:
            'Step into 360° virtual spaces, environments, and immersive spatial video tours.',
        duration: '360° Spatial',
        actionLabel: 'Explore VR',
        onTap: onOpenVr,
      ),
      RecommendedModuleItem(
        category: 'AI Tutor',
        categoryColor: '#0284C7',
        categoryBg: '#F0F9FF',
        categoryBorder: '#BAE6FD',
        typeTag: 'Smart Assistant',
        title: 'AI Tutor',
        description:
            'Chat with your 24/7 intelligent study companion for instant answers and guided explanations.',
        duration: 'Instant Q&A',
        actionLabel: 'Chat Now',
        onTap: onOpenAiTutor,
      ),
      RecommendedModuleItem(
        category: 'Quizzes',
        categoryColor: '#B45309',
        categoryBg: '#FFFBEB',
        categoryBorder: '#FDE68A',
        typeTag: 'Quiz Hub',
        title: 'Quizzes',
        description:
            'Challenge yourself with adaptive AI quizzes, timed tests, and skill assessments.',
        duration: 'Assessments',
        actionLabel: 'Open Quizzes',
        onTap: onOpenQuiz,
      ),
      RecommendedModuleItem(
        category: 'Math Solver',
        categoryColor: '#047857',
        categoryBg: '#ECFDF5',
        categoryBorder: '#A7F3D0',
        typeTag: 'Scan / Voice',
        title: 'Math Solver',
        description:
            'Solve math equations with step-by-step guidance via photo scan, voice input, or typing.',
        duration: 'Multi-input',
        actionLabel: 'Open Solver',
        onTap: onOpenMathSolver,
      ),
    ];
  }

  void _initRecentActivities() {
    recentActivities = [
      IndividualActivityItem(
        title: 'Quiz Completed',
        subtitle: 'Adaptive AI Challenge',
        pointsEarned: '+50 Points Earned',
        timeAgo: '2h ago',
        icon: PhosphorIconsBold.checkCircle,
        iconColor: const Color(0xFF10B981),
        iconBg: const Color(0xFFECFDF5),
        onTap: onOpenQuiz,
      ),
      IndividualActivityItem(
        title: 'Points Earned',
        subtitle: '7-Day Streak Active Bonus',
        pointsEarned: '+35 Points Earned',
        timeAgo: 'Today',
        icon: PhosphorIconsBold.fire,
        iconColor: const Color(0xFFF59E0B),
        iconBg: const Color(0xFFFFFBEB),
        onTap: onOpenRewards,
      ),
      IndividualActivityItem(
        title: 'AI Tutor Session',
        subtitle: 'Concept explanations & Q&A',
        pointsEarned: '+25 Points Earned',
        timeAgo: 'Yesterday',
        icon: PhosphorIconsBold.magicWand,
        iconColor: const Color(0xFF0284C7),
        iconBg: const Color(0xFFF0F9FF),
        onTap: onOpenAiTutor,
      ),
      IndividualActivityItem(
        title: 'AR Exploration',
        subtitle: 'Interactive 3D simulation session',
        pointsEarned: '+30 Points Earned',
        timeAgo: '3 days ago',
        icon: PhosphorIconsBold.cube,
        iconColor: const Color(0xFF127FD2),
        iconBg: const Color(0xFFEFF6FF),
        onTap: onOpenAr,
      ),
    ];
  }

  void onSearchTap() {
    currentNavIndex.value = 1;
  }

  void onOpenAr() {
    Get.toNamed(Routes.STUDENT_AR_LEARNING);
  }

  void onOpenVr() {
    Get.toNamed(Routes.STUDENT_VR_VIDEOS);
  }

  void onOpenAiTutor() {
    Get.toNamed(Routes.STUDENT_AI_TUTOR);
  }

  void onOpenQuiz() {
    Get.toNamed(Routes.INDIVIDUAL_QUIZZES);
  }

  void onOpenMathSolver() {
    Get.toNamed(Routes.STUDENT_MATH_SOLVER);
  }

  void onOpenRewards() {
    currentNavIndex.value = 2;
  }

  void onOpenProfile() {
    currentNavIndex.value = 3;
  }

  void onOpenNotifications() {
    Get.toNamed(Routes.NOTIFICATIONS);
  }

  void openEmmerxeduWebView() {
    if (Get.context != null) {
      InAppBrowserSheet.show(Get.context!);
    }
  }

  void toggleLowBandwidth() {
    isLowBandwidth.value = !isLowBandwidth.value;
    Get.snackbar(
      isLowBandwidth.value ? 'Low-Bandwidth Mode On' : 'Standard Quality Mode',
      isLowBandwidth.value
          ? '3D & VR assets optimized for slow connections'
          : 'High fidelity 3D and VR simulations enabled',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0A2540),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
