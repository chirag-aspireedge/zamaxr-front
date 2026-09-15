import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';

class VrExperienceItem {
  final String id;
  final String subject;
  final String title;
  final String duration;
  final String description;
  final String imagePath;
  final String qualityBadge;
  final RxBool isDownloaded;
  final RxBool isDownloading;
  final RxDouble downloadProgress;
  final String downloadSize;

  VrExperienceItem({
    required this.id,
    required this.subject,
    required this.title,
    required this.duration,
    required this.description,
    required this.imagePath,
    this.qualityBadge = 'VR READY',
    bool isDownloaded = false,
    this.downloadSize = '1.2 GB',
  })  : isDownloaded = isDownloaded.obs,
        isDownloading = false.obs,
        downloadProgress = 0.0.obs;
}

class StudentVrVideosController extends GetxController {
  final vrExperiences = <VrExperienceItem>[].obs;
  final isVrHeadsetModalOpen = false.obs;
  final activeExperience = Rxn<VrExperienceItem>();

  // VR playback simulation states
  final isPlaying = true.obs;
  final playbackProgress = 0.35.obs;
  final isDualEyeMode = false.obs;
  final isGyroscopeActive = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadVrExperiences();
  }

  void _loadVrExperiences() {
    vrExperiences.assignAll([
      VrExperienceItem(
        id: 'vr_heart',
        subject: 'BIOLOGY',
        title: 'Journey Inside the Human Heart',
        duration: '8 min',
        description:
            'Explore the chambers and blood flow of the human heart in an immersive VR…',
        imagePath: AppAssets.studentVrHumanHeart,
        isDownloaded: true,
        downloadSize: '1.2 GB',
      ),
      VrExperienceItem(
        id: 'vr_solar',
        subject: 'SCIENCE',
        title: 'Solar System Exploration',
        duration: '10 min',
        description:
            'Travel through the solar system and explore the planets.',
        imagePath: AppAssets.studentVrSolarSystem,
        isDownloaded: false,
        downloadSize: '2.4 GB',
      ),
      VrExperienceItem(
        id: 'vr_pyramid',
        subject: 'HISTORY',
        title: 'The Great Pyramid of Giza',
        duration: '12 min',
        description:
            'Walk through the hidden chambers of the Great Pyramid.',
        imagePath: AppAssets.studentVrPyramids,
        isDownloaded: false,
        downloadSize: '1.8 GB',
      ),
    ]);
  }

  void onBackTap() {
    Get.back();
  }

  void onDownloadTap(VrExperienceItem item) {
    if (item.isDownloading.value) return;

    if (item.isDownloaded.value) {
      Get.snackbar(
        'Downloaded',
        '${item.title} is already available offline.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF0E3856),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    item.isDownloading.value = true;
    item.downloadProgress.value = 0.0;

    // Simulate fast downloading progress
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 250));
      if (!item.isDownloading.value) return false;
      item.downloadProgress.value += 0.2;
      if (item.downloadProgress.value >= 1.0) {
        item.downloadProgress.value = 1.0;
        item.isDownloading.value = false;
        item.isDownloaded.value = true;
        Get.snackbar(
          'Download Complete',
          '${item.title} ready for offline VR experience.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF0059BB),
          colorText: Colors.white,
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
          duration: const Duration(seconds: 2),
        );
        return false;
      }
      return true;
    });
  }

  void onExperienceInVr(VrExperienceItem item) {
    activeExperience.value = item;
    isPlaying.value = true;
    playbackProgress.value = 0.15;
    isVrHeadsetModalOpen.value = true;
  }

  void closeVrModal() {
    isVrHeadsetModalOpen.value = false;
    activeExperience.value = null;
  }

  void togglePlayPause() {
    isPlaying.value = !isPlaying.value;
  }

  void toggleDualEyeMode() {
    isDualEyeMode.value = !isDualEyeMode.value;
  }

  void toggleGyroscope() {
    isGyroscopeActive.value = !isGyroscopeActive.value;
  }
}
