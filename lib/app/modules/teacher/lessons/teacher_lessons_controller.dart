import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';

class TeacherLessonModel {
  final String id;
  final String subjectChapter;
  final String title;
  final String updatedTime;
  final String status; // 'Published', 'Draft', 'Archived'
  final String imageAsset;

  const TeacherLessonModel({
    required this.id,
    required this.subjectChapter,
    required this.title,
    required this.updatedTime,
    required this.status,
    required this.imageAsset,
  });
}

class TeacherLessonsController extends GetxController {
  final TextEditingController searchController = TextEditingController();

  final List<String> filterTabs = ['All', 'Draft', 'Published', 'Archived'];
  final RxString selectedFilter = 'All'.obs;
  final RxString searchQuery = ''.obs;

  final RxList<TeacherLessonModel> allLessons = <TeacherLessonModel>[
    const TeacherLessonModel(
      id: '1',
      subjectChapter: 'Physics • Ch 4',
      title: 'Intro to Quantum Physics',
      updatedTime: 'Updated 2 days ago',
      status: 'Published',
      imageAsset: AppAssets.lessonThumbQuantum,
    ),
    const TeacherLessonModel(
      id: '2',
      subjectChapter: 'History • Unit 2',
      title: 'The Roman Empire',
      updatedTime: 'Updated yesterday',
      status: 'Draft',
      imageAsset: AppAssets.lessonThumbRoman,
    ),
    const TeacherLessonModel(
      id: '3',
      subjectChapter: 'Biology • Ch 7',
      title: 'Cellular Respiration',
      updatedTime: 'Updated 5 days ago',
      status: 'Published',
      imageAsset: AppAssets.lessonThumbRespiration,
    ),
  ].obs;

  List<TeacherLessonModel> get filteredLessons {
    return allLessons.where((lesson) {
      final matchesFilter = selectedFilter.value == 'All' ||
          lesson.status.toLowerCase() == selectedFilter.value.toLowerCase();
      final query = searchQuery.value.trim().toLowerCase();
      final matchesQuery = query.isEmpty ||
          lesson.title.toLowerCase().contains(query) ||
          lesson.subjectChapter.toLowerCase().contains(query);
      return matchesFilter && matchesQuery;
    }).toList();
  }

  void setFilter(String tab) {
    selectedFilter.value = tab;
  }

  void onSearch(String query) {
    searchQuery.value = query;
  }

  void onBack() {
    Get.back();
  }

  void onNotifications() {
    Get.toNamed(Routes.NOTIFICATIONS);
  }

  void onLessonMenu(TeacherLessonModel lesson) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF131B2E),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.edit_outlined, color: Color(0xFF127FD2)),
              title: const Text('Edit Lesson'),
              onTap: () {
                Get.back();
                Get.toNamed(
                  Routes.TEACHER_EDIT_LESSON,
                  arguments: lesson,
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share_outlined, color: Color(0xFF0E3856)),
              title: const Text('Share Lesson'),
              onTap: () => Get.back(),
            ),
            ListTile(
              leading: const Icon(Icons.archive_outlined, color: Color(0xFF767683)),
              title: const Text('Archive Lesson'),
              onTap: () => Get.back(),
            ),
          ],
        ),
      ),
    );
  }

  void onLessonTap(TeacherLessonModel lesson) {
    Get.toNamed(Routes.TEACHER_LESSON_DETAIL, arguments: lesson);
  }

  void onContinue() {
    Get.toNamed(Routes.TEACHER_LESSON_DETAIL);
  }

  void onCreateLesson() {
    Get.toNamed(Routes.TEACHER_CREATE_LESSON);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
