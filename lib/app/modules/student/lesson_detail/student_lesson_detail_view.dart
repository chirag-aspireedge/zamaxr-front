import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'student_lesson_detail_controller.dart';
import 'student_lesson_detail_model.dart';

class StudentLessonDetailView extends GetView<StudentLessonDetailController> {
  const StudentLessonDetailView({super.key});

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
            // Main Content Scrollable
            Expanded(
              child: Obx(() {
                final lesson = controller.lesson.value;
                return ListView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // 1. Hero Section: Image Banner, Tags, Heading & Progress
                    _buildHeroSection(lesson),
                    // 2. About Section
                    _buildAboutSection(lesson),
                    // 3. Continue Button (directly below About section)
                    const SizedBox(height: 16),
                    _buildContinueButton(),
                    // 4. Quiz Section
                    _buildQuizSection(lesson),
                    // 5. Lesson Content Section
                    _buildLessonContentSection(lesson),
                    // 6. Interactive Learning Section
                    _buildInteractiveLearningSection(),
                  ],
                );
              }),
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
            'Lesson Details',
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

  // 1. Hero Section
  Widget _buildHeroSection(StudentLessonDetailModel lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Hero Image Container with Overlays
        Container(
          width: double.infinity,
          height: 196,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.08),
                blurRadius: 6,
                offset: Offset(0, 4),
              ),
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                Image.asset(
                  AppAssets.studentCellStructureHero,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF071F36),
                      alignment: Alignment.center,
                      child: Icon(
                        PhosphorIcons.atom(PhosphorIconsStyle.duotone),
                        size: 64,
                        color: const Color(0xFF56B9E3),
                      ),
                    );
                  },
                ),
                // Gradient Overlay
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Color.fromRGBO(0, 28, 58, 0.7),
                        Color.fromRGBO(0, 28, 58, 0.2),
                        Color.fromRGBO(0, 28, 58, 0.0),
                      ],
                    ),
                  ),
                ),
                // Bottom Pills Row
                Positioned(
                  left: 14,
                  right: 14,
                  bottom: 14,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Pill 1: Flask Icon + Subject & Grade
                      Flexible(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(9999),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(248, 249, 250, 0.9),
                                borderRadius: BorderRadius.circular(9999),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.05),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    PhosphorIcons.flask(PhosphorIconsStyle.fill),
                                    size: 13,
                                    color: const Color(0xFF0059BB),
                                  ),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    child: Text(
                                      lesson.metadataLine,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontFamily: AppTextStyle.fontFamily,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF191C1D),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Pill 2: Duration
                      ClipRRect(
                        borderRadius: BorderRadius.circular(9999),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(248, 249, 250, 0.9),
                              borderRadius: BorderRadius.circular(9999),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x0D000000),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Text(
                              lesson.durationText,
                              style: const TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF191C1D),
                              ),
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
        ),
        const SizedBox(height: 16),
        // Title
        Text(
          lesson.title,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 22,
            fontWeight: FontWeight.w700,
            height: 1.25,
            color: Color(0xFF191C1D),
          ),
        ),
        const SizedBox(height: 12),
        // Progress Row: Your Progress & Percentage
        Row(
          children: [
            const Text(
              'Your Progress',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF414754),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                lesson.progressPercentageText,
                textAlign: TextAlign.end,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF127FD2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 8px Pill Progress Bar
        ClipRRect(
          borderRadius: BorderRadius.circular(9999),
          child: LinearProgressIndicator(
            value: lesson.progress,
            minHeight: 8,
            backgroundColor: const Color(0xFFEDEEEF),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF127FD2),
            ),
          ),
        ),
      ],
    );
  }

  // 2. About Section
  Widget _buildAboutSection(StudentLessonDetailModel lesson) {
    return Container(
      margin: const EdgeInsets.only(top: 22),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lesson.aboutTitle,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF414754),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            lesson.aboutDescription,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.45,
              color: Color(0xFF191C1D),
            ),
          ),
        ],
      ),
    );
  }

  // Continue Button (placed directly below About This Lesson)
  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
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
              color: Color.fromRGBO(14, 94, 155, 0.28),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: controller.onContinueLesson,
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
                'CONTINUE',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                PhosphorIcons.arrowRight(PhosphorIconsStyle.bold),
                size: 18,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 3. Quiz Section (Gradient Banner)
  Widget _buildQuizSection(StudentLessonDetailModel lesson) {
    return Container(
      margin: const EdgeInsets.only(top: 18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF51B3DE),
            Color(0xFF0F609C),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Stack(
          children: [
            // Decorative soft blur circle overlay
            Positioned(
              right: -32,
              top: -32,
              child: Container(
                width: 128,
                height: 128,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(0, 26, 65, 0.12),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
              child: Row(
                children: [
                  // Left info column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              PhosphorIcons.notePencil(PhosphorIconsStyle.fill),
                              size: 15,
                              color: const Color(0xFFFEFCFF),
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                lesson.quizTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFFFEFCFF),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          lesson.quizQuestionsText,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFEFCFF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Right Action Button
                  ElevatedButton(
                    onPressed: controller.onStartQuiz,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF0059BB),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                    child: const Text(
                      'START QUIZ',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: Color(0xFF0059BB),
                      ),
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

  // 4. Lesson Content Section
  Widget _buildLessonContentSection(StudentLessonDetailModel lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          'Lesson Content',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF191C1D),
          ),
        ),
        const SizedBox(height: 14),
        ...lesson.contentItems.map((item) {
          return _buildContentItemCard(item);
        }),
      ],
    );
  }

  Widget _buildContentItemCard(StudentLessonContentItem item) {
    IconData leadingIcon;
    switch (item.type) {
      case StudentLessonContentType.video:
        leadingIcon = PhosphorIcons.play(PhosphorIconsStyle.fill);
        break;
      case StudentLessonContentType.pdf:
        leadingIcon = PhosphorIcons.fileText(PhosphorIconsStyle.fill);
        break;
      case StudentLessonContentType.audio:
        leadingIcon = PhosphorIcons.headphones(PhosphorIconsStyle.fill);
        break;
    }

    return Opacity(
      opacity: item.cardOpacity,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => controller.onContentItemTap(item),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  // Leading 44x44 Circular Icon Container
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: item.iconBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      leadingIcon,
                      size: 20,
                      color: item.iconColor,
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Title and Subtitle Column
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF191C1D),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.subtitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF414754),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Trailing Status Indicator
                  _buildTrailingIndicator(item),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrailingIndicator(StudentLessonContentItem item) {
    if (item.isCompleted) {
      // Completed: 28x28 Circle with Checkmark
      return Container(
        width: 28,
        height: 28,
        decoration: const BoxDecoration(
          color: Color(0xFFEDEEEF),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Icon(
          PhosphorIcons.check(PhosphorIconsStyle.bold),
          size: 15,
          color: const Color(0xFF414754),
        ),
      );
    } else if (item.isLocked) {
      // Locked: 28x28 Container with Lock Icon
      return Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        child: Icon(
          PhosphorIcons.lock(PhosphorIconsStyle.fill),
          size: 16,
          color: const Color(0xFF717786),
        ),
      );
    } else {
      // In Progress / Pending: 28x28 Circular Border
      return Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFC1C6D7),
            width: 1.75,
          ),
        ),
      );
    }
  }

  // 5. Interactive Learning Section
  Widget _buildInteractiveLearningSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        const Text(
          'Interactive Learning',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF191C1D),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            // Card 1: Explore in AR
            Expanded(
              child: _buildInteractiveCard(
                title: 'Explore in AR',
                gradientColors: const [Color(0xFFE0F6FF), Color(0xFFFFFFFF)],
                textColor: const Color(0xFF001A41),
                icon: PhosphorIcons.cube(PhosphorIconsStyle.bold),
                watermarkIcon: PhosphorIcons.cube(PhosphorIconsStyle.fill),
                onTap: controller.onExploreAr,
              ),
            ),
            const SizedBox(width: 14),
            // Card 2: Experience in VR
            Expanded(
              child: _buildInteractiveCard(
                title: 'Experience in VR',
                gradientColors: const [Color(0xFFD0E7EA), Color(0xFFE1E3E4)],
                textColor: const Color(0xFF091F21),
                icon: PhosphorIcons.eyeglasses(PhosphorIconsStyle.bold),
                watermarkIcon: PhosphorIcons.eyeglasses(PhosphorIconsStyle.fill),
                onTap: controller.onExperienceVr,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInteractiveCard({
    required String title,
    required List<Color> gradientColors,
    required Color textColor,
    required IconData icon,
    required IconData watermarkIcon,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradientColors,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Decorative watermark icon at bottom right
            Positioned(
              right: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.1,
                child: Icon(
                  watermarkIcon,
                  size: 56,
                  color: textColor,
                ),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Frosted glass icon box
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0.6),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.04),
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: Icon(
                              icon,
                              size: 18,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 1.25,
                          color: textColor,
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
    );
  }
}

