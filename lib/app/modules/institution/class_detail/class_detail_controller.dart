import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../classes/classes_model.dart';
import '../teachers/teachers_model.dart';
import 'class_detail_model.dart';

class ClassDetailController extends GetxController {
  late final Rx<ClassDetailModel> classData;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  void _initData() {
    String classTitle = 'Class 8-A';
    String classSubject = 'Science';
    String classGrade = '8';
    String classSection = 'A';
    int students = 32;

    if (Get.arguments != null) {
      if (Get.arguments is ClassDetailItem) {
        final item = Get.arguments as ClassDetailItem;
        classTitle = item.classGrade;
        classSubject = item.subject;
        students = item.studentCount;
      }
    }


    final sarah = TeacherItem(
      id: '1',
      name: 'Sarah Johnson',
      subjectTitle: 'Mathematics Teacher',
      classCountText: '3 Classes',
      isOnline: true,
      phone: '+91 1234567890',
      email: 'sarah@dummy.com',
      avatarAsset: 'assets/images/teacher_avatar.png',
      teacherIdCode: 'TCH-1024',
      assignedClass: 'Class -8',
      assignedSubject: 'Mathematics',
      studentsCount: 32,
    );

    final john = TeacherItem(
      id: '2',
      name: 'John Doe',
      subjectTitle: 'Science Teacher',
      classCountText: '2 Classes',
      isOnline: false,
      phone: '+91 9876543210',
      email: 'john@dummy.com',
      avatarAsset: 'assets/images/teacher_avatar.png',
      teacherIdCode: 'TCH-1025',
      assignedClass: 'Class -8',
      assignedSubject: 'Science',
      studentsCount: 28,
    );

    final joffery = TeacherItem(
      id: '3',
      name: 'Joffery Mark',
      subjectTitle: 'English Teacher',
      classCountText: '4 Classes',
      isOnline: true,
      phone: '+91 9123456780',
      email: 'joffery@dummy.com',
      avatarAsset: 'assets/images/teacher_avatar.png',
      teacherIdCode: 'TCH-1026',
      assignedClass: 'Class -8',
      assignedSubject: 'English',
      studentsCount: 30,
    );

    final activities = [
      ClassActivityItem(
        id: '1',
        title: 'John Doe was assigned as Science Teacher.',
        timeText: 'Today, 09:30 AM',
        isScheduleUpdate: false,
      ),
      ClassActivityItem(
        id: '2',
        title: '3 New students added to the class',
        timeText: 'Yesterday, 02:26 PM',
        isScheduleUpdate: false,
      ),
      ClassActivityItem(
        id: '3',
        title: 'Class schedule Updated.',
        timeText: 'Monday, 10:00 AM',
        isScheduleUpdate: true,
      ),
    ];

    classData = ClassDetailModel(
      id: '1',
      title: classTitle,
      grade: classGrade,
      section: classSection,
      subject: classSubject,
      academicYear: '2026-27',
      classTeacherName: 'Sarah Johnson',
      studentsCount: students,
      teachersCount: 3,
      lessonsCount: 24,
      quizzesCount: 18,
      vrAssetsCount: 9,
      subjects: const ['Mathematics', 'Science', 'Social Science'],
      currentTeacher: sarah,
      pastTeachers: [john, joffery],
      recentActivities: activities,
    ).obs;
  }

  void onSubjectTap(String subject) {
    Get.toNamed(Routes.SUBJECTS, arguments: {'subject': subject});
  }

  void onViewAllSubjects() {
    Get.toNamed(Routes.SUBJECTS);
  }

  void onTeacherTap(TeacherItem teacher) {
    Get.toNamed(Routes.TEACHER_DETAIL, arguments: teacher);
  }

  void onAddTeacher() {
    Get.toNamed(Routes.CREATE_TEACHER);
  }

  void onEditClass() {
    Get.snackbar(
      'Edit Class',
      'Opening edit view for ${classData.value.title}...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
