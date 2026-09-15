import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class OrganelleInfo {
  final String name;
  final String role;
  final String description;

  const OrganelleInfo({
    required this.name,
    required this.role,
    required this.description,
  });
}

class StudentArLearningController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController scanAnimationController;
  late Animation<double> scanAnimation;

  final RxBool isScanning = false.obs;
  final RxBool isScanned = false.obs;
  final RxBool isFlashOn = false.obs;
  final RxString selectedOrganelle = 'Nucleus'.obs;

  final List<OrganelleInfo> organelles = const [
    OrganelleInfo(
      name: 'Nucleus',
      role: 'Control Center of the Cell',
      description:
          'Houses the cell\'s genetic code (DNA) and directs synthesis of ribosomes and proteins.',
    ),
    OrganelleInfo(
      name: 'Mitochondria',
      role: 'Powerhouse of the Cell',
      description:
          'Generates most of the chemical energy needed to power the cell\'s biochemical reactions via ATP.',
    ),
    OrganelleInfo(
      name: 'Golgi Apparatus',
      role: 'Packaging & Shipping',
      description:
          'Modifies, sorts, and packages proteins and lipids for secretion or delivery to other organelles.',
    ),
    OrganelleInfo(
      name: 'Endoplasmic Reticulum',
      role: 'Manufacturing Hub',
      description:
          'A continuous membrane system that plays an essential role in protein folding and transport.',
    ),
    OrganelleInfo(
      name: 'Cytoplasm',
      role: 'Fluid Cell Matrix',
      description:
          'A jelly-like fluid that fills the cell and suspends the organelles, providing shape and support.',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    scanAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: scanAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void toggleFlash() {
    isFlashOn.value = !isFlashOn.value;
  }

  void scanPage() async {
    if (isScanning.value) return;
    isScanning.value = true;

    // Simulate scanning processing
    await Future.delayed(const Duration(milliseconds: 1400));
    isScanning.value = false;
    isScanned.value = true;
  }

  void resetScan() {
    isScanned.value = false;
  }

  void onBackTap() {
    if (isScanned.value) {
      isScanned.value = false;
    } else {
      Get.back();
    }
  }

  void selectOrganelle(String name) {
    selectedOrganelle.value = name;
  }

  void showHelpModal(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'AR Scanning Tips',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF191C1D),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildHelpItem(
              icon: Icons.crop_free_rounded,
              title: 'Frame the whole diagram',
              subtitle: 'Ensure all 4 corners of the diagram are visible in the viewfinder.',
            ),
            const SizedBox(height: 12),
            _buildHelpItem(
              icon: Icons.wb_sunny_outlined,
              title: 'Avoid shadows & glare',
              subtitle: 'Position your device perpendicular to the page in good lighting.',
            ),
            const SizedBox(height: 12),
            _buildHelpItem(
              icon: Icons.motion_photos_paused_outlined,
              title: 'Hold steady for 1 second',
              subtitle: 'The AI Tutor recognizes diagrams instantly once aligned.',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void onAskAiTutorTap([String? organelleName]) {
    Get.toNamed(
      Routes.STUDENT_AI_TUTOR,
      arguments: {
        'topic': 'Cell Structure',
        'initialPrompt': organelleName != null
            ? 'What is the ${organelleName.toLowerCase()}?'
            : 'What is the mitochondria?',
      },
    );
  }

  Widget _buildHelpItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFFE8F2FD),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF0059BB)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF414754),
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void onClose() {
    scanAnimationController.dispose();
    super.onClose();
  }
}
