import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'subjects_controller.dart';
import 'subjects_model.dart';

class SubjectsView extends GetView<SubjectsController> {
  const SubjectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Row (Subjects Title & Circular + Add Button)
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 12.0),
                child: _buildHeader(),
              ),

              // Search Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 4.0, 24.0, 20.0),
                child: _buildSearchBar(),
              ),

              // Subjects Cards List
              Expanded(
                child: Obx(() {
                  final subjects = controller.filteredSubjects;
                  if (subjects.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 40.0),
                    itemCount: subjects.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      final item = subjects[index];
                      return _buildSubjectCard(item);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // App Bar Header (Subjects title & + button)
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Subjects',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0E3856),
          ),
        ),

        // Circular Add Button (Ellipse 19 in Figma: 38x38, shadow, #127FD2 icon)
        GestureDetector(
          onTap: controller.onAddSubject,
          child: Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: SvgPicture.asset(
                AppAssets.iconAddBlue,
                width: 14,
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

  // Search Bar (Rectangle 38 in Figma: 354x44, #E0F6FF border, shadow)
  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(22),
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
              padding: const EdgeInsets.only(left: 15, right: 8),
              child: SvgPicture.asset(
                AppAssets.iconSearchTeal,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF335E7D),
                  BlendMode.srcIn,
                ),
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 43,
              minHeight: 44,
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
                    size: 18,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              );
            }),
            suffixIconConstraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 44,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.only(right: 14),
          ),
        ),
      ),
    );
  }

  // Subject Card matching exact Figma design
  Widget _buildSubjectCard(SubjectItem item) {
    final isActive = item.status == 'Active';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.onSubjectTap(item),
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row (Icon box + Title/Badge/Subtitle + Chevron)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Subject Icon Container (48x48, radius 12)
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFFE0F6FF)
                            : const Color(0xFFE1E3E4),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: _buildSubjectIcon(item),
                      ),
                    ),
                    const SizedBox(width: 14),

                    // Title, Status badge & Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF131313),
                                  height: 1.2,
                                ),
                              ),
                              const SizedBox(width: 8),

                              // Status Badge (Active: #E0F6FF / #127FD2, Draft: #E1E3E4 / #414754)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? const Color(0xFFE0F6FF)
                                      : const Color(0xFFE1E3E4),
                                  borderRadius: BorderRadius.circular(9999),
                                ),
                                child: Text(
                                  item.status,
                                  style: TextStyle(
                                    fontFamily: AppTextStyle.fontFamily,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: isActive
                                        ? const Color(0xFF127FD2)
                                        : const Color(0xFF414754),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.subtitle,
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: isActive
                                  ? const Color(0xFF335E7D)
                                  : const Color(0xFF414754),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Chevron Right Button (26x26, #E0F6FF)
                    Container(
                      width: 26,
                      height: 26,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0F6FF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.iconChevronRightBlue,
                          width: 7,
                          height: 11,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Middle Row (Teacher on left, Lessons & Students count on right)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Teacher Info
                    _buildTeacherInfo(item),

                    // Stat badges (Lessons & Students)
                    Row(
                      children: [
                        // Lessons Box
                        _buildStatPill(
                          svgAsset: AppAssets.iconClassLessonsFigma,
                          count: '${item.lessonsCount}',
                          isUnassigned: item.isUnassigned,
                        ),
                        const SizedBox(width: 8),

                        // Students Box
                        _buildStatPill(
                          svgAsset: AppAssets.iconClassStudentsFigma,
                          count: '${item.studentsCount}',
                          isUnassigned: item.isUnassigned,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                // Course Progress Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Course Progress',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: item.isUnassigned
                            ? const Color(0xFF717786)
                            : const Color(0xFF335E7D),
                      ),
                    ),
                    Text(
                      '${(item.progress * 100).toInt()}%',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: item.progress > 0
                            ? const Color(0xFF127FD2)
                            : const Color(0xFF717786),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Progress Bar
                Container(
                  height: 6,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEEEF),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: item.progress.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF127FD2),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectIcon(SubjectItem item) {
    if (item.iconType == 'science') {
      return SvgPicture.asset(
        AppAssets.iconClassScience,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          Color(0xFF127FD2),
          BlendMode.srcIn,
        ),
      );
    } else if (item.iconType == 'math') {
      return SvgPicture.asset(
        AppAssets.iconClassMath,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          Color(0xFF127FD2),
          BlendMode.srcIn,
        ),
      );
    } else {
      // Social Science / Humanities icon
      return SvgPicture.asset(
        AppAssets.iconClassSocialScience,
        width: 24,
        height: 24,
        colorFilter: const ColorFilter.mode(
          Color(0xFF335E7D),
          BlendMode.srcIn,
        ),
      );
    }
  }

  Widget _buildTeacherInfo(SubjectItem item) {
    if (item.isUnassigned) {
      return Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: Color(0xFFE7E8E9),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Remix.user_unfollow_line,
                size: 13,
                color: Color(0xFF414754),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            item.teacherName,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF717786),
            ),
          ),
        ],
      );
    }

    if (item.teacherCount > 1) {
      // Overlapping avatars
      return Row(
        children: [
          SizedBox(
            width: 38,
            height: 24,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AppAssets.teacherAvatar,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 14,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        AppAssets.userAvatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            item.teacherName,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF335E7D),
            ),
          ),
        ],
      );
    }

    // Single teacher
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              AppAssets.teacherAvatar,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          item.teacherName,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF335E7D),
          ),
        ),
      ],
    );
  }

  Widget _buildStatPill({
    String? svgAsset,
    IconData? icon,
    required String count,
    required bool isUnassigned,
  }) {
    final color =
        isUnassigned ? const Color(0xFF717786) : const Color(0xFF414754);

    return Container(
      height: 20,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0F6FF), width: 0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (svgAsset != null)
            SvgPicture.asset(
              svgAsset,
              width: 12,
              height: 10,
              colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn,
              ),
            )
          else if (icon != null)
            Icon(
              icon,
              size: 11,
              color: color,
            ),
          const SizedBox(width: 4),
          Text(
            count,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Remix.book_open_line,
            size: 48,
            color: const Color(0xFF127FD2).withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          const Text(
            'No subjects found',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF0E3856),
            ),
          ),
        ],
      ),
    );
  }
}
