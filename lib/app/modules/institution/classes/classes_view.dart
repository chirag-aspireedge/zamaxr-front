import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';
import 'classes_controller.dart';
import 'classes_model.dart';



class ClassesView extends GetView<ClassesController> {
  const ClassesView({super.key});

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
            // Safe Area & Scrollable Content
            SafeArea(
              child: Column(
                children: [
                  // App Bar / Header with Title and Add Action
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 8.0),
                    child: _buildAppBar(),
                  ),


                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
                    child: _buildSearchBar(),
                  ),

                  // Filter Chips
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: _buildFilterChips(),
                  ),

                  const SizedBox(height: 16),

                  // Classes List View
                  Expanded(
                    child: Obx(() {
                      final classes = controller.filteredClasses;
                      if (classes.isEmpty) {
                        return _buildEmptyState();
                      }
                      return ListView.separated(
                        padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 100.0),
                        itemCount: classes.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                        itemBuilder: (context, index) {
                          final item = classes[index];
                          return _buildClassCard(item);
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

  // Header with Title and Add Action Card
  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Screen Title
        const Text(
          'Classes',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0E3856),
          ),
        ),

        // Add Action Button Card
        _buildAddClassButton(),
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
              color: Color(0x4D113311),
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 15, right: 8),
              child: Icon(
                Remix.search_2_line,
                size: 20,
                color: Color(0xFF0E3856),
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

  // Horizontal Filter Chips
  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Obx(
        () => Row(
          children: controller.filterTabs.map((filter) {
            final isSelected = controller.selectedFilter.value == filter;
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () => controller.setFilter(filter),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 34,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF127FD2)
                        : const Color(0xFFEFEFEF),
                    borderRadius: BorderRadius.circular(17),
                    border: isSelected
                        ? null
                        : Border.all(color: const Color(0xFFF2F2F2), width: 1),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    filter,
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 15,
                      fontWeight:
                          isSelected ? FontWeight.w500 : FontWeight.w400,
                      color: isSelected
                          ? AppColor.white
                          : const Color(0xFF131313),
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

  // Class Detail Card (120px height)
  Widget _buildClassCard(ClassDetailItem item) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.CLASS_DETAIL,
        arguments: item,
      ),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
        ),
        child: Stack(
          children: [

          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 44.0, 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Top Header Row: Subject Icon Circle (36x36) + (Class Grade & Subject Name)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Circular Subject Icon Badge (36x36 in Figma)
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0F6FF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          item.iconType == 'science'
                              ? AppAssets.iconClassScience
                              : AppAssets.iconClassMath,
                          width: 18,
                          height: 18,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF127FD2),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Class Grade & Subject Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            item.classGrade,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF0E3856),
                              height: 1.15,
                            ),
                          ),
                          Text(
                            item.subject,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF131313),
                              height: 1.15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Teacher Name Row (Starts at left: 10px, directly below circle)
                Row(
                  children: [
                    const Icon(
                      Remix.user_3_line,
                      size: 13,
                      color: Color(0xFF131313),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.teacherName,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF131313),
                      ),
                    ),
                  ],
                ),

                // Students Count Row (Starts at left: 10px, directly below circle)
                Row(
                  children: [
                    const Icon(
                      Remix.group_line,
                      size: 14,
                      color: Color(0xFF131313),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${item.studentCount} Students',
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF131313),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),

          // Forward Arrow Circular Badge on the Right (Ellipse 31/32 in Figma)
          Positioned(
            right: 12,
            bottom: 12,
            child: Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                color: Color(0xFFE0F6FF),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Remix.arrow_right_s_line,
                  size: 16,
                  color: Color(0xFF127FD2),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}



  // Action Button "Add Class" in App Bar
  Widget _buildAddClassButton() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.CREATE_CLASS);
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
            Remix.add_line,
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
            Remix.book_read_line,
            size: 48,
            color: const Color(0xFF127FD2).withValues(alpha: 0.4),
          ),
          const SizedBox(height: 12),
          const Text(
            'No classes found',
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
