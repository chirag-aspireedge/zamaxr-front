import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../lesson_detail/teacher_lesson_detail_controller.dart';
import '../lesson_detail/teacher_lesson_detail_model.dart';
import '../lessons/teacher_lessons_controller.dart';

class EditLessonController extends GetxController {
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

  String? editingLessonId;

  @override
  void onInit() {
    super.onInit();
    _populateLessonData();
  }

  void _populateLessonData() {
    if (Get.arguments != null) {
      if (Get.arguments is TeacherLessonDetailModel) {
        final detail = Get.arguments as TeacherLessonDetailModel;
        editingLessonId = detail.id;
        titleController.text = detail.title;
        descriptionController.text = detail.description;
        notesController.text =
            '• Detailed study notes covering structure, organelles and cellular metabolism.\n• Preparation guidelines for the upcoming chapter test.';
        selectedClass.value = detail.grade.isEmpty ? 'Class 8-A' : detail.grade;
        selectedSubject.value = detail.subject.isEmpty ? 'Biology' : detail.subject;
        hasUploadedVideo.value = detail.videos.isNotEmpty;
        videoUrlController.text = detail.videos.isNotEmpty ? 'https://youtube.com/watch?v=cell_structure_01' : '';
        isVisibleToStudents.value = detail.isVisibleToStudents;
        return;
      } else if (Get.arguments is TeacherLessonModel) {
        final model = Get.arguments as TeacherLessonModel;
        editingLessonId = model.id;
        titleController.text = model.title;
        descriptionController.text =
            'Comprehensive curriculum lesson covering core concepts and interactive models for ${model.title}.';
        notesController.text = 'Study notes and guidelines for ${model.title}.';
        final parts = model.subjectChapter.split('•');
        if (parts.isNotEmpty) {
          selectedSubject.value = parts.first.trim();
        }
        selectedClass.value = 'Class 8-A';
        hasUploadedVideo.value = true;
        videoUrlController.text = 'https://youtube.com/watch?v=lesson_lecture';
        isVisibleToStudents.value = model.status.toLowerCase() == 'published';
        return;
      } else if (Get.arguments is Map<String, dynamic>) {
        final map = Get.arguments as Map<String, dynamic>;
        titleController.text = map['title'] as String? ?? 'Cell Structure';
        descriptionController.text = map['description'] as String? ?? '';
        notesController.text = map['notes'] as String? ?? '';
        selectedClass.value = map['class'] as String? ?? 'Class 8-A';
        selectedSubject.value = map['subject'] as String? ?? 'Biology';
        return;
      }
    }

    // Default prefilled data for Cell Structure
    titleController.text = 'Cell Structure';
    descriptionController.text =
        'Learn about the basic structure of a cell, including the nucleus, cell membrane, cytoplasm and major organelles.';
    notesController.text =
        '• Detailed study notes covering structure, organelles and cellular metabolism.\n• Review all diagram illustrations prior to class quiz.';
    selectedClass.value = 'Class 8-A';
    selectedSubject.value = 'Biology';
    hasUploadedVideo.value = true;
    videoUrlController.text = 'https://youtube.com/watch?v=cell_structure_01';
    isVisibleToStudents.value = true;
  }

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
    _showNotice('Upload Documents', 'Attach study materials or PDF notes');
  }

  void onUploadImages() {
    _showNotice('Upload Images', 'Attach diagrams or illustrations');
  }

  void onUploadAudio() {
    _showNotice('Upload Audio', 'Attach audio lecture or narration');
  }

  void onAssessments() {
    Get.toNamed(
      Routes.TEACHER_CREATE_QUIZ,
      arguments: {
        'isNew': false,
        'subject': selectedSubject.value,
        'lessonTitle': titleController.text,
      },
    );
  }

  void onAddVideo() {
    final url = videoUrlController.text.trim();
    if (url.isEmpty) {
      _showNotice('Notice', 'Please paste a valid video URL');
      return;
    }
    hasUploadedVideo.value = true;
    _showNotice('Video Updated', 'Video link was updated for this lesson', bgColor: const Color(0xFF127FD2));
  }

  void onRemoveVideo() {
    hasUploadedVideo.value = false;
    videoUrlController.clear();
    _showNotice('Video Removed', 'Video was removed from this lesson');
  }

  void toggleVisibility(bool value) {
    isVisibleToStudents.value = value;
  }

  void onSaveLesson() {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      _showNotice('Missing Title', 'Lesson title cannot be empty');
      return;
    }

    // Update in TeacherLessonDetailController if open
    if (Get.isRegistered<TeacherLessonDetailController>()) {
      final detailCtrl = Get.find<TeacherLessonDetailController>();
      if (detailCtrl.lessonData.value != null) {
        final current = detailCtrl.lessonData.value!;
        detailCtrl.lessonData.value = TeacherLessonDetailModel(
          id: current.id,
          title: title,
          subject: selectedSubject.value,
          grade: selectedClass.value,
          category: '${selectedSubject.value} Fundamentals',
          status: isVisibleToStudents.value ? 'Published' : 'Draft',
          isVisibleToStudents: isVisibleToStudents.value,
          teacherName: current.teacherName,
          teacherAvatar: current.teacherAvatar,
          description: descriptionController.text.trim(),
          documents: current.documents,
          videos: current.videos,
          audio: current.audio,
          images: current.images,
          quiz: current.quiz,
          arExperience: current.arExperience,
          vrAsset: current.vrAsset,
        );
      }
    }

    // Update in TeacherLessonsController list if open
    if (Get.isRegistered<TeacherLessonsController>()) {
      final lessonsCtrl = Get.find<TeacherLessonsController>();
      final index = lessonsCtrl.allLessons.indexWhere(
        (l) => l.id == editingLessonId || l.title.toLowerCase() == title.toLowerCase(),
      );
      if (index != -1) {
        final existing = lessonsCtrl.allLessons[index];
        lessonsCtrl.allLessons[index] = TeacherLessonModel(
          id: existing.id,
          title: title,
          subjectChapter: '${selectedSubject.value} • ${selectedClass.value}',
          status: isVisibleToStudents.value ? 'Published' : 'Draft',
          updatedTime: 'Updated just now',
          imageAsset: existing.imageAsset,
        );
      }
    }

    _showNotice(
      'Changes Saved',
      'Lesson "$title" was updated successfully!',
      bgColor: const Color(0xFF127FD2),
    );

    Get.back();
  }
}

typedef TeacherEditLessonController = EditLessonController;
