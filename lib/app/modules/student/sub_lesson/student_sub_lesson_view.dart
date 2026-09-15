import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';
import 'student_sub_lesson_controller.dart';

class StudentSubLessonView extends GetView<StudentSubLessonController> {
  const StudentSubLessonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: _buildTopBar(),
            ),
            // Scrollable Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                physics: const BouncingScrollPhysics(),
                children: [
                  // Progress Indicator & Status Row
                  _buildProgressAndStatusSection(),
                  const SizedBox(height: 18),
                  // Lesson Title & Subject
                  _buildLessonHeader(),
                  const SizedBox(height: 16),
                  // 3D Illustration Card
                  _buildHeroIllustration(),
                  const SizedBox(height: 24),
                  // Section Overview & Body Text
                  _buildContentSection(),
                  const SizedBox(height: 20),
                  // Ask AI Tutor Button
                  _buildAskAiTutorButton(),
                  const SizedBox(height: 24),
                  // Educational Video Card
                  _buildVideoCard(),
                  const SizedBox(height: 28),
                  // Previous & Next Navigation Buttons
                  _buildBottomNavigationButtons(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        // Circular Back Button
        GestureDetector(
          onTap: controller.onBackTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F5),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(
              PhosphorIcons.arrowLeft(PhosphorIconsStyle.bold),
              size: 20,
              color: const Color(0xFF191C1D),
            ),
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Text(
            'Lesson Viewer',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191C1D),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressAndStatusSection() {
    return Obx(() {
      final current = controller.currentLessonIndex.value;
      final total = controller.totalLessons.value;
      final progress = controller.progress.value;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row: "LESSON 4 OF 8" + "Offline Available" Pill
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'LESSON $current OF $total',
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.6,
                  color: Color(0xFF414754),
                ),
              ),
              // Offline Available Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF0E3856),
                  borderRadius: BorderRadius.circular(9999),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 31, 63, 0.05),
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      PhosphorIcons.checkCircle(PhosphorIconsStyle.fill),
                      size: 13,
                      color: const Color(0xFFF6FEFF),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Offline Available',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFF6FEFF),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // 6px Pill Progress Track
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFFE1E3E4),
              valueColor: const AlwaysStoppedAnimation<Color>(
                Color(0xFF127FD2),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget _buildLessonHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(
              controller.title.value,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 22,
                fontWeight: FontWeight.w700,
                height: 1.25,
                color: Color(0xFF191C1D),
              ),
            )),
        const SizedBox(height: 4),
        Obx(() => Text(
              controller.subject.value,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF414754),
              ),
            )),
      ],
    );
  }

  Widget _buildHeroIllustration() {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.STUDENT_AR_LEARNING),
      child: Container(
        width: double.infinity,
        height: 192,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.08),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                AppAssets.studentCellStructureHero,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF0A2540),
                    alignment: Alignment.center,
                    child: Icon(
                      PhosphorIcons.atom(PhosphorIconsStyle.duotone),
                      size: 64,
                      color: const Color(0xFF56B9E3),
                    ),
                  );
                },
              ),
              // Soft gradient scrim at bottom
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.0, 0.45],
                    colors: [
                      Color.fromRGBO(0, 0, 0, 0.65),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              // Interactive "Explore in AR" Pill Badge
              Positioned(
                bottom: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF127FD2),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        PhosphorIcons.cube(PhosphorIconsStyle.bold),
                        size: 15,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Explore in AR',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => Text(
              controller.sectionTitle.value,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            )),
        const SizedBox(height: 10),
        Obx(() => Text(
              controller.sectionContent.value,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.5,
                color: Color(0xFF414754),
              ),
            )),
      ],
    );
  }

  Widget _buildAskAiTutorButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.onAskAiTutor,
          borderRadius: BorderRadius.circular(9999),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F6FF),
              borderRadius: BorderRadius.circular(9999),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 31, 63, 0.1),
                  blurRadius: 16,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIcons.sparkle(PhosphorIconsStyle.fill),
                  size: 18,
                  color: const Color(0xFF445D80),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Ask AI Tutor',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                    color: Color(0xFF445D80),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVideoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video Thumbnail with Play Button
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    AppAssets.studentCellStructureHero,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: const Color(0xFF0F1E2E));
                    },
                  ),
                  // Dark Tint Overlay
                  Container(
                    color: const Color.fromRGBO(25, 28, 29, 0.5),
                  ),
                  // Center Play Button
                  Center(
                    child: GestureDetector(
                      onTap: controller.onPlayVideo,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9999),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            width: 54,
                            height: 54,
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(0, 89, 187, 0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  blurRadius: 16,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Obx(() => Icon(
                                  controller.isVideoPlaying.value
                                      ? PhosphorIcons.pause(PhosphorIconsStyle.fill)
                                      : PhosphorIcons.play(PhosphorIconsStyle.fill),
                                  size: 22,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Info Container
            Container(
              width: double.infinity,
              color: const Color(0xFFF3F4F5),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() => Text(
                        controller.videoTitle.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF191C1D),
                        ),
                      )),
                  const SizedBox(height: 3),
                  Obx(() => Text(
                        controller.videoDuration.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF414754),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationButtons() {
    return Row(
      children: [
        // Previous Button
        Expanded(
          child: SizedBox(
            height: 48,
            child: ElevatedButton(
              onPressed: controller.onPreviousLesson,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEDEEEF),
                foregroundColor: const Color(0xFF191C1D),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIcons.arrowLeft(PhosphorIconsStyle.bold),
                    size: 16,
                    color: const Color(0xFF191C1D),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Previous',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 14),
        // Next Button (Gradient)
        Expanded(
          child: SizedBox(
            height: 48,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF56B9E3),
                    Color(0xFF0E5E9B),
                  ],
                ),
                borderRadius: BorderRadius.circular(9999),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.12),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: controller.onNextLesson,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Next',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      PhosphorIcons.arrowRight(PhosphorIconsStyle.bold),
                      size: 16,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
