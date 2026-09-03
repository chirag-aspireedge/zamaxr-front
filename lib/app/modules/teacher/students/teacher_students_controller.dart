import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';
import 'teacher_student_model.dart';

class TeacherStudentsController extends GetxController {
  final RxInt studentsCount = 30.obs;

  final RxList<TeacherStudentModel> students = <TeacherStudentModel>[
    const TeacherStudentModel(
      id: 'ID: STU-1024',
      name: 'Sarah Johnson',
      isOnline: true,
      imageAsset: AppAssets.studentAvatarSarah,
    ),
    const TeacherStudentModel(
      id: 'ID: STU-1025',
      name: 'Michael Chen',
      isOnline: true,
      imageAsset: AppAssets.studentAvatarMichael,
    ),
    const TeacherStudentModel(
      id: 'ID: STU-1026',
      name: 'Emma Patel',
      isOnline: false,
      initials: 'EP',
      initialsBgColor: Color(0xFFEDEEEF),
      initialsTextColor: Color(0xFF445D80),
    ),
    const TeacherStudentModel(
      id: 'ID: STU-1027',
      name: 'James Davis',
      isOnline: true,
      initials: 'JD',
      initialsBgColor: Color(0xFF63787B),
      initialsTextColor: Color(0xFFF6FEFF),
    ),
    const TeacherStudentModel(
      id: 'ID: STU-1028',
      name: 'Olivia Wilson',
      isOnline: false,
      imageAsset: AppAssets.studentAvatarOlivia,
    ),
  ].obs;

  void onAddStudent() {
    if (Get.context != null) {
      Get.snackbar(
        'Add Student',
        'Add student dialog opened',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0E3856),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onStudentTap(TeacherStudentModel student) {
    Get.toNamed(
      Routes.TEACHER_STUDENT_DETAIL,
      arguments: {
        'student': student,
      },
    );
  }
}
