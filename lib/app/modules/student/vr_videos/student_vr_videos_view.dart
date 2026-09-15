import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/themes/app_textstyle.dart';
import 'student_vr_videos_controller.dart';

class StudentVrVideosView extends GetView<StudentVrVideosController> {
  const StudentVrVideosView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Obx(() {
          if (controller.isVrHeadsetModalOpen.value &&
              controller.activeExperience.value != null) {
            return _buildVrHeadsetExperienceView(
                context, controller.activeExperience.value!);
          }
          return _buildMainListView(context);
        }),
      ),
    );
  }

  // ==========================================
  // SCREEN: VR Videos Main List (Exact Figma)
  // ==========================================
  Widget _buildMainListView(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Top App Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                // Back Button (Group 2079: 44x44 circle with border #1567A2)
                GestureDetector(
                  onTap: controller.onBackTap,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFF1567A2),
                        width: 1.5,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.08),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      size: 22,
                      color: Color(0xFF1567A2),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Title: "Learning experiences"
                const Expanded(
                  child: Text(
                    'Learning experiences',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF414754),
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // 2. Scrollable VR Cards
          Expanded(
            child: Obx(
              () => ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 32),
                itemCount: controller.vrExperiences.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 24),
                itemBuilder: (context, index) {
                  final item = controller.vrExperiences[index];
                  return _buildVrExperienceCard(context, item);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // CARD: VR Experience Card (Exact Figma Specs)
  // ==========================================
  Widget _buildVrExperienceCard(
      BuildContext context, VrExperienceItem item) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 31, 63, 0.06),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Header Media Thumbnail with Overlaid Badges
          Stack(
            children: [
              // Media Banner (height ~200px)
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16)),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    item.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFE1E3E4),
                        alignment: Alignment.center,
                        child: Icon(
                          PhosphorIcons.eyeglasses(PhosphorIconsStyle.fill),
                          size: 48,
                          color: const Color(0xFF717786),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Overlay Gradient on bottom of image for depth
              Positioned.fill(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.6, 1.0],
                        colors: [
                          Colors.transparent,
                          Color.fromRGBO(0, 0, 0, 0.35),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Badge Top-Left: "VR READY" (#0E3856)
              Positioned(
                left: 14,
                top: 14,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E3856),
                        borderRadius: BorderRadius.circular(6),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.08),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            PhosphorIcons.cube(PhosphorIconsStyle.fill),
                            size: 13,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item.qualityBadge,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Badge Top-Right: Download Status / Offline Badge
              Positioned(
                right: 14,
                top: 14,
                child: GestureDetector(
                  onTap: () => controller.onDownloadTap(item),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(9999),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xE6F8F9FA),
                            borderRadius: BorderRadius.circular(9999),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.08),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (item.isDownloading.value) ...[
                                const SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF0059BB)),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  '${(item.downloadProgress.value * 100).toInt()}%',
                                  style: const TextStyle(
                                    fontFamily: AppTextStyle.fontFamily,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF0059BB),
                                  ),
                                ),
                              ] else if (item.isDownloaded.value) ...[
                                Icon(
                                  PhosphorIcons.checkCircle(
                                      PhosphorIconsStyle.fill),
                                  size: 14,
                                  color: const Color(0xFF0059BB),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  'DOWNLOADED',
                                  style: TextStyle(
                                    fontFamily: AppTextStyle.fontFamily,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF191C1D),
                                    letterSpacing: 0.4,
                                  ),
                                ),
                              ] else ...[
                                Icon(
                                  PhosphorIcons.cloudArrowDown(
                                      PhosphorIconsStyle.bold),
                                  size: 14,
                                  color: const Color(0xFF717786),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  item.downloadSize,
                                  style: const TextStyle(
                                    fontFamily: AppTextStyle.fontFamily,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF414754),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // 2. Card Body Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subject Tag + Duration Badge Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Subject Tag ("BIOLOGY", "SCIENCE", etc.)
                    Text(
                      item.subject,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF0059BB),
                        letterSpacing: 0.6,
                      ),
                    ),

                    // Duration Chip (clock icon + duration)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEEEF),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            PhosphorIcons.clock(PhosphorIconsStyle.bold),
                            size: 13,
                            color: const Color(0xFF414754),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            item.duration,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF414754),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Heading Title
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF191C1D),
                    height: 1.25,
                  ),
                ),

                const SizedBox(height: 6),

                // Description Text
                Text(
                  item.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF414754),
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 16),

                // Primary Gradient Button: "Experience In VR"
                GestureDetector(
                  onTap: () => controller.onExperienceInVr(item),
                  child: Container(
                    height: 52,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF56B9E3),
                          Color(0xFF0E5E9B),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(74),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(14, 94, 155, 0.25),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          PhosphorIcons.eyeglasses(PhosphorIconsStyle.bold),
                          size: 19,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Experience In VR',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // MODAL / FULL-SCREEN: VR Headset Simulation View
  // ==========================================
  Widget _buildVrHeadsetExperienceView(
      BuildContext context, VrExperienceItem item) {
    return Container(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Interactive 360° Simulated VR Viewport
          Obx(() {
            if (controller.isDualEyeMode.value) {
              // Dual-Eye Split Screen (Cardboard / VR Headset view)
              return Row(
                children: [
                  Expanded(
                    child: _buildEyeViewport(item, isLeftEye: true),
                  ),
                  Container(
                    width: 2,
                    color: const Color(0x66FFFFFF),
                  ),
                  Expanded(
                    child: _buildEyeViewport(item, isLeftEye: false),
                  ),
                ],
              );
            }
            // Full 360° Single Viewport
            return _buildEyeViewport(item, isLeftEye: true);
          }),

          // 2. Top Navigation Bar (Close, Title, Dual-Eye Toggle)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  children: [
                    // Exit VR Button
                    GestureDetector(
                      onTap: controller.closeVrModal,
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0x4D000000),
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.close_rounded,
                              size: 22,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // VR Experience Title
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Color(0x99000000),
                                  blurRadius: 6,
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            '360° VR Spatial Experience Active',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF56B9E3),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Dual-Eye Headset Mode Toggle
                    GestureDetector(
                      onTap: controller.toggleDualEyeMode,
                      child: Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: controller.isDualEyeMode.value
                                ? const Color(0xFF0059BB)
                                : const Color(0x4D000000),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white,
                              width: 1.2,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                PhosphorIcons.eyeglasses(
                                    PhosphorIconsStyle.bold),
                                size: 16,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                controller.isDualEyeMode.value
                                    ? 'Cardboard'
                                    : '360° View',
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 3. Central Reticle / Gyroscope Indicator
          Center(
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0x99FFFFFF),
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF56B9E3),
                ),
              ),
            ),
          ),

          // 4. Bottom Controls Overlay: Play/Pause, Progress Scrubber
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x66000000),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0x33FFFFFF),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Progress Scrubber Bar
                          Row(
                            children: [
                              const Text(
                                '01:24',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Obx(
                                  () => SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: 3,
                                      thumbShape:
                                          const RoundSliderThumbShape(
                                        enabledThumbRadius: 6,
                                      ),
                                      overlayShape:
                                          const RoundSliderOverlayShape(
                                        overlayRadius: 10,
                                      ),
                                      activeTrackColor:
                                          const Color(0xFF56B9E3),
                                      inactiveTrackColor:
                                          const Color(0x33FFFFFF),
                                      thumbColor: Colors.white,
                                    ),
                                    child: Slider(
                                      value: controller.playbackProgress.value,
                                      onChanged: (val) {
                                        controller.playbackProgress.value = val;
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                item.duration,
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          // Control Buttons
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Gyro toggle
                              IconButton(
                                icon: Icon(
                                  PhosphorIcons.compass(PhosphorIconsStyle.bold),
                                  color: controller.isGyroscopeActive.value
                                      ? const Color(0xFF56B9E3)
                                      : Colors.white60,
                                  size: 22,
                                ),
                                onPressed: controller.toggleGyroscope,
                                tooltip: 'Gyro Look-around',
                              ),
                              // Play / Pause
                              GestureDetector(
                                onTap: controller.togglePlayPause,
                                child: Container(
                                  width: 46,
                                  height: 46,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF56B9E3),
                                        Color(0xFF0E5E9B),
                                      ],
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Obx(
                                    () => Icon(
                                      controller.isPlaying.value
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                      size: 26,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              // Audio Narration
                              IconButton(
                                icon: Icon(
                                  PhosphorIcons.speakerHigh(
                                      PhosphorIconsStyle.bold),
                                  color: Colors.white,
                                  size: 22,
                                ),
                                onPressed: () {
                                  Get.snackbar(
                                    'Spatial Audio',
                                    '3D Head-tracking spatial audio enabled.',
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: const Color(0xCC000000),
                                    colorText: Colors.white,
                                    duration: const Duration(seconds: 2),
                                  );
                                },
                                tooltip: '3D Spatial Audio',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEyeViewport(VrExperienceItem item, {required bool isLeftEye}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          item.imagePath,
          fit: BoxFit.cover,
          alignment: isLeftEye ? const Alignment(-0.2, 0) : const Alignment(0.2, 0),
        ),
        // Subtle barrel distortion / vignette overlay for VR feel
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 0.9,
              colors: [
                Colors.transparent,
                Color.fromRGBO(0, 0, 0, 0.4),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
