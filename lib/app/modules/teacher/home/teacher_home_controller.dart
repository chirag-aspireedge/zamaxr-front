import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../routes/app_pages.dart';
import '../dashboard/teacher_dashboard_controller.dart';
import '../quizzes/teacher_quiz_model.dart';

class RecentLessonItem {
  final String title;
  final String subtitle;
  final String updatedTime;
  final String imageAsset;

  const RecentLessonItem({
    required this.title,
    required this.subtitle,
    required this.updatedTime,
    required this.imageAsset,
  });
}

class TeacherHomeController extends GetxController {
  final RxString teacherName = 'Sarah'.obs;

  final RxList<RecentLessonItem> recentLessons = <RecentLessonItem>[
    const RecentLessonItem(
      title: 'Intro to Quantum Physics',
      subtitle: 'Interactive atomic structures…',
      updatedTime: 'Updated 2h ago',
      imageAsset: 'assets/images/latest_course_thumb.png',
    ),
    const RecentLessonItem(
      title: 'Advanced Thermodynamics',
      subtitle: 'Heat transfer in 3D space…',
      updatedTime: 'Updated 5h ago',
      imageAsset: 'assets/images/onboarding_illustration_2.png',
    ),
    const RecentLessonItem(
      title: 'Cellular Biology XR',
      subtitle: 'Explore mitochondria in VR…',
      updatedTime: 'Updated 1d ago',
      imageAsset: 'assets/images/onboarding_illustration_3.png',
    ),
  ].obs;

  final RxList<TeacherQuizModel> recentQuizzes = <TeacherQuizModel>[
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
      chapter: 'Motion & Gravity',
      classSubject: 'Class 9 • Physics',
      date: 'Aug 16, 2026',
      isActive: false,
      questionCount: 15,
      durationMinutes: 20,
      assignedClass: null,
    ),
    const TeacherQuizModel(
      id: 'quiz_3',
      title: 'Biology XR',
      chapter: 'Cell Structure',
      classSubject: 'Class 10 • Biology',
      date: 'Aug 15, 2026',
      isActive: true,
      questionCount: 12,
      durationMinutes: 20,
      assignedClass: 'Class 10-B',
    ),
    const TeacherQuizModel(
      id: 'quiz_4',
      title: 'Chemistry',
      chapter: 'Periodic Table',
      classSubject: 'Class 11 • Chemistry',
      date: 'Aug 14, 2026',
      isActive: true,
      questionCount: 8,
      durationMinutes: 10,
      assignedClass: 'Class 11-A',
    ),
  ].obs;

  void onCreateImmersiveLesson() {
    Get.toNamed(Routes.CREATE_CLASS);
  }

  void onCreateLesson() {
    Get.toNamed(Routes.TEACHER_CREATE_LESSON);
  }

  void onCreateQuiz() {
    Get.toNamed(Routes.TEACHER_CREATE_QUIZ);
  }

  void onUploadContent() {
    Get.toNamed(Routes.SUBJECTS);
  }

  void onSeeAllLessons() {
    if (Get.isRegistered<TeacherDashboardController>()) {
      Get.find<TeacherDashboardController>().changeTab(1);
    } else {
      Get.toNamed(Routes.TEACHER_LESSONS);
    }
  }

  void onSeeAllQuizzes() {
    Get.toNamed(Routes.TEACHER_QUIZZES);
  }

  void onRegenerateQuiz(TeacherQuizModel quiz) {
    Get.toNamed(
      Routes.TEACHER_AI_QUIZ,
      arguments: {
        'topic': quiz.title,
        'chapter': quiz.chapter,
        'subject': quiz.classSubject,
      },
    );
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
          ],
        ),
      ),
    );
  }

  void onNotifications() {
    Get.toNamed(Routes.NOTIFICATIONS);
  }

  void onSettings() {
    Get.toNamed(Routes.PROFILE);
  }

  void onEditLesson(RecentLessonItem lesson) {
    Get.toNamed(Routes.TEACHER_LESSONS, arguments: lesson.title);
  }
}
