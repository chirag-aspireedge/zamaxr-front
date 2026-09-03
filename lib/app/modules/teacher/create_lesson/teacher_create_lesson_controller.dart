import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../lessons/teacher_lessons_controller.dart';

class TeacherCreateLessonController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final notesController = TextEditingController();
  final videoUrlController = TextEditingController();

  final selectedClass = 'Class 8-A'.obs;
  final selectedSubject = 'Biology'.obs;

  final hasUploadedVideo = true.obs;
  final isVisibleToStudents = true.obs;

  final availableClasses = const ['Class 8-A', 'Class 8-B', 'Class 9-A', 'Class 9-B', 'Class 10-A'];
  final availableSubjects = const ['Biology', 'Physics', 'Chemistry', 'Mathematics', 'History'];

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    notesController.dispose();
    videoUrlController.dispose();
    super.onClose();
  }

  void _showNotice(String title, String message, {Color? bgColor}) {
    if (Get.testMode) return;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: bgColor ?? const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onBack() {
    Get.back();
  }

  void onSelectClass() {
    if (Get.context == null) return;
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
            const Text(
              'Select Class',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 12),
            ...availableClasses.map(
              (cls) => ListTile(
                title: Text(cls),
                trailing: selectedClass.value == cls
                    ? const Icon(Icons.check_circle, color: Color(0xFF127FD2))
                    : null,
                onTap: () {
                  selectedClass.value = cls;
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelectSubject() {
    if (Get.context == null) return;
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
            const Text(
              'Select Subject',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 12),
            ...availableSubjects.map(
              (subj) => ListTile(
                title: Text(subj),
                trailing: selectedSubject.value == subj
                    ? const Icon(Icons.check_circle, color: Color(0xFF127FD2))
                    : null,
                onTap: () {
                  selectedSubject.value = subj;
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onUploadDocuments() {
    _showNotice('Upload Documents', 'Select study materials or PDF notes to attach');
  }

  void onUploadImages() {
    _showNotice('Upload Images', 'Select diagrams or illustrations to attach');
  }

  void onUploadAudio() {
    _showNotice('Upload Audio', 'Select voice recordings or narration to attach');
  }

  void onAddAssessments() {
    Get.toNamed(
      Routes.TEACHER_CREATE_QUIZ,
      arguments: {
        'isNew': true,
        'subject': selectedSubject.value,
        'lessonTitle': titleController.text.isEmpty ? 'New Lesson' : titleController.text,
      },
    );
  }

  void onAddVideo() {
    final url = videoUrlController.text.trim();
    if (url.isEmpty) {
      _showNotice('Notice', 'Please paste a valid video link');
      return;
    }
    hasUploadedVideo.value = true;
    _showNotice('Video Added', 'Video successfully linked to lesson', bgColor: const Color(0xFF127FD2));
  }

  void onRemoveVideo() {
    hasUploadedVideo.value = false;
    videoUrlController.clear();
    _showNotice('Video Removed', 'Video link was removed from this lesson');
  }

  void toggleVisibility(bool value) {
    isVisibleToStudents.value = value;
  }

  void onCreateLesson() {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      _showNotice('Missing Title', 'Please enter a lesson title before creating');
      return;
    }

    if (Get.isRegistered<TeacherLessonsController>()) {
      final lessonsCtrl = Get.find<TeacherLessonsController>();
      final newLesson = TeacherLessonModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        subjectChapter: '${selectedSubject.value} • ${selectedClass.value}',
        status: isVisibleToStudents.value ? 'Published' : 'Draft',
        updatedTime: 'Just now',
        imageAsset: 'assets/images/lesson_thumb_quantum.png',
      );
      lessonsCtrl.allLessons.insert(0, newLesson);
    }

    _showNotice(
      'Lesson Created',
      'Lesson "$title" created successfully!',
      bgColor: const Color(0xFF127FD2),
    );

    Get.back();
  }
}
