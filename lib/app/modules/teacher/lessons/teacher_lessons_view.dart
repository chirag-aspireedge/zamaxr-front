import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import 'teacher_lessons_controller.dart';

class TeacherLessonsView extends GetView<TeacherLessonsController> {
  const TeacherLessonsView({super.key});

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
          child: Column(
            children: [
              // Top Bar (Back button, Search, Notifications)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
                child: _buildTopBar(),
              ),

              // Filter Tabs (All, Draft, Published, Archived)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: _buildFilterTabs(),
              ),

              const SizedBox(height: 16),

              // Lesson Cards List
              Expanded(
                child: Obx(
                  () {
                    final lessons = controller.filteredLessons;
                    if (lessons.isEmpty) {
                      return const Center(
                        child: Text(
                          'No lessons found',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 14,
                            color: Color(0xFF838383),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      padding: const EdgeInsets.fromLTRB(22.0, 8.0, 22.0, 100.0),
                      physics: const BouncingScrollPhysics(),
                      itemCount: lessons.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final lesson = lessons[index];
                        return _buildLessonCard(lesson);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Top Bar ---
  Widget _buildTopBar() {
    return Row(
      children: [
        // Search Field
        Expanded(
          child: Container(
            height: 44,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: const Color(0xFFE0F6FF),
                width: 1,
              ),
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
                onChanged: controller.onSearch,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 13,
                  color: Color(0xFF131313),
                ),
                decoration: const InputDecoration(
                  hintText: 'Search class...',
                  hintStyle: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Color(0x4F000000),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Notifications Button (44x44 circular button)
        GestureDetector(
          onTap: controller.onNotifications,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFE0F6FF),
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/icons/icon_notification_unread_blue.svg',
                width: 22,
                height: 22,
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Add Lesson Button (44x44 circular button)
        GestureDetector(
          onTap: controller.onCreateLesson,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFE0F6FF),
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.add_rounded,
                color: Color(0xFF1567A2),
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Filter Tabs ---
  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Obx(
        () => Row(
          children: controller.filterTabs.map((tab) {
            final isSelected = controller.selectedFilter.value == tab;
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () => controller.setFilter(tab),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF127FD2)
                        : const Color(0xFFE0F6FF).withValues(alpha: 0.36),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Center(
                    child: Text(
                      tab,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.6,
                        color: isSelected ? Colors.white : const Color(0xFF717171),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // --- Lesson Card ---
  Widget _buildLessonCard(TeacherLessonModel lesson) {
    return GestureDetector(
      onTap: () => controller.onLessonTap(lesson),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFC6C5D4).withValues(alpha: 0.5),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x081A237E),
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail Image (96x96 with 8px radius)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 96,
              height: 96,
              child: Image.asset(
                lesson.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFEAEDFF),
                  child: const Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: Color(0xFF127FD2),
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Row: Subject Chapter Badge & Three-Dot Menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFF127FD2).withValues(alpha: 0.23),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: Text(
                          lesson.subjectChapter,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.6,
                            color: Color(0xFF127FD2),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () => controller.onLessonMenu(lesson),
                      behavior: HitTestBehavior.opaque,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 4.0, bottom: 4.0),
                        child: Icon(
                          Icons.more_vert,
                          size: 20,
                          color: Color(0xFF454652),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Lesson Title
                Text(
                  lesson.title,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF131B2E),
                    height: 1.25,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 12),

                // Bottom Row: Updated Time & Status Badge (Flexible to prevent any overflow on scaled text)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        lesson.updatedTime,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF838383),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    _buildStatusBadge(lesson.status),
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

  // --- Status Badge (Published, Draft, Archived) ---
  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    Color dotColor;

    if (status.toLowerCase() == 'published') {
      bgColor = const Color(0xFFA8EFF0).withValues(alpha: 0.3);
      textColor = const Color(0xFF006874);
      dotColor = const Color(0xFF006874);
    } else if (status.toLowerCase() == 'draft') {
      bgColor = const Color(0xFF127FD2).withValues(alpha: 0.23);
      textColor = const Color(0xFF127FD2);
      dotColor = const Color(0xFF127FD2);
    } else {
      bgColor = const Color(0xFF838383).withValues(alpha: 0.15);
      textColor = const Color(0xFF717171);
      dotColor = const Color(0xFF717171);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            status,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: textColor,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
