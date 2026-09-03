import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';
import 'teachers_controller.dart';
import 'teachers_model.dart';


class TeachersView extends GetView<TeachersController> {
  const TeachersView({super.key});

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
        body: Stack(
          children: [
            // Main Content Area
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar / Header with Add Teacher button
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 8.0),
                    child: _buildAppBar(),
                  ),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 16.0),
                    child: _buildSearchBar(),
                  ),

                  // Section Title Counter ("Total 90 Teachers")
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Obx(
                      () => Text(
                        'Total ${controller.filteredTeachers.length > 4 ? controller.filteredTeachers.length : 90} Teachers',
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF0E3856),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Teachers List View
                  Expanded(
                    child: Obx(() {
                      final teachers = controller.filteredTeachers;
                      if (teachers.isEmpty) {
                        return _buildEmptyState();
                      }
                      return ListView.separated(
                        padding:
                            const EdgeInsets.fromLTRB(24.0, 4.0, 24.0, 100.0),
                        itemCount: teachers.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final item = teachers[index];
                          return _buildTeacherCard(item);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header with Title and Add Teacher Action Button
  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Screen Title
        const Text(
          'Teacher’s Directory',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0E3856),
          ),
        ),

        // Add Teacher Action Button Card
        _buildAddTeacherButton(),
      ],
    );
  }


  // Pill Search Bar
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
              color: Color(0x4F000000),
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 15, right: 8),
              child: Icon(
                Remix.search_2_line,
                size: 20,
                color: Color(0xFF5F6368),
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

  // Teacher Card (83px height)
  Widget _buildTeacherCard(TeacherItem item) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.TEACHER_DETAIL, arguments: item);
      },
      child: Container(
        constraints: const BoxConstraints(minHeight: 83),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
        ),
        child: Row(
          children: [
            // Avatar with Online Status Indicator (54x54 in Figma)

          SizedBox(
            width: 54,
            height: 54,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Avatar Image
                ClipOval(
                  child: Image.asset(
                    AppAssets.teacherAvatar,
                    width: 54,
                    height: 54,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 54,
                      height: 54,
                      color: const Color(0xFFE7E8E9),
                      child: const Icon(
                        Remix.user_3_line,
                        color: Color(0xFF0E3856),
                        size: 26,
                      ),
                    ),
                  ),
                ),

                // Online/Offline Status Indicator Dot (12x12)
                Positioned(
                  right: -1,
                  bottom: -1,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: item.isOnline
                          ? const Color(0xFF20E679)
                          : const Color(0xFFE1E3E4),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColor.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 14),

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Teacher Name
                Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0E3856),
                    height: 1.2,
                  ),
                ),


                const SizedBox(height: 1),

                // Subject Title
                Text(
                  item.subjectTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF335E7D),
                    height: 1.2,
                  ),
                ),

                const SizedBox(height: 2),

                // Classes Count Row with Graduation Cap Icon
                Row(
                  children: [
                    SvgPicture.asset(
                      AppAssets.iconGraduationCap,
                      width: 13,
                      height: 11,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF335E7D),
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text(
                        item.classCountText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF335E7D),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Right Chevron Arrow (7.4x12 in Figma)
          const Icon(
            Remix.arrow_right_s_line,
            size: 18,
            color: Color(0xFF127FD2),
          ),
        ],
      ),
    ),
  );
}



  // Action Button "Add Teacher" in App Bar
  Widget _buildAddTeacherButton() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.CREATE_TEACHER);
      },
      child: Container(

        width: 44,
        height: 44,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF2C83B9),
              Color(0xFF53B6E0),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26127FD2),
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: const Center(
          child: Icon(
            Remix.user_add_line,
            size: 20,
            color: AppColor.white,
          ),
        ),
      ),
    );
  }


  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Remix.user_search_line,
            size: 48,
            color: const Color(0xFF127FD2).withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          const Text(
            'No teachers found',
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
