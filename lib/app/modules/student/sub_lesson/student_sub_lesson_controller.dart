import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class StudentSubLessonController extends GetxController {
  // Reactive states
  final currentLessonIndex = 4.obs;
  final totalLessons = 8.obs;
  final isOfflineAvailable = true.obs;
  final progress = 0.5.obs; // 50%

  final title = 'Human Cell Structure'.obs;
  final subject = 'Biology Fundamentals'.obs;

  final sectionTitle = 'Organelles Overview'.obs;
  final sectionContent =
      'Cells are the fundamental structural and functional units of all living organisms. Within the human cell, various specialized structures known as organelles perform distinct functions necessary for survival. Key organelles include the nucleus, which houses genetic material, and mitochondria, responsible for energy production.'
          .obs;

  final videoTitle = 'Video: Deep Dive into Cellular Functions'.obs;
  final videoDuration = '4:32 • Reference Material'.obs;
  final isVideoPlaying = false.obs;

  void onBackTap() {
    Get.back();
  }

  void onAskAiTutor() {
    Get.toNamed(Routes.STUDENT_AI_TUTOR);
  }

  void onPlayVideo() {
    isVideoPlaying.value = !isVideoPlaying.value;
    if (Get.context != null) {
      Get.snackbar(
        isVideoPlaying.value ? 'Playing Video' : 'Video Paused',
        videoTitle.value,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onPreviousLesson() {
    if (currentLessonIndex.value > 1) {
      currentLessonIndex.value--;
      progress.value = currentLessonIndex.value / totalLessons.value;
      if (Get.context != null) {
        Get.snackbar(
          'Previous Lesson',
          'Navigated to Lesson ${currentLessonIndex.value} of ${totalLessons.value}',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } else {
      if (Get.context != null) {
        Get.snackbar(
          'First Lesson',
          'You are at the first lesson of this module.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }

  void onNextLesson() {
    if (currentLessonIndex.value < totalLessons.value) {
      currentLessonIndex.value++;
      progress.value = currentLessonIndex.value / totalLessons.value;
      if (Get.context != null) {
        Get.snackbar(
          'Next Lesson',
          'Navigated to Lesson ${currentLessonIndex.value} of ${totalLessons.value}',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } else {
      if (Get.context != null) {
        Get.snackbar(
          'Completed',
          'You have reached the end of this module! Well done.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }
}
