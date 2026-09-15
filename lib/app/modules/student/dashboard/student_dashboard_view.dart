import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../home/student_home_view.dart';
import '../my_learning/student_my_learning_view.dart';
import '../profile/student_profile_view.dart';
import '../rewards/student_rewards_view.dart';
import 'student_dashboard_controller.dart';

class StudentDashboardView extends GetView<StudentDashboardController> {
  const StudentDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Content pages using IndexedStack to preserve state
          Obx(
            () => IndexedStack(
              index: controller.selectedIndex.value,
              children: const [
                StudentHomeView(),
                StudentMyLearningView(),
                StudentRewardsView(showBottomNav: false),
                StudentProfileView(showBottomNav: false),
              ],
            ),
          ),
          // Floating Pill Bottom Navigation Bar (Figma Rectangle 17)
          Positioned(
            left: 20,
            right: 20,
            bottom: 24,
            child: _buildFloatingNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingNavBar() {
    return Container(
      height: 61,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(53),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(9, 30, 66, 0.25),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: Color.fromRGBO(9, 30, 66, 0.08),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          children: [
            _buildNavItem(
              index: 0,
              icon: PhosphorIcons.house(PhosphorIconsStyle.bold),
            ),
            _buildNavItem(
              index: 1,
              icon: PhosphorIcons.compass(PhosphorIconsStyle.bold),
            ),
            _buildNavItem(
              index: 2,
              icon: PhosphorIcons.medal(PhosphorIconsStyle.bold),
            ),
            _buildNavItem(
              index: 3,
              icon: PhosphorIcons.userCircle(PhosphorIconsStyle.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
  }) {
    final isSelected = controller.selectedIndex.value == index;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.changeTabIndex(index),
          borderRadius: BorderRadius.circular(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 20,
                color: const Color(0xFF0E3856),
              ),
              const SizedBox(height: 4),
              // Ellipse 24: 8x8 active indicator dot with gradient
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1.0 : 0.0,
                child: Container(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
