import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class StudentCourseModel {
  final String id;
  final String term;
  final String subject;
  final String continueLesson;
  final String lastViewed;
  final double progress; // 0.0 to 1.0
  final bool hasOfflineBadge;
  final RxBool isOfflineAvailable;
  final Color termColor;
  final LinearGradient accentGradient;
  final double gradientOpacity;
  final Color buttonBgColor;
  final Color buttonTextColor;

  StudentCourseModel({
    required this.id,
    required this.term,
    required this.subject,
    required this.continueLesson,
    required this.lastViewed,
    required this.progress,
    required this.hasOfflineBadge,
    bool isOffline = true,
    required this.termColor,
    required this.accentGradient,
    this.gradientOpacity = 1.0,
    required this.buttonBgColor,
    required this.buttonTextColor,
  }) : isOfflineAvailable = isOffline.obs;
}

class StudentMyLearningController extends GetxController {
  final selectedFilter = 'All'.obs;
  final searchQuery = ''.obs;

  late final RxList<StudentCourseModel> courses;

  @override
  void onInit() {
    super.onInit();
    courses = <StudentCourseModel>[
      // Biology Card
      StudentCourseModel(
        id: 'biology_term1',
        term: 'Term 1',
        subject: 'Biology',
        continueLesson: 'Continue: Cell Structure',
        lastViewed: 'Last viewed: Lesson 4',
        progress: 0.65,
        hasOfflineBadge: true,
        isOffline: true,
        termColor: const Color(0xFF0059BB),
        accentGradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF0059BB), Color(0xFF0070EA)],
        ),
        buttonBgColor: const Color(0xFF127FD2),
        buttonTextColor: const Color(0xFFFFFFFF),
      ),

      // Mathematics Card
      StudentCourseModel(
        id: 'math_term1',
        term: 'Term 1',
        subject: 'Mathematics',
        continueLesson: 'Continue: Quadratic Equations',
        lastViewed: 'Last viewed: Lesson 2',
        progress: 0.40,
        hasOfflineBadge: true,
        isOffline: true,
        termColor: const Color(0xFF476083),
        accentGradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF476083), Color(0xFFBDD6FF)],
        ),
        buttonBgColor: const Color(0xFFE0F6FF),
        buttonTextColor: const Color(0xFF0059BB),
      ),

      // English Card
      StudentCourseModel(
        id: 'english_term1',
        term: 'Term 1',
        subject: 'English',
        continueLesson: 'Continue: Shakespearean Sonnets',
        lastViewed: 'Last viewed: Lesson 7',
        progress: 0.85,
        hasOfflineBadge: false,
        isOffline: false,
        termColor: const Color(0xFF4B6062),
        accentGradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF127FD2), Color(0xFF0E3856)],
        ),
        buttonBgColor: const Color(0xFFE0F6FF),
        buttonTextColor: const Color(0xFF0059BB),
      ),

      // Physics Card
      StudentCourseModel(
        id: 'physics_term1',
        term: 'Term 1',
        subject: 'Physics',
        continueLesson: 'Continue: Thermodynamics',
        lastViewed: 'Last viewed: Lesson 1',
        progress: 0.15,
        hasOfflineBadge: true,
        isOffline: true,
        termColor: const Color(0xFF127FD2),
        accentGradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [Color(0xFF0059BB), Color(0xFF0070EA)],
        ),
        gradientOpacity: 0.6,
        buttonBgColor: const Color(0xFFE0F6FF),
        buttonTextColor: const Color(0xFF127FD2),
      ),
    ].obs;
  }

  List<StudentCourseModel> get filteredCourses {
    if (selectedFilter.value == 'All') {
      return courses;
    } else if (selectedFilter.value == 'Offline') {
      return courses.where((c) => c.hasOfflineBadge && c.isOfflineAvailable.value).toList();
    } else if (selectedFilter.value == 'Completed') {
      return courses.where((c) => c.progress >= 0.8).toList();
    }
    return courses;
  }

  void onContinueCourse(StudentCourseModel course) {
    if (Get.context != null) {
      Get.toNamed(Routes.STUDENT_LESSON_DETAIL, arguments: course);
    }
  }

  void toggleOffline(StudentCourseModel course) {
    if (!course.hasOfflineBadge) return;
    course.isOfflineAvailable.toggle();
    if (Get.context != null && !Get.testMode) {
      Get.snackbar(
        course.isOfflineAvailable.value ? 'Offline Mode Active' : 'Downloaded Lessons Cleared',
        '${course.subject} is ${course.isOfflineAvailable.value ? "now available without internet." : "removed from offline storage."}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0059BB),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }
}
