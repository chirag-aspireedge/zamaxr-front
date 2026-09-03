import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../lessons/teacher_lessons_controller.dart';
import 'teacher_lesson_detail_model.dart';

class TeacherLessonDetailController extends GetxController {
  final lessonData = Rxn<TeacherLessonDetailModel>();

  // Audio Player State
  final isAudioPlaying = false.obs;
  final audioProgress = 0.35.obs;
  final currentAudioTime = '02:14'.obs;
  final remainingAudioTime = '-04:21'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLessonData();
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

  void _loadLessonData() {
    String title = 'Cell Structure';
    String subject = 'Biology';
    String grade = 'Grade 8';
    String category = 'Biology Fundamentals';

    if (Get.arguments != null) {
      if (Get.arguments is TeacherLessonModel) {
        final lesson = Get.arguments as TeacherLessonModel;
        title = lesson.title;
        subject = lesson.subjectChapter.split('•').first.trim();
        category = lesson.subjectChapter;
      } else if (Get.arguments is Map<String, dynamic>) {
        final map = Get.arguments as Map<String, dynamic>;
        title = map['title'] as String? ?? title;
        subject = map['subject'] as String? ?? subject;
        grade = map['grade'] as String? ?? grade;
        category = map['category'] as String? ?? category;
      } else if (Get.arguments is String) {
        title = Get.arguments as String;
      }
    }

    lessonData.value = TeacherLessonDetailModel(
      id: '1',
      title: title,
      subject: subject,
      grade: grade,
      category: category,
      status: 'Published',
      isVisibleToStudents: true,
      teacherName: 'Dr. S. Miller',
      teacherAvatar: 'assets/images/teacher_avatar.png',
      description:
          'Learn about the basic structure of a cell, including the nucleus, cell membrane, cytoplasm and major organelles.',
      documents: const [
        TeacherLessonDocument(
          title: 'Lesson Notes.pdf',
          size: '2.4 MB',
        ),
      ],
      videos: const [
        TeacherLessonVideo(
          title: 'Cell Structure — Introduction',
          subtitle: 'Core Concepts • Chapter 1',
          duration: '08:42',
        ),
      ],
      audio: const TeacherLessonAudio(
        title: 'Cell Structure Audio Lesson',
        duration: '06:35',
        currentProgress: 0.35,
        currentTime: '02:14',
        remainingTime: '-04:21',
      ),
      images: const [
        TeacherLessonImageItem(title: 'Organelles Details'),
        TeacherLessonImageItem(title: 'Mitochondria'),
        TeacherLessonImageItem(title: 'Nucleus'),
      ],
      quiz: const TeacherLessonQuizItem(
        title: 'Cell Structure Quiz',
        subtitle: '10 Questions • Multiple Choice',
        isAttached: true,
      ),
      arExperience: const TeacherLessonImmersiveItem(
        title: 'AR Experience: Cell Model',
        actionText: 'VIEW AR',
        isVR: false,
      ),
      vrAsset: const TeacherLessonImmersiveItem(
        title: 'VR Asset: 3D Exploration',
        actionText: 'LAUNCH VR',
        isVR: true,
      ),
    );
  }

  void onBack() {
    Get.back();
  }

  void onEditLesson() {
    Get.toNamed(
      Routes.TEACHER_EDIT_LESSON,
      arguments: lessonData.value,
    );
  }

  void onOpenDocument(TeacherLessonDocument doc) {
    _showNotice('Opening Document', doc.title);
  }

  void onDownloadDocument(TeacherLessonDocument doc) {
    _showNotice(
      'Downloading',
      '${doc.title} (${doc.size})',
      bgColor: const Color(0xFF127FD2),
    );
  }

  void onPlayVideo(TeacherLessonVideo video) {
    _showNotice('Playing Video', video.title);
  }

  void toggleAudioPlay() {
    isAudioPlaying.value = !isAudioPlaying.value;
  }

  void onSeekAudio(double value) {
    audioProgress.value = value;
  }

  void onViewAllImages() {
    _showNotice('Gallery', 'Viewing all lesson images');
  }

  void onImageTap(TeacherLessonImageItem item) {
    _showNotice('Image Preview', item.title);
  }

  void onAddNewQuiz() {
    Get.toNamed(
      Routes.TEACHER_CREATE_QUIZ,
      arguments: {
        'isNew': true,
        'subject': lessonData.value?.subject ?? 'Biology',
        'lessonTitle': lessonData.value?.title ?? 'Cell Structure',
      },
    );
  }

  void onViewQuiz(TeacherLessonQuizItem quiz) {
    Get.toNamed(
      Routes.TEACHER_CREATE_QUIZ,
      arguments: {
        'quizTitle': quiz.title,
        'subject': lessonData.value?.subject ?? 'Biology',
        'lessonTitle': lessonData.value?.title ?? 'Cell Structure',
      },
    );
  }

  void onLaunchAR() {
    _showNotice('AR Experience', 'Launching 3D AR Cell Model...', bgColor: const Color(0xFF127FD2));
  }

  void onLaunchVR() {
    _showNotice('VR Experience', 'Launching VR 3D Exploration...', bgColor: const Color(0xFF0E3856));
  }
}
