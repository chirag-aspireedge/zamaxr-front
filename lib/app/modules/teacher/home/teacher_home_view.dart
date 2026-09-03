import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import '../quizzes/teacher_quiz_model.dart';
import 'teacher_home_controller.dart';

class TeacherHomeView extends GetView<TeacherHomeController> {
  const TeacherHomeView({super.key});

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
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // Top Bar: Profile Avatar (Left) and Notification + Settings (Right)
                  _buildTopBar(),

                  const SizedBox(height: 24),

                  // Greeting Text
                  Obx(
                    () => Text(
                      'Good Morning, ${controller.teacherName.value}',
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF131313),
                        height: 25 / 20,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF131313),
                      height: 16 / 13,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Hero Banner Card: "Create New Immersive Lesson"
                  _buildHeroBanner(),

                  const SizedBox(height: 24),

                  // Quick Action Cards
                  _buildQuickActionGrid(),

                  const SizedBox(height: 28),

                  // Recent Lessons Built Section Header
                  _buildRecentLessonsHeader(),

                  const SizedBox(height: 16),

                  // Recent Lessons Horizontal List
                  _buildRecentLessonsList(),

                  const SizedBox(height: 28),

                  // Recent Quizzes Built Section Header
                  _buildRecentQuizzesHeader(),

                  const SizedBox(height: 16),

                  // Recent Quizzes Horizontal List
                  _buildRecentQuizzesList(),

                  // Bottom padding for floating navigation bar
                  const SizedBox(height: 110),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Top Bar ---
  Widget _buildTopBar() {
    return Row(
      children: [
        // Profile Photo (40x40 circle)
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFC6C5D4).withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/teacher_avatar.png',
              width: 38,
              height: 38,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFFE0F6FF),
                child: const Icon(
                  Icons.person,
                  size: 22,
                  color: Color(0xFF127FD2),
                ),
              ),
            ),
          ),
        ),

        const Spacer(),

        // Notification Button (44x44 circular glass button)
        _buildCircularTopButton(
          iconAsset: 'assets/icons/icon_notification_unread_blue.svg',
          onTap: controller.onNotifications,
        ),

        const SizedBox(width: 14),

        // Settings Button (44x44 circular glass button)
        _buildCircularTopButton(
          iconAsset: 'assets/icons/icon_settings_blue.svg',
          onTap: controller.onSettings,
        ),
      ],
    );
  }

  Widget _buildCircularTopButton({
    required String iconAsset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFE7E7E7),
            width: 0.8,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: SvgPicture.asset(
            iconAsset,
            width: 22,
            height: 22,
          ),
        ),
      ),
    );
  }

  // --- Hero Banner: Create New Immersive Lesson ---
  Widget _buildHeroBanner() {
    return GestureDetector(
      onTap: controller.onCreateImmersiveLesson,
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(minHeight: 197),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF0E3856),
              Color(0xFF1667A2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              // Background Cover Image with dark overlay
              Positioned.fill(
                child: Image.asset(
                  'assets/images/login-signup-bg.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),
              Positioned.fill(
                child: Container(
                  color: Colors.black.withValues(alpha: 0.49),
                ),
              ),

              // Content text
              const Padding(
                padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 60.0, bottom: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Create New Immersive Lesson',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        height: 1.3,
                        letterSpacing: 0.24,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Launch the VR canvas and start building interactive modules for your students.',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xD9FFFFFF),
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),

              // Launch arrow button
              Positioned(
                right: 16,
                bottom: 16,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.25),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Quick Action Grid ---
  Widget _buildQuickActionGrid() {
    return Column(
      children: [
        // Row with Create Lesson and Create Quiz (169px width each in Figma)
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                title: 'Create Lesson',
                badgeAsset: AppAssets.badgeCreateLesson,
                onTap: controller.onCreateLesson,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildActionCard(
                title: 'Create Quiz',
                badgeAsset: AppAssets.badgeCreateQuiz,
                onTap: controller.onCreateQuiz,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Full width Upload Content card (354px in Figma)
        _buildUploadCard(
          title: 'Upload Content',
          badgeAsset: AppAssets.badgeUploadContent,
          onTap: controller.onUploadContent,
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String badgeAsset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 112,
        decoration: BoxDecoration(
          color: const Color(0xFFE0F6FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exact Figma 37x37 Circular Badge
            Image.asset(
              badgeAsset,
              width: 37,
              height: 37,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadCard({
    required String title,
    required String badgeAsset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 112,
        decoration: BoxDecoration(
          color: const Color(0xFFE0F6FF),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exact Figma 37x37 Circular Badge
            Image.asset(
              badgeAsset,
              width: 37,
              height: 37,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1E),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Recent Lessons Section Header ---
  Widget _buildRecentLessonsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            'Recent Lessons Built',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF131B2E),
            ),
          ),
        ),
        GestureDetector(
          onTap: controller.onSeeAllLessons,
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'See All',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF127FD2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Recent Lessons Horizontal List ---
  Widget _buildRecentLessonsList() {
    return SizedBox(
      height: 247,
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.recentLessons.length,
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            final lesson = controller.recentLessons[index];
            return _buildLessonCard(lesson);
          },
        ),
      ),
    );
  }

  Widget _buildLessonCard(RecentLessonItem lesson) {
    return Container(
      width: 279,
      height: 247,
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFFE7E7E7),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Lesson Cover Image (128px height)
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: SizedBox(
              width: 279,
              height: 128,
              child: Image.asset(
                lesson.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFE0F6FF),
                  child: const Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: Color(0xFF127FD2),
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Details
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF131B2E),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  lesson.subtitle,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF454652),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time_rounded,
                      size: 13,
                      color: Color(0xFF767683),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      lesson.updatedTime,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF767683),
                      ),
                    ),
                    const Spacer(),

                    // Edit Button (37x37 circle with white edit pencil icon)
                    GestureDetector(
                      onTap: () => controller.onEditLesson(lesson),
                      child: Container(
                        width: 37,
                        height: 37,
                        decoration: const BoxDecoration(
                          color: Color(0xFF127FD2),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.edit_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Recent Quizzes Section Header ---
  Widget _buildRecentQuizzesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            'Recent Quizzes Built',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF131B2E),
            ),
          ),
        ),
        GestureDetector(
          onTap: controller.onSeeAllQuizzes,
          child: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'See All',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF127FD2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Recent Quizzes Horizontal List ---
  Widget _buildRecentQuizzesList() {
    return SizedBox(
      height: 275,
      child: Obx(
        () => ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          clipBehavior: Clip.none,
          itemCount: controller.recentQuizzes.length,
          separatorBuilder: (context, index) => const SizedBox(width: 14),
          itemBuilder: (context, index) {
            final quiz = controller.recentQuizzes[index];
            return _buildHomeQuizCard(quiz);
          },
        ),
      ),
    );
  }

  Widget _buildHomeQuizCard(TeacherQuizModel quiz) {
    const fontFamily = AppTextStyle.fontFamily;

    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: const Color(0xFFF0F0F0),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              offset: const Offset(0, 4),
              blurRadius: 6,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            // Row 1: Status Badge + Date + More Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      // Status Badge (ACTIVE or INACTIVE)
                      _buildStatusBadge(quiz.isActive),
                      const SizedBox(width: 6),

                      // Date
                      Flexible(
                        child: Text(
                          quiz.date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF717786),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // More Vert Options Menu
                GestureDetector(
                  onTap: () => controller.onQuizOptions(quiz),
                  child: const Padding(
                    padding: EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Color(0xFF717786),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // Primary Card Title: General Science / Physics (15px - 16px, w600 per ARCHITECTURE.md)
            Text(
              quiz.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
                letterSpacing: -0.1,
              ),
            ),
            const SizedBox(height: 2),

            // Subtitle: Chapter 1 / Motion (12px - 13px, w400 per ARCHITECTURE.md)
            Text(
              quiz.chapter,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF5F6368),
              ),
            ),
            const SizedBox(height: 2),

            // Class Subject Tag: Class 10 • Science (13px, w500, #127FD2 per ARCHITECTURE.md)
            Text(
              quiz.classSubject,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF127FD2),
                letterSpacing: 0.1,
              ),
            ),
            const SizedBox(height: 8),

            // Divider line
            Divider(
              height: 1,
              thickness: 0.8,
              color: const Color(0xFFE1E3E4).withValues(alpha: 0.5),
            ),
            const SizedBox(height: 8),

            // Stats Row: Questions & Duration (12px Counters per ARCHITECTURE.md)
            Wrap(
              spacing: 16,
              runSpacing: 6,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // Questions Stat
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.article_outlined,
                      size: 15,
                      color: Color(0xFF5F6368),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${quiz.questionCount} Questions',
                      style: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5F6368),
                      ),
                    ),
                  ],
                ),

                // Duration Stat
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 15,
                      color: Color(0xFF5F6368),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${quiz.durationMinutes} min',
                      style: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5F6368),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Assignment Container (Assigned to Class 10-A or Not assigned yet)
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  if (quiz.isAssigned) ...[
                    const Icon(
                      Icons.assignment_ind_outlined,
                      size: 14,
                      color: Color(0xFF127FD2),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'Assigned to ${quiz.assignedClass}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                    ),
                  ] else ...[
                    const Icon(
                      Icons.hourglass_empty,
                      size: 13,
                      color: Color(0xFF717786),
                    ),
                    const SizedBox(width: 6),
                    const Expanded(
                      child: Text(
                        'Not assigned yet',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF717786),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Regenerate Quiz Button (Gradient Pill)
            GestureDetector(
              onTap: () => controller.onRegenerateQuiz(quiz),
              child: Container(
                height: 38,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFFE0F6FF),
                      Color(0xFFFFFFFF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(
                    color: const Color(0xFFE0F6FF),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      offset: const Offset(0, 2),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.refresh,
                      size: 16,
                      color: Color(0xFF127FD2),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Regenerate Quiz',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF191C1D),
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

  Widget _buildStatusBadge(bool isActive) {
    const fontFamily = AppTextStyle.fontFamily;

    if (isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: const Color(0xFFE0F6FF),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 5,
              height: 5,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0059BB),
              ),
            ),
            const SizedBox(width: 4),
            const Text(
              'ACTIVE',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: Color(0xFF004493),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE1E3E4),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF717786),
            ),
          ),
          const SizedBox(width: 4),
          const Text(
            'INACTIVE',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: Color(0xFF414754),
            ),
          ),
        ],
      ),
    );
  }
}
