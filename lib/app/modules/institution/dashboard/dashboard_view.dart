import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/utils/app_assets.dart';

import '../classes/classes_view.dart';
import '../home/home_view.dart';
import '../../common/profile/profile_view.dart';
import '../teachers/teachers_view.dart';
import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

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
                HomeView(),
                TeachersView(),
                ClassesView(),
                ProfileView(),
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
            color: Color(0x33091E42),
            blurRadius: 16,
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
                iconAsset: AppAssets.iconNavHome,
              ),
              _buildNavItem(
                index: 1,
                iconAsset: AppAssets.iconNavGroup,
              ),
              _buildNavItem(
                index: 2,
                iconAsset: AppAssets.iconNavScreen,
              ),
              _buildNavItem(
                index: 3,
                iconAsset: AppAssets.iconNavProfile,
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
        onTap: () => controller.changeTab(index),
        behavior: HitTestBehavior.opaque,
        child: SizedBox(
          height: 61,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Navigation Vector Icon (from Figma)
              Center(
                child: SvgPicture.asset(
                  iconAsset,
                  width: 22,
                  height: 22,
                  colorFilter: ColorFilter.mode(
                    isSelected
                        ? const Color(0xFF127FD2)
                        : const Color(0xFF0E3856),
                    BlendMode.srcIn,
                  ),
                ),
              ),

              // Active Bottom Indicator Pill (Rectangle 101 in Figma)
              if (isSelected)
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 37,
                    height: 5,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF56B9E3),
                          Color(0xFF127FD2),
                        ],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(3),
                        topRight: Radius.circular(3),
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
}

