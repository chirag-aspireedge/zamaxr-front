import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class RecommendedModuleItem {
  final String category;
  final String categoryColor; // green, blue, amber
  final String categoryBg;
  final String categoryBorder;
  final String typeTag;
  final String title;
  final String description;
  final String duration;
  final String actionLabel;
  final VoidCallback onTap;

  const RecommendedModuleItem({
    required this.category,
    required this.categoryColor,
    required this.categoryBg,
    required this.categoryBorder,
    required this.typeTag,
    required this.title,
    required this.description,
    required this.duration,
    required this.actionLabel,
    required this.onTap,
  });
}

class WhatNewItem {
  final String title;
  final String badge;
  final String description;
  final IconData icon;
  final Color iconColor;
  final Color iconBg;

  const WhatNewItem({
    required this.title,
    required this.badge,
    required this.description,
    required this.icon,
    required this.iconColor,
    required this.iconBg,
  });
}

class IndividualHomeController extends GetxController {
  final RxString userName = 'Alex'.obs;
  final RxString selectedRegion = 'West Africa • Nigeria'.obs;
  final RxInt streakDays = 7.obs;
  final RxInt rewardsTokens = 245.obs;
  final RxInt currentNavIndex = 0.obs;
  final RxBool isLowBandwidth = false.obs;

  final List<String> availableRegions = const [
    'West Africa • Nigeria',
    'West Africa • Ghana',
    'East Africa • Kenya',
    'Southern Africa • South Africa',
    'North Africa • Egypt',
    'Global STEM Curriculum',
  ];

  late final List<RecommendedModuleItem> recommendedModules;

  @override
  void onInit() {
    super.onInit();
    _initRecommendedModules();
  }

  void _initRecommendedModules() {
    recommendedModules = [
      RecommendedModuleItem(
        category: 'Regional STEM',
        categoryColor: '#047857',
        categoryBg: '#ECFDF5',
        categoryBorder: '#A7F3D0',
        typeTag: '3D Module',
        title: 'Photosynthesis & Tropical Flora',
        description:
            'Regional biology modules contextualized with West African rainforest flora and plant systems.',
        duration: '15 mins',
        actionLabel: 'Start',
        onTap: () {
          Get.toNamed(Routes.STUDENT_LESSON_DETAIL);
        },
      ),
      RecommendedModuleItem(
        category: 'E-mmerX Training',
        categoryColor: '#127FD2',
        categoryBg: '#EFF6FF',
        categoryBorder: '#BFDBFE',
        typeTag: 'Self-Paced',
        title: 'Digital Literacy & Tech Skills',
        description:
            'Foundation course on emerging tech tailored for students and young creators across West Africa.',
        duration: 'Cert. Included',
        actionLabel: 'View',
        onTap: () {
          openEmmerxeduWebView();
        },
      ),
      RecommendedModuleItem(
        category: 'Applied Science',
        categoryColor: '#B45309',
        categoryBg: '#FFFBEB',
        categoryBorder: '#FDE68A',
        typeTag: 'VR Ready',
        title: 'Clean Energy & Solar Grids',
        description:
            'Hands-on interactive 3D physics lab simulating sub-Saharan renewable energy and microgrid models.',
        duration: '20 mins',
        actionLabel: 'Explore',
        onTap: () {
          Get.toNamed(Routes.STUDENT_VR_VIDEOS);
        },
      ),
    ];
  }

  void onSelectRegion(String region) {
    selectedRegion.value = region;
    Get.back();
    Get.snackbar(
      'Curriculum Updated',
      'Switched regional modules to $region',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0A2540),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void onSearchTap() {
    Get.toNamed(Routes.STUDENT_SEARCH);
  }

  void onExploreArVr() {
    Get.toNamed(Routes.STUDENT_AR_LEARNING);
  }

  void onOpenAiTutor() {
    Get.toNamed(Routes.STUDENT_AI_TUTOR);
  }

  void onOpenMathSolver() {
    Get.toNamed(Routes.STUDENT_MATH_SOLVER);
  }

  void onOpenQuiz() {
    Get.toNamed(Routes.STUDENT_QUIZ);
  }

  void onOpenRewards() {
    currentNavIndex.value = 2;
  }

  void openEmmerxeduWebView() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F6FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.language_rounded,
                    color: Color(0xFF127FD2),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'e-mmerxedu.com',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0A2540),
                      ),
                    ),
                    Text(
                      'In-App Web Course Portal',
                      style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Access digital literacy, vocational certifications, and self-paced regional training powered by the E-mmerxedu learning network.',
              style: TextStyle(fontSize: 13, color: Color(0xFF475569), height: 1.4),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.back();
                  Get.toNamed(Routes.STUDENT_SELF_PACED);
                },
                icon: const Icon(Icons.open_in_new_rounded, color: Colors.white, size: 18),
                label: const Text(
                  'Launch Portal',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127FD2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void onOpenProfile() {
    currentNavIndex.value = 3;
  }

  void onOpenNotifications() {
    Get.toNamed(Routes.NOTIFICATIONS);
  }

  void toggleLowBandwidth() {
    isLowBandwidth.value = !isLowBandwidth.value;
    Get.snackbar(
      isLowBandwidth.value ? 'Low-Bandwidth Mode On' : 'Standard Quality Mode',
      isLowBandwidth.value
          ? '3D models compressed for offline & slow connections'
          : 'High fidelity 3D and VR simulations enabled',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0A2540),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
