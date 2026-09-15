import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'student_quiz_record_model.dart';
import 'teacher_student_detail_controller.dart';

class TeacherStudentDetailView extends GetView<TeacherStudentDetailController> {
  const TeacherStudentDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    const fontFamily = AppTextStyle.fontFamily;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header: Back Button + Student Name (Figma: top: 74px, 44x44, gap: 14px)
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 16.0,
                ),
                child: Row(
                  children: [
                    // Ellipse 18: 44x44 Circular Back Button with Shadow (0px 4px 4px rgba(0, 0, 0, 0.1))
                    GestureDetector(
                      onTap: controller.onBack,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: Color(0xFF1567A2),
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Sarah Johnson: 20px w600 per ARCHITECTURE.md main titles
                    Expanded(
                      child: Obx(
                        () => Text(
                          controller.studentName.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF191C1D),
                            height: 26 / 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Student ID + Dot + ACTIVE Badge (13px w400, 11px w500 per ARCHITECTURE.md)
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 24.0,
                ),
                child: Row(
                  children: [
                    // STU-1024: 13px w400 per ARCHITECTURE.md secondary text
                    Obx(
                      () => Text(
                        controller.studentId.value,
                        style: const TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF414754),
                          height: 18 / 13,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Dot separator: 4x4, #C1C6D7
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFC1C6D7),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // ACTIVE pill chip: 11px w500 per ARCHITECTURE.md micro badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0E3856),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: const Text(
                        'ACTIVE',
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          color: Colors.white,
                          height: 15 / 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Contact Details Section (15px w500 per ARCHITECTURE.md section header)
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Contact Details title: 15px w500 per ARCHITECTURE.md
                    const Text(
                      'Contact Details',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF191C1D),
                        height: 20 / 15,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Rectangle 110: 354x89px
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        left: 16.0,
                        right: 16.0,
                        top: 12.0,
                        bottom: 12.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBFBFB),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // email: 14px w400
                          Obx(
                            () => Text(
                              controller.email.value,
                              style: const TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF191C1D),
                                height: 20 / 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Parent: 13px w400 per ARCHITECTURE.md secondary text
                          Obx(
                            () => Text(
                              controller.parentContact.value,
                              style: const TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF414754),
                                height: 18 / 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 4. Hero Banner: TOTAL SCORE Card (Figma: top: 341px, 347x160px, gradient 135deg)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  left: 27.5,
                  right: 27.5,
                  top: 14.0,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF53B5E0),
                      Color(0xFF1364A0),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 15,
                      spreadRadius: -3,
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                      spreadRadius: -4,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    // Overlay+Blur: 128x128px, right: -64px, top: -64px, blur: 20px
                    Positioned(
                      right: -64,
                      top: -64,
                      child: ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          width: 128,
                          height: 128,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x1AFFFFFF),
                          ),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TOTAL SCORE: 12px / 16px, w700, letter-spacing: 0.6px, uppercase
                          const Text(
                            'TOTAL SCORE',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                              color: Colors.white,
                              height: 16 / 12,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // 2,450 (48px / 56px, w700) + pts (32px / 40px, w700, 56% white)
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Obx(
                                  () => Text(
                                    controller.totalScore.value,
                                    style: const TextStyle(
                                      fontFamily: fontFamily,
                                      fontSize: 38,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.96,
                                      color: Colors.white,
                                      height: 46 / 38,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'pts',
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.32,
                                    color: Color(0x8FFFFFFF),
                                    height: 28 / 22,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Overlay Pill: 153.67x24px, rgba(0, 28, 58, 0.2), padding: 4px 8px, gap: 8px
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0x33001C3A),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.arrow_upward_rounded,
                                  color: Colors.white,
                                  size: 11,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Obx(
                                    () => Text(
                                      controller.scoreChange.value,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontFamily: fontFamily,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                        height: 16 / 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 5. Current Ranking Card (Figma: top: 535px, left: 30px, right: 30px, height: 72px)
              GestureDetector(
                onTap: controller.onRankingTap,
                child: Container(
                  constraints: const BoxConstraints(minHeight: 72),
                  margin: const EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    top: 34.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Circular Ranking Badge: 40x40px, #E0F6FF
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFE0F6FF),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.iconRankingPodium,
                            width: 20,
                            height: 18,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF445D80),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Text Column: Current Ranking (12px w700) + Rank #1 of 32 Students (16px w700)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Current Ranking',
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF414754),
                                height: 16 / 12,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Obx(
                              () => Text(
                                controller.currentRanking.value,
                                style: const TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF191C1D),
                                  height: 20 / 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Blue chevron right: 7.4x12px, #0059BB
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF0059BB),
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),

              // 6. View All Link Button (14px w500 per ARCHITECTURE.md)
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Center(
                  child: GestureDetector(
                    onTap: controller.onViewAllQuizzes,
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF127FD2),
                        height: 20 / 14,
                      ),
                    ),
                  ),
                ),
              ),

              // 7. Recent Quizzes Header (16px w600 per ARCHITECTURE.md section headers)
              const Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: Center(
                  child: Text(
                    'Recent Quizzes',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF191C1D),
                      height: 22 / 16,
                    ),
                  ),
                ),
              ),

              // 8. Recent Quizzes List (Figma: top: 739px, 12px below header, gap: 8px between cards)
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(top: 12.0, bottom: 40.0),
                  itemCount: controller.recentQuizzes.length,
                  itemBuilder: (context, index) {
                    final quiz = controller.recentQuizzes[index];
                    return _buildQuizCard(quiz);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard(StudentQuizRecordModel quiz) {
    const fontFamily = AppTextStyle.fontFamily;

    final parts = quiz.score.split('/');
    final scoreValue = parts.isNotEmpty ? parts[0] : quiz.score;
    final maxScore = parts.length > 1 ? '/${parts[1]}' : '';

    return GestureDetector(
      onTap: () => controller.onQuizTap(quiz),
      child: Container(
        height: 78,
        margin: const EdgeInsets.only(
          left: 23.0,
          right: 23.0,
          bottom: 8.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFBFBFB),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon in 40x40 container: #F8F9FA, border-radius: 8px
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Center(
                child: SvgPicture.asset(
                  quiz.iconAsset,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFF127FD2),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Title & Status (15px w500, 13px w400 per ARCHITECTURE.md)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    quiz.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191C1D),
                      height: 20 / 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      // 8x8 dot: #0E3856, border-radius: 9999px
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0E3856),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          quiz.status,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF414754),
                            height: 18 / 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Score e.g. 8/10 (15px w600 / 13px w400)
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                text: scoreValue,
                style: const TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF127FD2),
                  height: 20 / 15,
                ),
                children: [
                  TextSpan(
                    text: maxScore,
                    style: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF414754),
                      height: 18 / 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

