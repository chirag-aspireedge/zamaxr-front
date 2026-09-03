import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'teacher_detail_controller.dart';

class TeacherDetailView extends GetView<TeacherDetailController> {
  const TeacherDetailView({super.key});

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
            children: [
              // Top Bar (Back button, Title, Edit & Delete actions)
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                child: _buildTopAppBar(),
              ),

              // Scrollable Details Body
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Centered Profile Header (Avatar, Verification Badge, Name, Subject, Active Badge)
                      _buildProfileHeader(),

                      const SizedBox(height: 28),

                      // Information Section Header
                      const Text(
                        'Information',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0E3856),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Information Card 1: Phone
                      _buildInfoCard(
                        svgAsset: AppAssets.iconPhoneBlue,
                        svgWidth: 18,
                        svgHeight: 18,
                        label: 'Phone',
                        value: controller.teacher.value.phone,
                      ),

                      const SizedBox(height: 14),

                      // Information Card 2: Email
                      _buildInfoCard(
                        svgAsset: AppAssets.iconMailBlue,
                        svgWidth: 20,
                        svgHeight: 16,
                        label: 'Email',
                        value: controller.teacher.value.email,
                      ),

                      const SizedBox(height: 14),

                      // Information Card 3: Teacher ID
                      _buildInfoCard(
                        svgAsset: AppAssets.iconIdBadgeBlue,
                        svgWidth: 20,
                        svgHeight: 20,
                        label: 'Teacher ID',
                        value: controller.teacher.value.teacherIdCode,
                      ),

                      const SizedBox(height: 24),

                      // InActive Teacher Switch Row
                      _buildInactiveTeacherRow(),

                      const SizedBox(height: 24),

                      // Assigned Class Section Header
                      const Text(
                        'Assigned Class',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0E3856),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Assigned Class Card
                      _buildAssignedClassCard(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Top App Bar with Back, Title, Edit and Delete with exact Figma SVGs
  Widget _buildTopAppBar() {
    return Row(
      children: [
        // Circular Back Button (44x44)
        GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.white,
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
                AppAssets.iconArrowBackBlue,
                width: 22,
                height: 22,
              ),
            ),
          ),
        ),

        const SizedBox(width: 14),

        // Screen Title
        const Text(
          'Teacher’s Details',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0E3856),
          ),
        ),

        const Spacer(),

        // Edit Button (38x38 in Figma with exact edit SVG)
        GestureDetector(
          onTap: () => controller.editTeacher(),
          child: Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.white,
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
                AppAssets.iconEditBlue,
                width: 18,
                height: 18,
              ),
            ),
          ),
        ),

        const SizedBox(width: 10),

        // Delete Button (38x38 in Figma with exact delete SVG)
        GestureDetector(
          onTap: () => controller.confirmDeleteTeacher(),
          child: Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.white,
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
                AppAssets.iconDeleteRed,
                width: 16,
                height: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Centered Profile Header (Avatar, Verification Badge, Name, Subject, Status Pill)
  Widget _buildProfileHeader() {
    final teacher = controller.teacher.value;

    return Center(
      child: Column(
        children: [
          // Avatar with Verification Badge
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Avatar Image (92x92)
              Container(
                width: 92,
                height: 92,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE7E8E9),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x260059BB), // rgba(0, 89, 187, 0.15)
                      blurRadius: 32,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    teacher.avatarAsset.isNotEmpty
                        ? teacher.avatarAsset
                        : AppAssets.teacherAvatar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFE0F6FF),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.iconTeacher,
                            width: 40,
                            height: 40,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Verification Badge on Bottom-Right (Exact Figma Circle + Check SVG)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3D000000),
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE0F6FF),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.iconVerifiedCheck,
                          width: 12,
                          height: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Teacher Full Name
          Text(
            teacher.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Color(0xFF131313),
              letterSpacing: -0.5,
            ),
          ),

          const SizedBox(height: 4),

          // Subject Title
          Text(
            teacher.subjectTitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF335E7D),
            ),
          ),

          const SizedBox(height: 10),

          // Status Badge (Active Pill)
          Container(
            width: 80,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFFE0F6FF),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Green Dot (8x8)
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFF20E679),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  'Active',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF335E7D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Information Card Widget (354x60 in Figma with exact SVG icons)
  Widget _buildInfoCard({
    required String svgAsset,
    required double svgWidth,
    required double svgHeight,
    required String label,
    required String value,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 60),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
      ),
      child: Row(
        children: [
          // Circular Icon Container (40x40 in #E0F6FF with exact Figma SVG)
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFE0F6FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                svgAsset,
                width: svgWidth,
                height: svgHeight,
              ),
            ),
          ),

          const SizedBox(width: 14),

          // Label and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF335E7D),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF131313),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // InActive Teacher Row with Custom Gradient Switch matching Figma
  Widget _buildInactiveTeacherRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'InActive Teacher',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0E3856),
          ),
        ),

        // Custom Gradient Switch (56x25 in Figma)
        Obx(() {
          final isInactive = controller.isInactive.value;
          return GestureDetector(
            onTap: () => controller.toggleActiveStatus(!isInactive),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 56,
              height: 25,
              padding: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(43),
                gradient: isInactive
                    ? const LinearGradient(
                        colors: [Color(0xFF56B9E3), Color(0xFF1567A2)],
                      )
                    : null,
                color: isInactive ? null : const Color(0xFFE3E3E3),
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment:
                    isInactive ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 21,
                  height: 21,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  // Assigned Class Card Widget (354x108 in Figma with exact chevron SVG)
  Widget _buildAssignedClassCard() {
    final teacher = controller.teacher.value;

    return Container(
      height: 108,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF5F5F5), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000), // 0.15 opacity
            blurRadius: 3,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            // Left Accent Bar (9px in #0E3856)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 9,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF0E3856),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                  ),
                ),
              ),
            ),

            // Main Content Row
            Padding(
              padding: const EdgeInsets.fromLTRB(24.0, 16.0, 16.0, 16.0),
              child: Row(
                children: [
                  // Class Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          teacher.assignedClass,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF131313),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              teacher.assignedSubject,
                              style: const TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF335E7D),
                              ),
                            ),
                            const SizedBox(width: 6),
                            // Dot separator
                            Container(
                              width: 4,
                              height: 4,
                              decoration: const BoxDecoration(
                                color: Color(0xFF335E7D),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${teacher.studentsCount} Students',
                              style: const TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF335E7D),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Right Chevron Button (32x32 in #E0F6FF with exact Figma chevron SVG)
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE0F6FF),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.iconChevronRightBlue,
                        width: 8,
                        height: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
