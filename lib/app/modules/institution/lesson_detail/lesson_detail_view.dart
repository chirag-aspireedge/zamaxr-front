import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'lesson_detail_controller.dart';
import 'lesson_detail_model.dart';

class LessonDetailView extends GetView<LessonDetailController> {
  const LessonDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LessonDetailController>()) {
      Get.put(LessonDetailController());
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Obx(() {
          final data = controller.lessonData.value;
          if (data == null) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF127FD2)),
            );
          }

          return Column(
            children: [
              // Top App Bar (Exact matching Figma / Image)
              _buildTopAppBar(context, data),

              // Scrollable Content Body
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Lesson Header Information
                      _buildLessonHeader(data),
                      const SizedBox(height: 16),

                      // Section 1: About This Lesson
                      _buildSectionAbout(data),
                      const SizedBox(height: 20),

                      // Section 2: Documents
                      if (data.documents.isNotEmpty) ...[
                        _buildSectionDocuments(data),
                        const SizedBox(height: 20),
                      ],

                      // Section 3: Videos
                      if (data.videos.isNotEmpty) ...[
                        _buildSectionVideos(data),
                        const SizedBox(height: 20),
                      ],

                      // Section 4: Audio
                      if (data.audio != null) ...[
                        _buildSectionAudio(data.audio!),
                        const SizedBox(height: 20),
                      ],

                      // Section 5: Images
                      if (data.images.isNotEmpty) ...[
                        _buildSectionImages(data),
                        const SizedBox(height: 20),
                      ],

                      // Section 6: Assessments
                      if (data.quiz != null) ...[
                        _buildSectionAssessments(data.quiz!),
                        const SizedBox(height: 20),
                      ],

                      // Section 7: Immersive Content (AR & VR)
                      if (data.arExperience != null || data.vrAsset != null) ...[
                        _buildSectionImmersive(data),
                        const SizedBox(height: 24),
                      ],

                      // Bottom Edit Lesson Button
                      _buildEditLessonButton(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top App Bar: "Science" on left & "Assigned Teacher" with Gradient Avatar on right
  // ---------------------------------------------------------------------------
  Widget _buildTopAppBar(BuildContext context, LessonDetailModel data) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Subject Title ("Science")
          GestureDetector(
            onTap: () {
              if (Navigator.of(context).canPop()) {
                Get.back();
              }
            },
            child: Text(
              data.subject,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF131313),
                letterSpacing: -0.4,
              ),
            ),
          ),

          // Right: Assigned Teacher label + Gradient Avatar Button
          GestureDetector(
            onTap: () {
              Get.snackbar(
                'Assigned Teacher',
                data.teacherName,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF0E3856),
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
                borderRadius: 12,
                duration: const Duration(seconds: 2),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Assigned Teacher',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF131313),
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF50B2DD), Color(0xFF12639F)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Remix.user_line,
                      size: 16,
                      color: Colors.white,
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

  // ---------------------------------------------------------------------------
  // Lesson Header: Title, Category, Edit Button & Status Badges
  // ---------------------------------------------------------------------------
  Widget _buildLessonHeader(LessonDetailModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row with Edit button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF131313),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    data.category,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF335E7D),
                    ),
                  ),
                ],
              ),
            ),

            // Circular Edit Pencil Button
            GestureDetector(
              onTap: controller.onEditLesson,
              child: Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE0F6FF),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Remix.pencil_fill,
                    size: 14,
                    color: Color(0xFF127FD2),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        // Status pill & Visible to Students
        Row(
          children: [
            // Published Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F6FF),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: Color(0xFF10B981),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    data.status,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF131313),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 14),

            // Visible to Students
            if (data.isVisibleToStudents)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Remix.eye_line,
                    size: 14,
                    color: Color(0xFF335E7D),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Visible to Students',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF335E7D),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1: About This Lesson
  // ---------------------------------------------------------------------------
  Widget _buildSectionAbout(LessonDetailModel data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Remix.information_line,
                size: 16,
                color: Color(0xFF127FD2),
              ),
              SizedBox(width: 8),
              Text(
                'About This Lesson',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF131313),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            data.description,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF335E7D),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2: Documents
  // ---------------------------------------------------------------------------
  Widget _buildSectionDocuments(LessonDetailModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          icon: Remix.file_text_line,
          title: 'Documents',
        ),
        const SizedBox(height: 8),
        ...data.documents.map((doc) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
              ),
              child: Row(
                children: [
                  // PDF badge
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F6FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.iconMediaPdf,
                        width: 16,
                        height: 16,
                        colorFilter: const ColorFilter.mode(
                          Color(0xFF127FD2),
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // File Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doc.title,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF131313),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          doc.size,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF476083),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action: View / Preview Button
                  GestureDetector(
                    onTap: () => controller.onOpenDocument(doc),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE0F6FF),
                      ),
                      child: const Center(
                        child: Icon(
                          Remix.eye_line,
                          size: 14,
                          color: Color(0xFF127FD2),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  // Action: Download Button
                  GestureDetector(
                    onTap: () => controller.onDownloadDocument(doc),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE0F6FF),
                      ),
                      child: const Center(
                        child: Icon(
                          Remix.download_2_line,
                          size: 14,
                          color: Color(0xFF127FD2),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 3: Videos
  // ---------------------------------------------------------------------------
  Widget _buildSectionVideos(LessonDetailModel data) {
    final video = data.videos.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle(
              icon: Remix.video_line,
              title: 'Videos',
            ),
            Text(
              '${data.videos.length} Video',
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF127FD4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Video Player Box
        GestureDetector(
          onTap: () => controller.onPlayVideo(video),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x08000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Video Screen Area
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(11),
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF0E3856), Color(0xFF1B6B9E)],
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Center Play Button
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFF8F9FA).withValues(alpha: 0.9),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x26000000),
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Remix.play_fill,
                            size: 20,
                            color: Color(0xFF0059BB),
                          ),
                        ),
                      ),

                      // Duration Badge (Bottom Right)
                      Positioned(
                        right: 8,
                        bottom: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.7),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            video.duration,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Video Meta
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF131313),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        video.subtitle,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF335E7D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4: Audio Player
  // ---------------------------------------------------------------------------
  Widget _buildSectionAudio(LessonAudio audio) {
    final isPlaying = controller.isAudioPlaying.value;
    final progress = controller.audioProgress.value;
    final currTime = controller.currentAudioTime.value;
    final remTime = controller.remainingAudioTime.value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          icon: Remix.volume_up_line,
          title: 'Audio',
        ),
        const SizedBox(height: 8),

        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
          ),
          child: Column(
            children: [
              // Top row: Play button & Audio title
              Row(
                children: [
                  GestureDetector(
                    onTap: controller.toggleAudioPlay,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFE0F6FF),
                      ),
                      child: Center(
                        child: Icon(
                          isPlaying ? Remix.pause_fill : Remix.play_fill,
                          size: 18,
                          color: const Color(0xFF127FD2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          audio.title,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF131313),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          audio.duration,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF335E7D),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Audio progress bar
              Container(
                height: 5,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F6FF),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF127FD4),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              // Timestamp labels
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currTime,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF476083),
                    ),
                  ),
                  Text(
                    remTime,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF476083),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 5: Images
  // ---------------------------------------------------------------------------
  Widget _buildSectionImages(LessonDetailModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildSectionTitle(
              icon: Remix.image_line,
              title: 'Images',
            ),
            GestureDetector(
              onTap: controller.onViewAllImages,
              child: Row(
                children: const [
                  Text(
                    'View All',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF127FD4),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 10,
                    color: Color(0xFF127FD4),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        // Horizontal List of Image Cards
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: data.images.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final img = data.images[index];
              return GestureDetector(
                onTap: () => controller.onImageTap(img),
                child: Container(
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF50B2DD).withValues(alpha: 0.7),
                        const Color(0xFF0E3856),
                      ],
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x08000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Image label badge at bottom
                      Positioned(
                        left: 8,
                        right: 8,
                        bottom: 8,
                        child: Text(
                          img.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 6: Assessments / Quiz
  // ---------------------------------------------------------------------------
  Widget _buildSectionAssessments(LessonQuizItem quiz) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          icon: Remix.questionnaire_line,
          title: 'Assessments',
        ),
        const SizedBox(height: 8),

        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                // Left Accent Indicator
                Container(
                  width: 6,
                  color: const Color(0xFF0E3856),
                ),

                // Content
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title and Attached badge
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              quiz.title,
                              style: const TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF131313),
                              ),
                            ),
                            if (quiz.isAttached)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE0F6FF),
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                                child: const Text(
                                  'Attached',
                                  style: TextStyle(
                                    fontFamily: AppTextStyle.fontFamily,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF127FD2),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),

                        Text(
                          quiz.subtitle,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF335E7D),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // View Quiz action link
                        GestureDetector(
                          onTap: () => controller.onViewQuiz(quiz),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'View Quiz',
                                style: TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF127FD2),
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 10,
                                color: Color(0xFF127FD2),
                              ),
                            ],
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
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 7: Immersive Content (AR / VR Cards)
  // ---------------------------------------------------------------------------
  Widget _buildSectionImmersive(LessonDetailModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          svgAsset: AppAssets.iconMedia3D,
          title: 'Immersive Content',
        ),
        const SizedBox(height: 8),

        Row(
          children: [
            // Card 1: AR Experience
            if (data.arExperience != null)
              Expanded(
                child: _buildImmersiveCard(
                  item: data.arExperience!,
                  onTap: controller.onLaunchAR,
                ),
              ),

            const SizedBox(width: 12),

            // Card 2: VR Asset
            if (data.vrAsset != null)
              Expanded(
                child: _buildImmersiveCard(
                  item: data.vrAsset!,
                  onTap: controller.onLaunchVR,
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildImmersiveCard({
    required LessonImmersiveItem item,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
        ),
        child: Stack(
          children: [
            // Top Right Gradient Corner
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(9),
                    bottomLeft: Radius.circular(9999),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Color(0xFFE0F6FF), Color(0x00E0F6FF)],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFE0F6FF),
                    ),
                    child: Center(
                      child: item.isVR
                          ? SvgPicture.asset(
                              AppAssets.iconVrHeadset,
                              width: 15,
                              height: 15,
                              colorFilter: const ColorFilter.mode(
                                Color(0xFF127FD2),
                                BlendMode.srcIn,
                              ),
                            )
                          : SvgPicture.asset(
                              AppAssets.iconMedia3D,
                              width: 15,
                              height: 15,
                              colorFilter: const ColorFilter.mode(
                                Color(0xFF127FD2),
                                BlendMode.srcIn,
                              ),
                            ),
                    ),
                  ),

                  // Title
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF131313),
                    ),
                  ),

                  // Action Tag (e.g. VIEW AR / LAUNCH VR)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        item.actionText,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: Color(0xFF127FD4),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Remix.external_link_line,
                        size: 10,
                        color: Color(0xFF127FD4),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section Title Helper
  // ---------------------------------------------------------------------------
  Widget _buildSectionTitle({
    IconData? icon,
    String? svgAsset,
    required String title,
  }) {
    return Row(
      children: [
        if (svgAsset != null)
          SvgPicture.asset(
            svgAsset,
            width: 15,
            height: 15,
            colorFilter: const ColorFilter.mode(
              Color(0xFF127FD2),
              BlendMode.srcIn,
            ),
          )
        else if (icon != null)
          Icon(
            icon,
            size: 15,
            color: const Color(0xFF127FD2),
          ),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF131313),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Bottom Edit Lesson Button (Rectangle 7: 318x54 Gradient Pill)
  // ---------------------------------------------------------------------------
  Widget _buildEditLessonButton() {
    return Center(
      child: GestureDetector(
        onTap: controller.onEditLesson,
        child: Container(
          width: 318,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(52),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF56B9E3),
                Color(0xFF0E5E9B),
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Edit Lesson',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
