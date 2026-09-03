import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';
import '../dashboard/dashboard_controller.dart';
import 'home_controller.dart';


class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

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
            // Soft Blue Background Gradient (Rectangle 38 in Figma)
            Positioned(
              top: 140,
              left: 0,
              right: 0,
              height: 280,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x00FFFFFF),
                      Color(0x99E0F6FF),
                      Color(0x00FFFFFF),
                    ],
                  ),
                ),
              ),
            ),

            // Scrollable Content
            SafeArea(
              bottom: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 110.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top App Header: Avatar + Search Bar + Notification Bell
                    _buildHeader(),

                    const SizedBox(height: 24),

                    // 2x2 Metric Cards Grid
                    _buildMetricsGrid(),

                    const SizedBox(height: 28),

                    // "Created Class" Section
                    _buildCreatedClassSection(),

                    const SizedBox(height: 28),

                    // "Latest Uploaded" Section
                    _buildLatestUploadedSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // User Avatar Circle (52x52 in Figma with r=22)
        GestureDetector(
          onTap: () {
            if (Get.isRegistered<DashboardController>()) {
              Get.find<DashboardController>().changeTab(3);
            }
          },
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x26000000), // 0.15 opacity black
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                AppAssets.userAvatar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFF127FD2),
                  child: const Icon(Remix.user_3_line, color: AppColor.white),
                ),
              ),
            ),
          ),
        ),


        const SizedBox(width: 10),

        // Search Bar (Rectangle 33 in Figma)
        Expanded(
          child: Container(
            height: 44,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFFE0F6FF), width: 1.2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.searchController,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 13,
                      color: AppColor.textPrimary,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Search class...',
                      hintStyle: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w300,
                        color: Color(0x50000000),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Notification Bell Icon (Ellipse 18 in Figma)
        GestureDetector(
          onTap: () => Get.toNamed(Routes.NOTIFICATIONS),
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x14000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Stack(
                children: [
                  const Icon(
                    Remix.notification_3_fill,
                    size: 22,
                    color: Color(0xFF127FD2),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        color: Color(0xFF127FD2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricsGrid() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                prefix: 'No. Of',
                title: 'Students',
                value: '100',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMetricCard(
                prefix: 'No. Of',
                title: 'Teachers',
                value: '80',
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                prefix: 'No. Of',
                title: 'Classes',
                value: '30',
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMetricCard(
                prefix: 'No. Of',
                title: 'Active Access',
                value: '65',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String prefix,
    required String title,
    required String value,
  }) {
    return Container(
      height: 108,
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: const Color(0xE6FFFFFF),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF56B9E3), width: 0.8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Title Labels
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prefix,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  letterSpacing: -0.04,
                  color: AppColor.black,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColor.black,
                  height: 1.2,
                ),
              ),
            ],
          ),

          // Big Metric Number pinned bottom right
          Positioned(
            right: 4,
            bottom: -4,
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 30,
                fontWeight: FontWeight.w600,
                color: Color(0xFF127FD2),
                height: 1.1,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildCreatedClassSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Created Class',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF127FD2),
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(Routes.CLASSES),
              child: const Row(
                children: [
                  Text(
                    'View All',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF131313),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Remix.arrow_right_s_line,
                    size: 16,
                    color: Color(0xFF127FD2),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Class Items List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.createdClasses.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final classItem = controller.createdClasses[index];
            return _buildClassCard(classItem);
          },
        ),
      ],
    );
  }

  Widget _buildClassCard(ClassModel item) {
    return Container(
      height: 72,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Content Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                // Number Circle (42x42, #E0F6FF)
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F6FF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      item.number,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1E),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Title & Subtitle
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF191C1E),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subtitle,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF464555),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),

          // Bottom Right Arrow Badge (Rectangle 41 in Figma)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 32,
              height: 27,
              decoration: const BoxDecoration(
                color: Color(0xFFE0F6FF),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(6),
                ),
              ),
              child: const Center(
                child: Icon(
                  Remix.arrow_right_line,
                  size: 16,
                  color: Color(0xFF127FD2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestUploadedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Latest Uploaded',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF127FD2),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: const Row(
                children: [
                  Text(
                    'View Course',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF000000),
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(
                    Remix.arrow_right_s_line,
                    size: 16,
                    color: Color(0xFF131313),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Course Thumbnail Card (Rectangle 44 in Figma)
        Container(
          height: 185,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: const Color(0xFFE0F6FF),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Clean Thumbnail Image (without baked-in bottom bar)
              Image.asset(
                AppAssets.latestCourseThumb,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFB5E0F5),
                  child: const Center(
                    child: Icon(
                      Remix.image_2_line,
                      size: 40,
                      color: Color(0xFF127FD2),
                    ),
                  ),
                ),
              ),

              // Bottom Left Label Badge (Rectangle 46 in Figma)
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F6FF),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(6),
                      bottomLeft: Radius.circular(14),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Lorem ipsum one',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF000000),
                    ),
                  ),
                ),
              ),

              // Bottom Right Arrow Badge (Rectangle 45 in Figma)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F6FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      bottomRight: Radius.circular(14),
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Remix.arrow_right_line,
                      size: 18,
                      color: Color(0xFF127FD2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
