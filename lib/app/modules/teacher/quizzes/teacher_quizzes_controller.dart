import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../routes/app_pages.dart';
import 'teacher_quiz_model.dart';

class TeacherQuizzesController extends GetxController {
  final RxInt selectedTabIndex = 0.obs; // 0: All, 1: Active, 2: Inactive
  final RxString searchQuery = ''.obs;
  late final TextEditingController searchController;

  final RxList<TeacherQuizModel> quizzes = <TeacherQuizModel>[
    const TeacherQuizModel(
      id: 'quiz_1',
      title: 'General Science',
      chapter: 'Chapter 1',
      classSubject: 'Class 10 • Science',
      date: 'Aug 18, 2026',
      isActive: true,
      questionCount: 10,
      durationMinutes: 15,
      assignedClass: 'Class 10-A',
    ),
    const TeacherQuizModel(
      id: 'quiz_2',
      title: 'Physics',
      chapter: 'Motion',
      classSubject: 'Class 9 • Physics',
      date: 'Aug 16, 2026',
      isActive: false,
      questionCount: 15,
      durationMinutes: 20,
      assignedClass: null,
    ),
    const TeacherQuizModel(
      id: 'quiz_3',
      title: 'General Science',
      chapter: 'Chapter 1',
      classSubject: 'Class 10 • Science',
      date: 'Aug 18, 2026',
      isActive: true,
      questionCount: 10,
      durationMinutes: 15,
      assignedClass: 'Class 10-A',
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  List<TeacherQuizModel> get filteredQuizzes {
    return quizzes.where((quiz) {
      // 1. Tab filter
      if (selectedTabIndex.value == 1 && !quiz.isActive) return false;
      if (selectedTabIndex.value == 2 && quiz.isActive) return false;

      // 2. Search query filter
      final q = searchQuery.value.trim().toLowerCase();
      if (q.isEmpty) return true;

      final titleMatch = quiz.title.toLowerCase().contains(q);
      final chapterMatch = quiz.chapter.toLowerCase().contains(q);
      final classMatch = quiz.classSubject.toLowerCase().contains(q);
      final assignedMatch = quiz.assignedClass?.toLowerCase().contains(q) ?? false;

      return titleMatch || chapterMatch || classMatch || assignedMatch;
    }).toList();
  }

  void onSelectTab(int index) {
    selectedTabIndex.value = index;
  }

  void onSearchChanged(String query) {
    searchQuery.value = query;
  }

  void onClearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }

  void onRegenerateQuiz(TeacherQuizModel quiz) {
    _showNotice(
      'Regenerating Quiz',
      'Opening AI Quiz Generator for ${quiz.title}...',
    );

    if (Get.testMode || Get.context == null) return;

    Get.toNamed(
      Routes.TEACHER_AI_QUIZ,
      arguments: {
        'topic': quiz.title,
        'chapter': quiz.chapter,
        'subject': quiz.classSubject,
      },
    );
  }

  void onCreateNewQuiz() {
    if (Get.testMode || Get.context == null) return;
    Get.toNamed(Routes.TEACHER_CREATE_QUIZ);
  }

  void onQuizOptions(TeacherQuizModel quiz) {
    if (Get.context == null) return;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quiz.title,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
              ),
            ),
            Text(
              '${quiz.chapter} • ${quiz.classSubject}',
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF414754),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: Color(0xFF127FD2)),
              title: const Text(
                'Edit Quiz Questions',
                style: TextStyle(fontFamily: AppTextStyle.fontFamily, fontSize: 15),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(
                  Routes.TEACHER_REVIEW_QUIZ,
                  arguments: {
                    'quizTitle': '${quiz.title} Assessment',
                    'subject': quiz.classSubject,
                    'isAi': true,
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.assignment_ind_outlined, color: Color(0xFF127FD2)),
              title: const Text(
                'Assign to Class',
                style: TextStyle(fontFamily: AppTextStyle.fontFamily, fontSize: 15),
              ),
              onTap: () {
                Get.back();
                Get.toNamed(
                  Routes.TEACHER_FINAL_QUIZ,
                  arguments: {
                    'quizTitle': quiz.title,
                    'subject': quiz.classSubject,
                    'questionCount': quiz.questionCount,
                    'duration': '~${quiz.durationMinutes}m',
                    'selectedClass': quiz.assignedClass ?? 'Class 8-A',
                  },
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.refresh, color: Color(0xFF127FD2)),
              title: const Text(
                'Regenerate Quiz',
                style: TextStyle(fontFamily: AppTextStyle.fontFamily, fontSize: 15),
              ),
              onTap: () {
                Get.back();
                onRegenerateQuiz(quiz);
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Colors.red),
              title: const Text(
                'Delete Quiz',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
              onTap: () {
                quizzes.removeWhere((item) => item.id == quiz.id);
                Get.back();
                _showNotice('Quiz Deleted', '${quiz.title} has been removed');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showNotice(String title, String message) {
    if (Get.testMode || Get.context == null) return;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}
