import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'lessons_controller.dart';
import 'lessons_model.dart';

class LessonsView extends GetView<LessonsController> {
  const LessonsView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<LessonsController>()) {
      Get.put(LessonsController());
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Header & Search Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _buildHeader(),
                  const SizedBox(height: 12),
                  _buildLessonsBadge(),
                  const SizedBox(height: 16),
                  _buildSearchBar(),
                  const SizedBox(height: 8),
                ],
              ),
            ),

            // Lessons List
            Expanded(
              child: Obx(() {
                final lessons = controller.filteredLessons;
                if (lessons.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.separated(
                  padding: const EdgeInsets.only(
                    left: 24,
                    right: 24,
                    top: 4,
                    bottom: 32,
                  ),
                  itemCount: lessons.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = lessons[index];
                    return _buildLessonCard(item);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Header: Title, Grade & 3-Dots Action Button
  // ---------------------------------------------------------------------------
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Grade Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  controller.subjectTitle.value,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF131313),
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Obx(
                () => Text(
                  controller.gradeText.value,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF335E7D),
                  ),
                ),
              ),
            ],
          ),
        ),

        // Circular 3-Dots Button (36x36)
        GestureDetector(
          onTap: controller.onMoreMenuTap,
          child: Container(
            width: 36,
            height: 36,
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
            child: Center(
              child: SvgPicture.asset(
                AppAssets.iconMoreVertical,
                width: 3.5,
                height: 14,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF127FD2),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Pill Badge: "12 LESSONS"
  // ---------------------------------------------------------------------------
  Widget _buildLessonsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F6FF),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            AppAssets.iconClassLessonsFigma,
            width: 12,
            height: 9.5,
            colorFilter: const ColorFilter.mode(
              Color(0xFF127FD2),
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
          Obx(
            () => Text(
              '${controller.totalLessonsCount.value} LESSONS',
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
                color: Color(0xFF127FD2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Search Bar (354x42, #E0F6FF border, Shadow)
  // ---------------------------------------------------------------------------
  Widget _buildSearchBar() {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: const Color(0xFFE0F6FF), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: TextField(
          controller: controller.searchController,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF0E3856),
          ),
          decoration: InputDecoration(
            isDense: true,
            hintText: 'Search teacher',
            hintStyle: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: Color(0x4D113311),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 14, right: 8),
              child: SvgPicture.asset(
                AppAssets.iconSearchTeal,
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF335E7D),
                  BlendMode.srcIn,
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 40,
              minHeight: 42,
            ),
            suffixIcon: Obx(() {
              if (controller.searchQuery.value.isEmpty) {
                return const SizedBox.shrink();
              }
              return GestureDetector(
                onTap: () {
                  controller.searchController.clear();
                  controller.searchQuery.value = '';
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 14),
                  child: Icon(
                    Remix.close_circle_fill,
                    size: 16,
                    color: Color(0xFF335E7D),
                  ),
                ),
              );
            }),
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Lesson Card: Lesson 01, Cell Structure, Media Icons, Status Pill
  // ---------------------------------------------------------------------------
  Widget _buildLessonCard(LessonItem item) {
    return GestureDetector(
      onTap: () => controller.onLessonTap(item),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Subtitle Tag: e.g. "LESSON 01"
            Text(
              item.lessonNumber,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: Color(0xFF127FD2),
              ),
            ),
            const SizedBox(height: 4),

            // Lesson Title: e.g. "Cell Structure"
            Text(
              item.title,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF131313),
                height: 1.25,
              ),
            ),
            const SizedBox(height: 4),

            // Chapter and Duration: e.g. "Chapter 1 • 15 min"
            Text(
              item.chapterDurationText,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF335E7D),
              ),
            ),
            const SizedBox(height: 10),

            // Divider Line
            const Divider(
              color: Color(0xFFE3E3E3),
              height: 1,
              thickness: 0.6,
            ),
            const SizedBox(height: 10),

            // Bottom Row: Media Icons on left, Status Pill on right
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Media icons list
                Row(
                  children: item.mediaTypes
                      .map((mediaType) => Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: _buildMediaIcon(item, mediaType),
                          ))
                      .toList(),
                ),

                // Status Pill
                _buildStatusPill(item),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Media Icon (PDF, Video, Audio, 3D Cube, Quiz)
  // ---------------------------------------------------------------------------
  Widget _buildMediaIcon(LessonItem item, LessonMediaType type) {
    String assetPath;
    switch (type) {
      case LessonMediaType.pdf:
        assetPath = AppAssets.iconMediaPdf;
        break;
      case LessonMediaType.video:
        assetPath = AppAssets.iconMediaVideo;
        break;
      case LessonMediaType.audio:
        assetPath = AppAssets.iconMediaAudio;
        break;
      case LessonMediaType.cube3d:
        assetPath = AppAssets.iconMedia3D;
        break;
      case LessonMediaType.quiz:
        assetPath = AppAssets.iconMediaQuiz;
        break;
    }

    return GestureDetector(
      onTap: () => controller.onMediaTap(item, type),
      child: SvgPicture.asset(
        assetPath,
        width: 15,
        height: 15,
        colorFilter: const ColorFilter.mode(
          Color(0xFF414754),
          BlendMode.srcIn,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Status Pill: PUBLISHED / DRAFT
  // ---------------------------------------------------------------------------
  Widget _buildStatusPill(LessonItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F6FF),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Text(
        item.status,
        style: const TextStyle(
          fontFamily: AppTextStyle.fontFamily,
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF127FD2),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Empty State
  // ---------------------------------------------------------------------------
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Remix.book_open_line,
            size: 40,
            color: const Color(0xFF127FD2).withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          const Text(
            'No lessons found',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0E3856),
            ),
          ),
        ],
      ),
    );
  }
}
