import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../individual/home/individual_home_controller.dart';

enum StudentSearchMediaType {
  video,
  document,
  quiz,
  ar,
}

class StudentSearchMediaBadge {
  final StudentSearchMediaType type;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final bool hasActiveGlow;

  const StudentSearchMediaBadge({
    required this.type,
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    this.hasActiveGlow = false,
  });
}

class StudentSearchResultModel {
  final String id;
  final String category;
  final String title;
  final String description;
  final String gradeLevel;
  final String subject;
  final bool hasProgress;
  final double progress;
  final String progressText;
  final String ctaText;
  final List<StudentSearchMediaBadge> mediaBadges;

  const StudentSearchResultModel({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.gradeLevel,
    required this.subject,
    required this.ctaText,
    required this.mediaBadges,
    this.hasProgress = false,
    this.progress = 0.0,
    this.progressText = '',
  });

  String get metadataLine => '$gradeLevel • $subject';
}

class StudentSearchController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  final RxString query = ''.obs;
  final RxString selectedCategory = 'All'.obs;
  final RxBool hasUnreadNotifications = true.obs;

  bool get isIndividual => Get.isRegistered<IndividualHomeController>();

  List<String> get categories => isIndividual
      ? const [
          'All',
          'AR',
          'VR',
          'AI Tutor',
          'Quizzes',
          'Math Solver',
        ]
      : const [
          'All',
          'Lessons',
          'Subjects',
          'AR Experiences',
        ];

  final List<String> popularSearches = const [
    'Biology',
    'Mathematics',
    'Social science',
  ];

  // Default sample results matching Figma specs
  final List<StudentSearchResultModel> initialResults = const [
    StudentSearchResultModel(
      id: 'res_1',
      category: 'BIOLOGY',
      title: 'Photosynthesis',
      description:
          'Learn how plants convert light energy into chemical energy. Dive into the…',
      gradeLevel: 'Class 8',
      subject: 'Biology',
      hasProgress: true,
      progress: 0.65,
      progressText: '65% complete',
      ctaText: 'Continue Lesson',
      mediaBadges: [
        StudentSearchMediaBadge(
          type: StudentSearchMediaType.video,
          icon: PhosphorIconsFill.playCircle,
          backgroundColor: Color(0xFFE0F6FF),
          iconColor: Color(0xFF414754),
        ),
        StudentSearchMediaBadge(
          type: StudentSearchMediaType.quiz,
          icon: PhosphorIconsFill.question,
          backgroundColor: Color(0xFFE0F6FF),
          iconColor: Color(0xFF414754),
        ),
        StudentSearchMediaBadge(
          type: StudentSearchMediaType.ar,
          icon: PhosphorIconsFill.cube,
          backgroundColor: Color(0xFF0059BB),
          iconColor: Colors.white,
          hasActiveGlow: true,
        ),
      ],
    ),
    StudentSearchResultModel(
      id: 'res_2',
      category: 'CHEMISTRY',
      title: 'Photosynthesis & Plant Energy',
      description:
          'Explore the chemical reactions and molecular structures involved in plant',
      gradeLevel: 'Class 8',
      subject: 'Chemistry',
      hasProgress: false,
      progress: 0.0,
      progressText: '',
      ctaText: 'Start Lesson',
      mediaBadges: [
        StudentSearchMediaBadge(
          type: StudentSearchMediaType.document,
          icon: PhosphorIconsFill.fileText,
          backgroundColor: Color(0xFFE1E3E4),
          iconColor: Color(0xFF414754),
        ),
        StudentSearchMediaBadge(
          type: StudentSearchMediaType.quiz,
          icon: PhosphorIconsFill.question,
          backgroundColor: Color(0xFFE1E3E4),
          iconColor: Color(0xFF414754),
        ),
      ],
    ),
  ];

  // Individual Role: Feature-based results (No lessons/subjects)
  final List<StudentSearchResultModel> individualFeatureResults = const [
    StudentSearchResultModel(
      id: 'feat_ar',
      category: 'AR FEATURE',
      title: 'AR',
      description:
          'Explore interactive 3D simulations and place 3D models directly in your physical environment.',
      gradeLevel: 'Feature Tool',
      subject: 'Interactive 3D',
      hasProgress: false,
      ctaText: 'Explore AR',
      mediaBadges: [
        StudentSearchMediaBadge(
          type: StudentSearchMediaType.ar,
          icon: PhosphorIconsFill.cube,
          backgroundColor: Color(0xFF0059BB),
          iconColor: Colors.white,
          hasActiveGlow: true,
        ),
      ],
    ),
    StudentSearchResultModel(
      id: 'feat_vr',
      category: 'VR FEATURE',
      title: 'VR',
      description:
          'Step into 360° virtual reality spaces, environments, and immersive spatial visual journeys.',
      gradeLevel: 'Spatial Tool',
      subject: '360° Spatial',
      hasProgress: false,
      ctaText: 'Explore VR',
      mediaBadges: [
        StudentSearchMediaBadge(
          type: StudentSearchMediaType.video,
          icon: PhosphorIconsFill.playCircle,
          backgroundColor: Color(0xFF7C3AED),
          iconColor: Colors.white,
          hasActiveGlow: true,
        ),
      ],
    ),
    StudentSearchResultModel(
      id: 'feat_ai_tutor',
      category: 'AI TUTOR',
      title: 'AI Tutor',
      description:
          'Chat with your 24/7 intelligent study companion for instant answers, concept breakdowns, and guided learning.',
      gradeLevel: 'Smart Assistant',
      subject: 'AI Tutor',
      hasProgress: false,
      ctaText: 'Open AI Tutor',
      mediaBadges: [
        StudentSearchMediaBadge(
          type: StudentSearchMediaType.ar,
          icon: PhosphorIconsFill.sparkle,
          backgroundColor: Color(0xFF0284C7),
          iconColor: Colors.white,
          hasActiveGlow: true,
        ),
      ],
    ),
    StudentSearchResultModel(
      id: 'feat_quizzes',
      category: 'QUIZZES',
      title: 'Quizzes',
      description:
          'Challenge yourself with adaptive AI quizzes and curated skill tests with real-time feedback.',
      gradeLevel: 'Assessments',
      subject: 'Quizzes',
      hasProgress: false,
      ctaText: 'Open Quizzes',
      mediaBadges: [
        StudentSearchMediaBadge(
          type: StudentSearchMediaType.quiz,
          icon: PhosphorIconsFill.question,
          backgroundColor: Color(0xFFD97706),
          iconColor: Colors.white,
          hasActiveGlow: true,
        ),
      ],
    ),
    StudentSearchResultModel(
      id: 'feat_math_solver',
      category: 'MATH SOLVER',
      title: 'Math Solver',
      description:
          'Solve math equations with step-by-step guidance via photo scan, voice input, or typing.',
      gradeLevel: 'Problem Solver',
      subject: 'Math Solver',
      hasProgress: false,
      ctaText: 'Open Math Solver',
      mediaBadges: [
        StudentSearchMediaBadge(
          type: StudentSearchMediaType.document,
          icon: PhosphorIconsFill.calculator,
          backgroundColor: Color(0xFF059669),
          iconColor: Colors.white,
          hasActiveGlow: true,
        ),
      ],
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    searchTextController.addListener(() {
      query.value = searchTextController.text.trim();
    });
  }

  @override
  void onClose() {
    searchTextController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }

  void onSearchChanged(String value) {
    query.value = value.trim();
  }

  void selectPopularSearch(String keyword) {
    searchTextController.text = keyword;
    searchTextController.selection = TextSelection.fromPosition(
      TextPosition(offset: keyword.length),
    );
    query.value = keyword;
  }

  void clearSearch() {
    searchTextController.clear();
    query.value = '';
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
  }

  bool get isSearching => query.value.isNotEmpty;

  List<StudentSearchResultModel> get searchResults {
    final q = query.value.toLowerCase().trim();
    final sourceList = isIndividual ? individualFeatureResults : initialResults;

    final filtered = sourceList.where((item) {
      if (q.isNotEmpty) {
        final matchesQuery = item.title.toLowerCase().contains(q) ||
            item.category.toLowerCase().contains(q) ||
            item.subject.toLowerCase().contains(q) ||
            item.description.toLowerCase().contains(q);
        if (!matchesQuery) return false;
      }

      if (selectedCategory.value == 'All') return true;

      if (isIndividual) {
        if (selectedCategory.value == 'AR' && item.title == 'AR') return true;
        if (selectedCategory.value == 'VR' && item.title == 'VR') return true;
        if (selectedCategory.value == 'AI Tutor' && item.title == 'AI Tutor') return true;
        if (selectedCategory.value == 'Quizzes' && item.title == 'Quizzes') return true;
        if (selectedCategory.value == 'Math Solver' && item.title == 'Math Solver') return true;
        return item.title.toLowerCase() == selectedCategory.value.toLowerCase() ||
            item.category.toLowerCase().contains(selectedCategory.value.toLowerCase());
      }

      if (selectedCategory.value == 'Lessons') return true;
      if (selectedCategory.value == 'Subjects') {
        return item.category.toLowerCase().contains(q) ||
            item.subject.toLowerCase().contains(q);
      }
      if (selectedCategory.value == 'AR Experiences') {
        return item.mediaBadges.any((b) => b.type == StudentSearchMediaType.ar);
      }
      if (selectedCategory.value == 'VR Videos') {
        return item.mediaBadges.any((b) => b.type == StudentSearchMediaType.video);
      }
      if (selectedCategory.value == 'Quizzes') {
        return item.mediaBadges.any((b) => b.type == StudentSearchMediaType.quiz);
      }
      return true;
    }).toList();

    return filtered;
  }

  String get resultsCountSummary {
    final count = searchResults.length;
    if (isIndividual) {
      if (query.value.trim().isEmpty) {
        return '$count features available';
      }
      final term = query.value.trim();
      return '$count features found for "$term"';
    }
    if (query.value.trim().isEmpty) {
      return '$count topics available';
    }
    final term = query.value.trim();
    return '$count results found for "$term"';
  }

  void onBackTap() {
    if (isSearching) {
      clearSearch();
      return;
    }
    if (Get.isRegistered<IndividualHomeController>()) {
      final homeController = Get.find<IndividualHomeController>();
      if (homeController.currentNavIndex.value == 1) {
        homeController.currentNavIndex.value = 0;
        return;
      }
    }
    Get.back();
  }

  void onNotificationTap() {
    hasUnreadNotifications.value = false;
    if (Get.context != null) {
      Get.snackbar(
        'Notifications',
        'You have no new alerts at this time.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  String getCtaText(StudentSearchResultModel result) {
    if (!isIndividual) return result.ctaText;
    if (result.title == 'AR') return 'Explore AR';
    if (result.title == 'VR') return 'Explore VR';
    if (result.title == 'AI Tutor') return 'Open AI Tutor';
    if (result.title == 'Quizzes') return 'Open Quizzes';
    if (result.title == 'Math Solver') return 'Open Math Solver';
    return result.ctaText;
  }

  void onResultAction(StudentSearchResultModel result) {
    if (Get.context != null) {
      if (isIndividual) {
        if (result.title == 'AR') {
          Get.toNamed(Routes.STUDENT_AR_LEARNING);
        } else if (result.title == 'VR') {
          Get.toNamed(Routes.STUDENT_VR_VIDEOS);
        } else if (result.title == 'AI Tutor') {
          Get.toNamed(Routes.STUDENT_AI_TUTOR);
        } else if (result.title == 'Quizzes') {
          Get.toNamed(Routes.INDIVIDUAL_QUIZZES);
        } else if (result.title == 'Math Solver') {
          Get.toNamed(Routes.STUDENT_MATH_SOLVER);
        } else {
          Get.toNamed(Routes.STUDENT_AR_LEARNING);
        }
        return;
      }
      Get.toNamed(Routes.STUDENT_LESSON_DETAIL, arguments: result);
    }
  }
}
