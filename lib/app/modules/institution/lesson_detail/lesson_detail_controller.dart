import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import 'lesson_detail_model.dart';

class LessonDetailController extends GetxController {
  final lessonData = Rxn<LessonDetailModel>();

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

  void _loadLessonData() {
    final args = Get.arguments as Map<String, dynamic>?;
    final title = args?['title'] as String? ?? 'Cell Structure';
    final subject = args?['subject'] as String? ?? 'Science';
    final grade = args?['grade'] as String? ?? 'Grade 8';

    lessonData.value = LessonDetailModel(
      id: args?['id'] as String? ?? '1',
      title: title,
      subject: subject,
      grade: grade,
      category: 'Biology Fundamentals',
      status: 'Published',
      isVisibleToStudents: true,
      teacherName: 'Dr. S. Miller',
      teacherAvatar: 'assets/images/teacher_avatar.png',
      description:
          'Learn about the basic structure of a cell, including the nucleus, cell membrane, cytoplasm and major organelles.',
      documents: const [
        LessonDocument(
          title: 'Lesson Notes.pdf',
          size: '2.4 MB',
        ),
      ],
      videos: const [
        LessonVideo(
          title: 'Cell Structure — Introduction',
          subtitle: 'Core Concepts • Chapter 1',
          duration: '08:42',
        ),
      ],
      audio: const LessonAudio(
        title: 'Cell Structure Audio Lesson',
        duration: '06:35',
        currentProgress: 0.35,
        currentTime: '02:14',
        remainingTime: '-04:21',
      ),
      images: const [
        LessonImageItem(title: 'Organelles Details'),
        LessonImageItem(title: 'Mitochondria'),
        LessonImageItem(title: 'Nucleus'),
      ],
      quiz: const LessonQuizItem(
        title: 'Cell Structure Quiz',
        subtitle: '10 Questions • Multiple Choice',
        isAttached: true,
      ),
      arExperience: const LessonImmersiveItem(
        title: 'AR Experience: Cell Model',
        actionText: 'VIEW AR',
        isVR: false,
      ),
      vrAsset: const LessonImmersiveItem(
        title: 'VR Asset: 3D Exploration',
        actionText: 'LAUNCH VR',
        isVR: true,
      ),
    );
  }

  void onEditLesson() {
    Get.snackbar(
      'Edit Lesson',
      'Opening lesson editor for ${lessonData.value?.title ?? ""}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onOpenDocument(LessonDocument doc) {
    Get.snackbar(
      'Opening Document',
      doc.title,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onDownloadDocument(LessonDocument doc) {
    Get.snackbar(
      'Downloading',
      '${doc.title} (${doc.size})',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF127FD2),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onPlayVideo(LessonVideo video) {
    Get.snackbar(
      'Playing Video',
      video.title,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void toggleAudioPlay() {
    isAudioPlaying.value = !isAudioPlaying.value;
  }

  void onSeekAudio(double value) {
    audioProgress.value = value;
  }

  void onViewAllImages() {
    Get.snackbar(
      'Gallery',
      'Viewing all lesson images',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onImageTap(LessonImageItem item) {
    Get.snackbar(
      'Image Preview',
      item.title,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onViewQuiz(LessonQuizItem quiz) {
    Get.toNamed(
      Routes.QUIZ,
      arguments: {
        'quizTitle': quiz.title,
        'subject': lessonData.value?.subject ?? 'Science',
        'lessonTitle': lessonData.value?.title ?? 'Cell Structure',
      },
    );
  }

  void onLaunchAR() {
    Get.snackbar(
      'AR Experience',
      'Launching 3D AR Cell Model...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF127FD2),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onLaunchVR() {
    Get.snackbar(
      'VR Experience',
      'Launching VR 3D Exploration...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}
