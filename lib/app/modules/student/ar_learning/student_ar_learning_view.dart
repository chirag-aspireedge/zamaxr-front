import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'student_ar_learning_controller.dart';

class StudentArLearningView extends GetView<StudentArLearningController> {
  const StudentArLearningView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          if (controller.isScanned.value) {
            return _buildScannedAr3dView(context);
          }
          return _buildCameraScannerView(context);
        }),
      ),
    );
  }

  // ==========================================
  // SCREEN 1: Camera Scanner View (Exact Figma)
  // ==========================================
  Widget _buildCameraScannerView(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Stack(
      fit: StackFit.expand,
      children: [
        // 1. Full-bleed camera view background
        Positioned.fill(
          child: Image.asset(
            AppAssets.studentArScanBg,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppAssets.studentCellStructureHero,
                fit: BoxFit.cover,
              );
            },
          ),
        ),

        // 2. Dark gradient overlay for contrast
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.2, 0.6, 1.0],
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.55),
                  Color.fromRGBO(0, 0, 0, 0.15),
                  Color.fromRGBO(0, 0, 0, 0.0),
                  Color.fromRGBO(0, 0, 0, 0.65),
                ],
              ),
            ),
          ),
        ),

        // 3. Top Action Bar: Back button & "AR Learning" title (all in crisp white)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  // White Back Button (42x42 circular glassmorphic button with crisp white border & white arrow)
                  GestureDetector(
                    onTap: controller.onBackTap,
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0x33FFFFFF),
                            border: Border.all(
                              color: Colors.white,
                              width: 1.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x40000000),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Title: "AR Learning" in white with shadow
                  const Expanded(
                    child: Text(
                      'AR Learning',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: -0.2,
                        shadows: [
                          Shadow(
                            color: Color(0xBF000000),
                            blurRadius: 8,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Flashlight toggle button
                  GestureDetector(
                    onTap: controller.toggleFlash,
                    child: Obx(() => ClipOval(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                            child: Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: controller.isFlashOn.value
                                    ? const Color(0xFF127FD2)
                                    : const Color(0x33FFFFFF),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1.5,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x40000000),
                                    blurRadius: 6,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              alignment: Alignment.center,
                              child: Icon(
                                controller.isFlashOn.value
                                    ? PhosphorIcons.lightning(PhosphorIconsStyle.fill)
                                    : PhosphorIcons.lightning(PhosphorIconsStyle.bold),
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                  ),
                  const SizedBox(width: 8),
                  // Help Icon button (42x42 circle)
                  GestureDetector(
                    onTap: () => controller.showHelpModal(context),
                    child: ClipOval(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0x33FFFFFF),
                            border: Border.all(
                              color: Colors.white,
                              width: 1.5,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x40000000),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.help_outline_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        // 4. Centered Scanning Reticle Frame & Laser
        Positioned(
          top: 140,
          left: 0,
          right: 0,
          child: Center(
            child: _buildScanningReticle(context),
          ),
        ),

        // 5. Bottom Sheet / Panel with Guidelines & "Scan Page" button
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildBottomSheet(context, bottomPadding),
        ),

        // 6. Scanning Progress Overlay (when user taps "Scan Page")
        Obx(() {
          if (!controller.isScanning.value) return const SizedBox.shrink();
          return Positioned.fill(
            child: Container(
              color: const Color(0x8C000000),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.15),
                          blurRadius: 16,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          width: 48,
                          height: 48,
                          child: CircularProgressIndicator(
                            strokeWidth: 3.5,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Color(0xFF0059BB),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          'Recognizing Diagram...',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF191C1D),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Generating 3D AR Model & AI Notes',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 13,
                            color: Color(0xFF717786),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // Scanning Reticle with 4 brackets & moving laser line
  Widget _buildScanningReticle(BuildContext context) {
    const double reticleWidth = 280;
    const double reticleHeight = 240;

    return SizedBox(
      width: reticleWidth,
      height: reticleHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 4 Bracket Corners
          CustomPaint(
            size: const Size(reticleWidth, reticleHeight),
            painter: _ReticleCornersPainter(),
          ),

          // Text inside frame (Scan Textbook / Point camera at supported diagram)
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Scan Textbook',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      shadows: const [
                        Shadow(
                          color: Color(0x99000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Point camera at supported diagram',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xEBFFFFFF),
                      shadows: [
                        Shadow(
                          color: Color(0x99000000),
                          blurRadius: 6,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Animated Glowing Scanning Laser Line
          AnimatedBuilder(
            animation: controller.scanAnimation,
            builder: (context, child) {
              final topOffset =
                  controller.scanAnimation.value * (reticleHeight - 12) + 6;
              return Positioned(
                top: topOffset,
                left: 10,
                right: 10,
                child: Container(
                  height: 2.5,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0059BB),
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF0059BB),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                      BoxShadow(
                        color: Color(0xFF56B9E3),
                        blurRadius: 4,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Bottom Sheet Panel with Figma CSS spec
  Widget _buildBottomSheet(BuildContext context, double bottomPadding) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xF2FFFFFF),
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 24,
                offset: Offset(0, -8),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(24, 14, 24, bottomPadding + 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle indicator (48x6)
              Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: const Color(0x80C1C6D7),
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              const SizedBox(height: 18),

              // Instruction Card 1: "Keep the page inside the frame"
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF127FD2),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        PhosphorIcons.crop(PhosphorIconsStyle.bold),
                        size: 18,
                        color: const Color(0xFFFEFCFF),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Keep the page inside the frame',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Instruction Card 2: "Make sure the page is clearly visible and well lit"
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFF127FD2),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        PhosphorIcons.sun(PhosphorIconsStyle.bold),
                        size: 20,
                        color: const Color(0xFFFEFCFF),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Make sure the page is clearly visible and well lit',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF191C1D),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Primary "Scan Page" Button
              // 355x54, gradient: 90deg, #56B9E3 to #0E5E9B, border-radius: 74px
              GestureDetector(
                onTap: controller.scanPage,
                child: Container(
                  width: double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(74),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF56B9E3),
                        Color(0xFF0E5E9B),
                      ],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(14, 94, 155, 0.35),
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIcons.scan(PhosphorIconsStyle.bold),
                        size: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Scan Page',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // "How it works" link
              GestureDetector(
                onTap: () => controller.showHelpModal(context),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: Color(0xFF127FD2),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'How it works',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF127FD2),
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

  // ==========================================
  // SCREEN 2: 3D AR Model View (Scanned State)
  // ==========================================
  Widget _buildScannedAr3dView(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Full screen 3D holographic AR background
        Positioned.fill(
          child: Image.asset(
            AppAssets.studentAr3dCellProjected,
            fit: BoxFit.cover,
            alignment: Alignment.center,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppAssets.studentCellStructureHero,
                fit: BoxFit.cover,
              );
            },
          ),
        ),

        // Dark gradient overlay
        // linear-gradient(180deg, rgba(0, 0, 0, 0.6) 0%, rgba(0, 0, 0, 0) 50%, rgba(0, 0, 0, 0.8) 100%)
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.45, 1.0],
                colors: [
                  Color.fromRGBO(0, 0, 0, 0.6),
                  Color.fromRGBO(0, 0, 0, 0.0),
                  Color.fromRGBO(0, 0, 0, 0.85),
                ],
              ),
            ),
          ),
        ),

        // Top Navigation Bar (glassmorphic back button & status)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  // Back button
                  GestureDetector(
                    onTap: controller.resetScan,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9999),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color.fromRGBO(225, 227, 228, 0.2),
                            border: Border.all(
                              color: const Color(0x4DFFFFFF),
                              width: 1.0,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.arrow_back_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Title: AR 3D Animal Cell
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Human Cell Structure',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          'Interactive 3D AR Model',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF56B9E3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  // Re-scan button
                  GestureDetector(
                    onTap: controller.resetScan,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x33FFFFFF),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0x4DFFFFFF),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.refresh_rounded,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Scan again',
                            style: TextStyle(
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
        ),

        // Interactive Organelle Selector Chips (Floating mid-screen)
        Positioned(
          top: 130,
          left: 0,
          right: 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => Row(
                children: controller.organelles.map((organelle) {
                  final isSelected =
                      controller.selectedOrganelle.value == organelle.name;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () => controller.selectOrganelle(organelle.name),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF127FD2)
                              : const Color(0x66000000),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF56B9E3)
                                : const Color(0x4DFFFFFF),
                            width: 1.2,
                          ),
                          boxShadow: isSelected
                              ? const [
                                  BoxShadow(
                                    color: Color(0x66127FD2),
                                    blurRadius: 8,
                                    offset: Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: Text(
                          organelle.name,
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 13,
                            fontWeight: isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),

        // Bottom AI Tutor Organelle Explanation Card
        Positioned(
          left: 16,
          right: 16,
          bottom: bottomPadding + 16,
          child: Obx(() {
            final selected = controller.organelles.firstWhere(
              (o) => o.name == controller.selectedOrganelle.value,
              orElse: () => controller.organelles.first,
            );

            return ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xEBFFFFFF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0x80FFFFFF),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.2),
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD8E2FF),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.auto_awesome_rounded,
                                  size: 13,
                                  color: Color(0xFF0059BB),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  'AI TUTOR INSIGHT',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0059BB),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              selected.role,
                              textAlign: TextAlign.end,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF414754),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        selected.name,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        selected.description,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF414754),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () =>
                                  controller.onAskAiTutorTap(selected.name),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF127FD2),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              icon: const Icon(Icons.forum_outlined, size: 18),
                              label: const Text(
                                'Ask AI Tutor',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

/// CustomPainter that renders the exact 4 corner brackets of the Figma scanning reticle:
/// 32x32 each corner, 3px white border, 8px radius on the outer angle.
class _ReticleCornersPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const double cornerLength = 32.0;
    const double radius = 8.0;

    // Top-Left Corner
    final topLeft = Path()
      ..moveTo(0, cornerLength)
      ..lineTo(0, radius)
      ..arcToPoint(const Offset(radius, 0), radius: const Radius.circular(radius))
      ..lineTo(cornerLength, 0);
    canvas.drawPath(topLeft, paint);

    // Top-Right Corner
    final topRight = Path()
      ..moveTo(size.width - cornerLength, 0)
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius),
          radius: const Radius.circular(radius))
      ..lineTo(size.width, cornerLength);
    canvas.drawPath(topRight, paint);

    // Bottom-Left Corner
    final bottomLeft = Path()
      ..moveTo(0, size.height - cornerLength)
      ..lineTo(0, size.height - radius)
      ..arcToPoint(Offset(radius, size.height),
          radius: const Radius.circular(radius))
      ..lineTo(cornerLength, size.height);
    canvas.drawPath(bottomLeft, paint);

    // Bottom-Right Corner
    final bottomRight = Path()
      ..moveTo(size.width - cornerLength, size.height)
      ..lineTo(size.width - radius, size.height)
      ..arcToPoint(Offset(size.width, size.height - radius),
          radius: const Radius.circular(radius))
      ..lineTo(size.width, size.height - cornerLength);
    canvas.drawPath(bottomRight, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
