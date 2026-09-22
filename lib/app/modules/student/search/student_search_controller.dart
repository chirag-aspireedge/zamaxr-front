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

  final List<String> categories = const [
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
    final filtered = initialResults.where((item) {
      if (q.isNotEmpty) {
        final matchesQuery = item.title.toLowerCase().contains(q) ||
            item.category.toLowerCase().contains(q) ||
            item.subject.toLowerCase().contains(q) ||
            item.description.toLowerCase().contains(q);
        if (!matchesQuery) return false;
      }

      if (selectedCategory.value == 'All') return true;
      if (selectedCategory.value == 'Lessons') return true;
      if (selectedCategory.value == 'Subjects') {
        return item.category.toLowerCase().contains(q) ||
            item.subject.toLowerCase().contains(q);
      }
      if (selectedCategory.value == 'AR Experiences') {
        return item.mediaBadges.any((b) => b.type == StudentSearchMediaType.ar);
      }
      return true;
    }).toList();

    return filtered;
  }

  String get resultsCountSummary {
    final count = searchResults.length;
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

  void onResultAction(StudentSearchResultModel result) {
    if (Get.context != null) {
      Get.toNamed(Routes.STUDENT_LESSON_DETAIL, arguments: result);
    }
  }
}
