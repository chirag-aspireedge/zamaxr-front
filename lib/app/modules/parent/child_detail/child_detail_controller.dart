import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home/parent_home_controller.dart';

class ChildSubjectProgressModel {
  final String subject;
  final String progressLabel;
  final double progressPercent;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final Color progressColor;

  const ChildSubjectProgressModel({
    required this.subject,
    required this.progressLabel,
    required this.progressPercent,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    this.progressColor = const Color(0xFF127FD2),
  });
}

class ChildQuizResultModel {
  final String quizTitle;
  final String dateSubtitle;
  final String scoreText;

  const ChildQuizResultModel({
    required this.quizTitle,
    required this.dateSubtitle,
    required this.scoreText,
  });
}

class ChildActivityTimelineModel {
  final String title;
  final String timeSubtitle;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const ChildActivityTimelineModel({
    required this.title,
    required this.timeSubtitle,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });
}

class ChildDetailController extends GetxController {
  late final Rx<ChildProgressModel> child;

  // Stat metrics
  final RxString lessonsMetric = '15/21'.obs;
  final RxString quizAvgMetric = '8.2'.obs;
  final RxString quizAvgMax = '/10'.obs;
  final RxString creditsMetric = '120'.obs;
  final RxString totalRewardsValue = '120'.obs;
  final RxString rewardTrend = '+20 this week'.obs;

  // Subject Progress list
  final List<ChildSubjectProgressModel> subjects = [
    const ChildSubjectProgressModel(
      subject: 'Biology',
      progressLabel: '6 of 8',
      progressPercent: 0.75,
      icon: Icons.biotech_rounded,
      iconBgColor: Color(0x33D9DADA),
      iconColor: Color(0xFF414754),
      progressColor: Color(0xFF127FD2),
    ),
    const ChildSubjectProgressModel(
      subject: 'Mathematics',
      progressLabel: '5 of 7',
      progressPercent: 0.714,
      icon: Icons.calculate_rounded,
      iconBgColor: Color(0xFFE0F6FF),
      iconColor: Color(0xFF476083),
      progressColor: Color(0xFF127FD2),
    ),
    const ChildSubjectProgressModel(
      subject: 'English',
      progressLabel: '4 of 6',
      progressPercent: 0.666,
      icon: Icons.auto_stories_rounded,
      iconBgColor: Color(0x33FFDAD6),
      iconColor: Color(0xFFBA1A1A),
      progressColor: Color(0xFF127FD2),
    ),
  ];

  // Quiz Results list
  final List<ChildQuizResultModel> quizResults = [
    const ChildQuizResultModel(
      quizTitle: 'Cell Structure Quiz',
      dateSubtitle: 'Today',
      scoreText: '8/10',
    ),
    const ChildQuizResultModel(
      quizTitle: 'Algebra Basics',
      dateSubtitle: 'Yesterday',
      scoreText: '9/10',
    ),
  ];

  // Activity Timeline list
  final List<ChildActivityTimelineModel> activities = [
    const ChildActivityTimelineModel(
      title: 'Completed Cell Structure lesson',
      timeSubtitle: 'Today',
      icon: Icons.check_circle_rounded,
      iconBgColor: Color(0xFF127FD2),
      iconColor: Color(0xFFFEFCFF),
    ),
    const ChildActivityTimelineModel(
      title: 'Earned 20 reward credits',
      timeSubtitle: 'Today',
      icon: Icons.stars_rounded,
      iconBgColor: Color(0xFFE0F6FF),
      iconColor: Color(0xFF445D80),
    ),
    const ChildActivityTimelineModel(
      title: 'Completed Algebra Quiz',
      timeSubtitle: 'Yesterday',
      icon: Icons.quiz_rounded,
      iconBgColor: Color(0xFF414754),
      iconColor: Color(0xFFF6FEFF),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is ChildProgressModel) {
      child = args.obs;
    } else {
      // Fallback default from Figma specification
      child = const ChildProgressModel(
        id: '1',
        name: 'Daniel Johnson',
        gradeAndSchool: 'Class 8',
        avatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
        status: 'Active',
        curriculumLessons: '15 of 21 lessons',
        progressPercent: 0.72,
        recentActivity: 'Cell Structure Quiz: 9/10',
        recentIcon: Icons.check_circle_rounded,
      ).obs;
    }
  }

  void onBack() {
    Get.back();
  }

  void onSubjectTap(ChildSubjectProgressModel subject) {
    Get.snackbar(
      subject.subject,
      'Opening detailed lessons for ${subject.subject}...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF127FD2),
      colorText: Colors.white,
    );
  }

  void onQuizResultTap(ChildQuizResultModel quiz) {
    Get.snackbar(
      quiz.quizTitle,
      'Score: ${quiz.scoreText} • Verified Assessment',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF127FD2),
      colorText: Colors.white,
    );
  }
}
