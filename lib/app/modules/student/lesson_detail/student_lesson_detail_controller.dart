import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import 'student_lesson_detail_model.dart';

class StudentLessonDetailController extends GetxController {
  late final Rx<StudentLessonDetailModel> lesson;

  @override
  void onInit() {
    super.onInit();
    lesson = _createInitialLesson().obs;
  }

  StudentLessonDetailModel _createInitialLesson() {
    return const StudentLessonDetailModel(
      id: 'cell_structure',
      title: 'Cell Structure',
      subject: 'Biology',
      gradeLevel: 'Class 8',
      durationText: '12 min',
      progress: 0.65,
      progressPercentageText: '65% Complete',
      aboutTitle: 'About This Lesson',
      aboutDescription:
          'Explore the structure and functions of cells and understand how different cell components work together to sustain life at the microscopic level.',
      quizTitle: 'Test Your Knowledge',
      quizQuestionsCount: 10,
      contentItems: [
        StudentLessonContentItem(
          id: 'video_item',
          type: StudentLessonContentType.video,
          title: 'Cell Structure Explained',
          subtitle: 'Video · 08:42',
          status: StudentLessonContentStatus.completed,
          iconBackgroundColor: Color(0x1A0059BB), // rgba(0, 89, 187, 0.1)
          iconColor: Color(0xFF0059BB),
          cardOpacity: 1.0,
        ),
        StudentLessonContentItem(
          id: 'pdf_item',
          type: StudentLessonContentType.pdf,
          title: 'Cell Structure Notes',
          subtitle: 'PDF Document',
          status: StudentLessonContentStatus.inProgress,
          iconBackgroundColor: Color(0xFFBDD6FF),
          iconColor: Color(0xFF445D80),
          cardOpacity: 1.0,
        ),
        StudentLessonContentItem(
          id: 'audio_item',
          type: StudentLessonContentType.audio,
          title: 'Cell Structure Summary',
          subtitle: 'Audio · 03:15',
          status: StudentLessonContentStatus.locked,
          iconBackgroundColor: Color(0xFF63787B),
          iconColor: Color(0xFFF6FEFF),
          cardOpacity: 0.7,
        ),
      ],
    );
  }

  void onBackTap() {
    Get.back();
  }

  void onStartQuiz() {
    if (Get.context != null) {
      Get.toNamed(Routes.STUDENT_QUIZ);
    }
  }

  void onContentItemTap(StudentLessonContentItem item) {
    if (item.isLocked) {
      if (Get.context != null) {
        Get.snackbar(
          'Locked Item',
          'Complete preceding lesson activities to unlock ${item.title}.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
      return;
    }

    if (Get.context != null) {
      Get.toNamed(Routes.STUDENT_SUB_LESSON);
    }
  }

  void onExploreAr() {
    Get.toNamed(Routes.STUDENT_AR_LEARNING);
  }

  void onExperienceVr() {
    Get.toNamed(Routes.STUDENT_VR_VIDEOS);
  }

  void onContinueLesson() {
    if (Get.context != null) {
      Get.toNamed(Routes.STUDENT_SUB_LESSON);
    }
  }
}
