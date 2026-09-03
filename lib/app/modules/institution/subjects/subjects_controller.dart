import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import 'subjects_model.dart';

class SubjectsController extends GetxController {
  final searchController = TextEditingController();
  final searchQuery = ''.obs;
  final subjectsList = <SubjectItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadSampleSubjects();
    searchController.addListener(() {
      searchQuery.value = searchController.text.trim();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void _loadSampleSubjects() {
    subjectsList.assignAll([
      const SubjectItem(
        id: '1',
        title: 'Science',
        subtitle: 'Science • Grade 8',
        status: 'Active',
        iconType: 'science',
        teacherName: 'Dr. S. Miller',
        teacherAvatars: ['assets/images/teacher_avatar.png'],
        teacherCount: 1,
        isUnassigned: false,
        lessonsCount: 12,
        studentsCount: 32,
        progress: 0.65,
      ),
      const SubjectItem(
        id: '2',
        title: 'Mathematics',
        subtitle: 'Mathematics • Grade 12',
        status: 'Active',
        iconType: 'math',
        teacherName: '+2 Teachers',
        teacherAvatars: [
          'assets/images/teacher_avatar.png',
          'assets/images/teacher_avatar.png',
        ],
        teacherCount: 2,
        isUnassigned: false,
        lessonsCount: 24,
        studentsCount: 18,
        progress: 0.30,
      ),
      const SubjectItem(
        id: '3',
        title: 'Social Science',
        subtitle: 'Humanities • Grade 10',
        status: 'Draft',
        iconType: 'social_science',
        teacherName: 'Unassigned',
        teacherAvatars: [],
        teacherCount: 0,
        isUnassigned: true,
        lessonsCount: 0,
        studentsCount: 0,
        progress: 0.0,
      ),
    ]);
  }

  List<SubjectItem> get filteredSubjects {
    if (searchQuery.value.isEmpty) {
      return subjectsList;
    }
    final q = searchQuery.value.toLowerCase();
    return subjectsList.where((item) {
      return item.title.toLowerCase().contains(q) ||
          item.subtitle.toLowerCase().contains(q) ||
          item.teacherName.toLowerCase().contains(q);
    }).toList();
  }

  void onAddSubject() {
    Get.snackbar(
      'Add Subject',
      'Create new subject flow',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onSubjectTap(SubjectItem item) {
    Get.toNamed(
      Routes.LESSONS,
      arguments: {
        'id': item.id,
        'title': item.title,
        'subtitle': item.subtitle,
        'lessonsCount': item.lessonsCount,
      },
    );
  }
}
