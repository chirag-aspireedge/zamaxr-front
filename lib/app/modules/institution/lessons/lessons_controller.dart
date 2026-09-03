import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import 'lessons_model.dart';

class LessonsController extends GetxController {
  final searchController = TextEditingController();
  final searchQuery = ''.obs;

  final subjectTitle = 'Science'.obs;
  final gradeText = 'Grade 8'.obs;
  final totalLessonsCount = 12.obs;

  final lessonsList = <LessonItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
    _loadSampleLessons();
    searchController.addListener(() {
      searchQuery.value = searchController.text.trim();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void _loadArguments() {
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      if (args['title'] != null) subjectTitle.value = args['title'];
      if (args['subtitle'] != null) {
        // e.g. "Science • Grade 8" -> parse "Grade 8" if present
        final sub = args['subtitle'] as String;
        if (sub.contains('•')) {
          gradeText.value = sub.split('•').last.trim();
        } else {
          gradeText.value = sub;
        }
      }
      if (args['lessonsCount'] != null && args['lessonsCount'] is int) {
        totalLessonsCount.value = args['lessonsCount'];
      }
    }
  }

  void _loadSampleLessons() {
    lessonsList.assignAll([
      const LessonItem(
        id: '1',
        lessonNumber: 'LESSON 01',
        title: 'Cell Structure',
        chapter: 'Chapter 1',
        duration: '15 min',
        status: 'PUBLISHED',
        mediaTypes: [
          LessonMediaType.pdf,
          LessonMediaType.video,
          LessonMediaType.audio,
          LessonMediaType.quiz,
        ],
      ),
      const LessonItem(
        id: '2',
        lessonNumber: 'LESSON 02',
        title: 'Human Digestive\nSystem',
        chapter: 'Chapter 2',
        duration: '20 min',
        status: 'PUBLISHED',
        mediaTypes: [
          LessonMediaType.pdf,
          LessonMediaType.video,
          LessonMediaType.cube3d,
          LessonMediaType.quiz,
        ],
      ),
      const LessonItem(
        id: '3',
        lessonNumber: 'LESSON 03',
        title: 'Photosynthesis',
        chapter: 'Chapter 3',
        duration: '12 min',
        status: 'DRAFT',
        mediaTypes: [
          LessonMediaType.pdf,
          LessonMediaType.video,
        ],
      ),
    ]);
  }

  List<LessonItem> get filteredLessons {
    if (searchQuery.value.isEmpty) {
      return lessonsList;
    }
    final q = searchQuery.value.toLowerCase();
    return lessonsList.where((item) {
      return item.title.toLowerCase().contains(q) ||
          item.lessonNumber.toLowerCase().contains(q) ||
          item.chapter.toLowerCase().contains(q) ||
          item.status.toLowerCase().contains(q);
    }).toList();
  }

  void onMoreMenuTap() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFE3E3E3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.add_circle_outline, color: Color(0xFF127FD2)),
                title: const Text('Add New Lesson'),
                onTap: () {
                  Get.back();
                  Get.snackbar(
                    'Add Lesson',
                    'Opening lesson creator...',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF0E3856),
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                    borderRadius: 12,
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.edit_outlined, color: Color(0xFF335E7D)),
                title: const Text('Edit Subject Info'),
                onTap: () => Get.back(),
              ),
              ListTile(
                leading: const Icon(Icons.share_outlined, color: Color(0xFF335E7D)),
                title: const Text('Share Subject'),
                onTap: () => Get.back(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLessonTap(LessonItem item) {
    Get.toNamed(
      Routes.LESSON_DETAIL,
      arguments: {
        'id': item.id,
        'title': item.title.replaceAll('\n', ' '),
        'subject': subjectTitle.value,
        'grade': gradeText.value,
        'lessonNumber': item.lessonNumber,
        'chapter': item.chapter,
        'duration': item.duration,
        'status': item.status,
      },
    );
  }

  void onMediaTap(LessonItem item, LessonMediaType type) {
    Get.snackbar(
      'Media Action',
      'Opening ${type.name.toUpperCase()} for ${item.title.replaceAll('\n', ' ')}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}
