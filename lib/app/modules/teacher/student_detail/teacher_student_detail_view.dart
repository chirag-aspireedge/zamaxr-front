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
              // 1. App Bar: Circular Back Button with Shadow + Student Name
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 16.0,
                  bottom: 8.0,
                ),
                child: Row(
                  children: [
                    // Ellipse 18: 44x44 Circular Back Button with Shadow
                    GestureDetector(
                      onTap: controller.onBack,
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFF0F0F0),
                            width: 0.8,
                          ),
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

                    // Student Name
                    Expanded(
                      child: Obx(
                        () => Text(
                          controller.studentName.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF191C1D),
                            height: 32 / 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 2. Student ID + Dot + ACTIVE Badge
              Padding(
                padding: const EdgeInsets.only(
                  left: 24.0,
                  right: 24.0,
                  top: 4.0,
                  bottom: 20.0,
                ),
                child: Row(
                  children: [
                    // STU-1024
                    Obx(
                      () => Text(
                        controller.studentId.value,
                        style: const TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF414754),
                          height: 24 / 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Dot separator: 4x4
                    Container(
                      width: 4,
                      height: 4,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFC1C6D7),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // ACTIVE pill chip
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
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 3. Contact Details Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Contact Details',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF191C1D),
                        height: 26 / 15,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Rectangle 110: Contact details container
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 14.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFBFBFB),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFF0F0F0),
                          width: 0.8,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              controller.email.value,
                              style: const TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF191C1D),
                                height: 24 / 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Obx(
                            () => Text(
                              controller.parentContact.value,
                              style: const TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF414754),
                                height: 24 / 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 4. Hero Banner: TOTAL SCORE Card (Gradient 135deg)
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
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
                      offset: const Offset(0, 10),
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    // Decorative blurry circle top right
                    Positioned(
                      right: -30,
                      top: -30,
                      child: Container(
                        width: 128,
                        height: 128,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TOTAL SCORE label
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

                          // Score + pts Row (FittedBox prevents overflow on narrow screens)
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
                                      fontSize: 48,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.96,
                                      color: Colors.white,
                                      height: 1.1,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  'pts',
                                  style: TextStyle(
                                    fontFamily: fontFamily,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.32,
                                    color: Color(0x8FFFFFFF),
                                    height: 1.1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Pill Tag: 12% from last week
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF001C3A)
                                  .withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.arrow_upward_rounded,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                const SizedBox(width: 6),
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

              // 5. Current Ranking Card
              GestureDetector(
                onTap: controller.onRankingTap,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 4.0,
                  ),
                  constraints: const BoxConstraints(minHeight: 72),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFFF0F0F0),
                      width: 0.8,
                    ),
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
                      // Circular Ranking Badge
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

                      // Text Column
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
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF191C1D),
                                  height: 24 / 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Blue chevron right
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xFF0059BB),
                        size: 22,
                      ),
                    ],
                  ),
                ),
              ),

              // 6. View All Link Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: controller.onViewAllQuizzes,
                    child: const Text(
                      'View All',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF127FD2),
                        height: 24 / 16,
                      ),
                    ),
                  ),
                ),
              ),

              // 7. Recent Quizzes Header
              const Padding(
                padding: EdgeInsets.only(top: 8.0, bottom: 14.0),
                child: Center(
                  child: Text(
                    'Recent Quizzes',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191C1D),
                      height: 32 / 15,
                    ),
                  ),
                ),
              ),

              // 8. Recent Quizzes List
              Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 24.0),
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
        height: 82,
        margin: const EdgeInsets.only(
          left: 23.0,
          right: 23.0,
          bottom: 12.0,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: const Color(0xFFFBFBFB),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFF0F0F0),
            width: 0.8,
          ),
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
            // Icon in 40x40 container
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

            // Title & Status
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
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF191C1D),
                      height: 24 / 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      // 8x8 dot
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
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF414754),
                            height: 24 / 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Score e.g. 8/10
            RichText(
              textAlign: TextAlign.right,
              text: TextSpan(
                text: scoreValue,
                style: const TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF127FD2),
                  height: 24 / 16,
                ),
                children: [
                  TextSpan(
                    text: maxScore,
                    style: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF414754),
                      height: 24 / 16,
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
