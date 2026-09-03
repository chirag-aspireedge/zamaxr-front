import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/utils/app_assets.dart';
import '../profile/teacher_profile_view.dart';
import '../home/teacher_home_view.dart';
import '../lessons/teacher_lessons_view.dart';
import '../students/teacher_students_view.dart';
import 'teacher_dashboard_controller.dart';

class TeacherDashboardView extends GetView<TeacherDashboardController> {
  const TeacherDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Stack(
        children: [
          // Tab views
          Obx(
            () => IndexedStack(
              index: controller.currentTabIndex.value,
              children: const [
                TeacherHomeView(),
                TeacherLessonsView(),
                TeacherStudentsView(),
                TeacherProfileView(),
              ],
            ),
          ),

          // Floating Bottom Navigation Bar (Rectangle 17 in Figma)
          Positioned(
            left: 24,
            right: 24,
            bottom: 24,
            child: _buildFloatingBottomNav(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingBottomNav() {
    return Container(
      height: 61,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(30.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40091E42), // 0px 4px 8px -2px rgba(9, 30, 66, 0.25)
            blurRadius: 8,
            spreadRadius: -2,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30.5),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                index: 0,
                iconAsset: AppAssets.teacherNavHome,
              ),
              _buildNavItem(
                index: 1,
                iconAsset: AppAssets.teacherNavBook,
              ),
              _buildNavItem(
                index: 2,
                iconAsset: AppAssets.teacherNavScreen,
              ),
              _buildNavItem(
                index: 3,
                iconAsset: AppAssets.teacherNavProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String iconAsset,
  }) {
    final isSelected = controller.currentTabIndex.value == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.changeTab(index),
        child: SizedBox(
          height: 61,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconAsset,
                width: 22,
                height: 22,
                color: isSelected
                    ? const Color(0xFF0E3856)
                    : const Color(0xFF767683),
                colorBlendMode: BlendMode.srcIn,
              ),

              const SizedBox(height: 5),

              // Active Indicator: Ellipse 23 (8x8 gradient circular dot)
              if (isSelected)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF4CACD9),
                        Color(0xFF2175AE),
                      ],
                    ),
                  ),
                )
              else
                const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
