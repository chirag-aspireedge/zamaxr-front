import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'teacher_student_model.dart';
import 'teacher_students_controller.dart';

class TeacherStudentsView extends GetView<TeacherStudentsController> {
  const TeacherStudentsView({super.key});

  @override
  Widget build(BuildContext context) {
    const fontFamily = AppTextStyle.fontFamily;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar Title: "Students" (No back button per user instruction)
            Padding(
              padding: const EdgeInsets.only(
                left: 24.0,
                right: 24.0,
                top: 20.0,
                bottom: 8.0,
              ),
              child: const Text(
                'Students',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF191C1D),
                  height: 32 / 24,
                ),
              ),
            ),

            // Subheader: "30 Student" counter + "+ Add Student" pill button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 12.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Obx(
                      () => Text(
                        '${controller.studentsCount.value} Student',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF191C1D),
                          height: 24 / 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),

                  // + Add Student Button (Figma rounded pill, background #E0F6FF)
                  GestureDetector(
                    onTap: controller.onAddStudent,
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F6FF),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: const Center(
                        child: Text(
                          '+ Add Student',
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF127FD2),
                            height: 24 / 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Students List
            Expanded(
              child: Obx(
                () => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    top: 8.0,
                    bottom: 110.0, // Space for floating bottom navigation bar
                  ),
                  itemCount: controller.students.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final student = controller.students[index];
                    return _buildStudentCard(student);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentCard(TeacherStudentModel student) {
    const fontFamily = AppTextStyle.fontFamily;

    return GestureDetector(
      onTap: () => controller.onStudentTap(student),
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFF0F0F0),
            width: 0.8,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar Stack with Online/Active Indicator Dot
            _buildAvatarWithStatus(student),
            const SizedBox(width: 16),

            // Student Info (Name + ID)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    student.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF191C1D),
                      height: 24 / 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    student.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF414754),
                      height: 24 / 14,
                    ),
                  ),
                ],
              ),
            ),

            // Chevron Right Icon (Exact Figma path #717786)
            SvgPicture.asset(
              AppAssets.iconStudentChevron,
              width: 8,
              height: 12,
              colorFilter: const ColorFilter.mode(
                Color(0xFF717786),
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarWithStatus(TeacherStudentModel student) {
    const fontFamily = AppTextStyle.fontFamily;

    Widget avatarChild;
    if (student.imageAsset != null) {
      avatarChild = Image.asset(
        student.imageAsset!,
        width: 48,
        height: 48,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 48,
            height: 48,
            color: const Color(0xFFEDEEEF),
            child: const Icon(
              Icons.person,
              color: Color(0xFF717786),
              size: 24,
            ),
          );
        },
      );
    } else {
      avatarChild = Container(
        width: 48,
        height: 48,
        color: student.initialsBgColor ?? const Color(0xFFEDEEEF),
        child: Center(
          child: Text(
            student.initials ?? '',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: student.initialsTextColor ?? const Color(0xFF445D80),
            ),
          ),
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Rounded avatar
        ClipOval(
          child: SizedBox(
            width: 48,
            height: 48,
            child: avatarChild,
          ),
        ),

        // Online Status Dot (#10B981 for active, #94A3B8 for inactive)
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: student.isOnline
                  ? const Color(0xFF10B981)
                  : const Color(0xFF94A3B8),
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
