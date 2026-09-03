import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
import '../students/teacher_student_model.dart';
import 'student_quiz_record_model.dart';

class TeacherStudentDetailController extends GetxController {
  final RxString studentName = 'Sarah Johnson'.obs;
  final RxString studentId = 'STU-1024'.obs;
  final RxBool isActive = true.obs;
  final RxString email = 'sarah.j@school.com'.obs;
  final RxString parentContact = 'Parent: +1 (555) 0192'.obs;
  final RxString totalScore = '2,450'.obs;
  final RxString scoreChange = '12% from last week'.obs;
  final RxString currentRanking = 'Rank #1 of 32 Students'.obs;

  final RxList<StudentQuizRecordModel> recentQuizzes = <StudentQuizRecordModel>[
    const StudentQuizRecordModel(
      id: 'quiz_1',
      title: 'Cell Structure Quiz',
      status: 'Completed',
      score: '8/10',
      iconAsset: AppAssets.iconQuizBeaker,
    ),
    const StudentQuizRecordModel(
      id: 'quiz_2',
      title: 'Human Body Quiz',
      status: 'Completed',
      score: '9/10',
      iconAsset: AppAssets.iconQuizBody,
    ),
    const StudentQuizRecordModel(
      id: 'quiz_3',
      title: 'Cell Structure Quiz',
      status: 'Completed',
      score: '8/10',
      iconAsset: AppAssets.iconQuizBeaker,
    ),
    const StudentQuizRecordModel(
      id: 'quiz_4',
      title: 'Human Body Quiz',
      status: 'Completed',
      score: '9/10',
      iconAsset: AppAssets.iconQuizBody,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      if (args['student'] is TeacherStudentModel) {
        final TeacherStudentModel s = args['student'];
        studentName.value = s.name;
        studentId.value = s.id.replaceAll('ID: ', '');
        isActive.value = s.isOnline;
        final cleanName = s.name.toLowerCase().replaceAll(' ', '.');
        email.value = '$cleanName@school.com';
      } else if (args['name'] != null) {
        studentName.value = args['name'].toString();
      }
    }
  }

  void onBack() {
    Get.back();
  }

  void onRankingTap() {
    if (Get.context != null) {
      Get.snackbar(
        'Student Ranking',
        currentRanking.value,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0E3856),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onViewAllQuizzes() {
    if (Get.context != null) {
      Get.snackbar(
        'Quizzes',
        'Viewing all quizzes for ${studentName.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0E3856),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onQuizTap(StudentQuizRecordModel quiz) {
    if (Get.context != null) {
      Get.snackbar(
        quiz.title,
        'Score: ${quiz.score} (${quiz.status})',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0E3856),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }
}
