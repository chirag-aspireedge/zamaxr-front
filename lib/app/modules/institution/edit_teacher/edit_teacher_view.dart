import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'edit_teacher_controller.dart';

class EditTeacherView extends GetView<EditTeacherController> {
  const EditTeacherView({super.key});

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
              // Top Bar (Back, Title, Delete Action)
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                child: _buildTopAppBar(),
              ),

              // Scrollable Edit Form Body
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 36.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Photo Upload / Edit Avatar
                      _buildPhotoSection(),

                      const SizedBox(height: 24),

                      // Section: Personal Details
                      const Text(
                        'Personal Details',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0E3856),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Field 1: Name
                      _buildInputField(
                        controller: controller.nameController,
                        hintText: 'Teacher Name',
                      ),

                      const SizedBox(height: 14),

                      // Field 2: Phone
                      _buildInputField(
                        controller: controller.phoneController,
                        hintText: 'Contact Number',
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 14),

                      // Field 3: Email
                      _buildInputField(
                        controller: controller.emailController,
                        hintText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 24),

                      // Primary Action: Save Changes Button (318x54 centered)
                      Center(
                        child: _buildSaveChangesButton(),
                      ),

                      const SizedBox(height: 24),

                      // Locked Field: Teacher ID (TCH-1024)
                      _buildLockedTeacherIdField(),

                      const SizedBox(height: 24),

                      // Section: Teacher's Skills
                      const Text(
                        'Teacher’s Skills',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0E3856),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Teacher's Skills Container (354x164)
                      _buildSkillsContainer(),

                      const SizedBox(height: 24),

                      // Section: Assigned Classes
                      const Text(
                        'Assigned Classes',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0E3856),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // List of Assigned Class Cards
                      _buildAssignedClassesList(),
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

  // Top App Bar with Circular Back, Title, and Delete Icon
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
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0E3856),
          ),
        ),

        const Spacer(),

        // Delete Button (38x38 in Figma with red trash icon)
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

  // Centered Profile Photo with Edit Pencil Badge overlay
  Widget _buildPhotoSection() {
    return Center(
      child: GestureDetector(
        onTap: () => controller.updatePhoto(),
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Avatar (88x88 in Figma)
                Container(
                  width: 88,
                  height: 88,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE7E8E9),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      AppAssets.teacherAvatar,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFE0F6FF),
                          child: Center(
                            child: SvgPicture.asset(
                              AppAssets.iconTeacher,
                              width: 38,
                              height: 38,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                // Edit Pencil Badge on Bottom-Right (28x28 in Figma)
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
                          color: Color(0xFFD0E7EA),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppAssets.iconEditBlue,
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

            const SizedBox(height: 10),

            // Tap to update photo label
            const Text(
              'Tap to update photo',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF476083),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Text Input Field (354x54 in Figma)
  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF131313),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0x80131313),
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }

  // Primary Gradient "Save Changes" Button (318x54 in Figma)
  Widget _buildSaveChangesButton() {
    return GestureDetector(
      onTap: () => controller.saveChanges(),
      child: Container(
        width: 318,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(52),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF56B9E3), Color(0xFF0E5E9B)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Save Changes',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  // Locked Teacher ID Container (354x54 in Figma with Lock SVG)
  Widget _buildLockedTeacherIdField() {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0x33FFFFFF),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              controller.teacher.value.teacherIdCode,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0x85131313), // rgba(19, 19, 19, 0.52)
              ),
            ),
          ),
          SvgPicture.asset(
            AppAssets.iconLockBlue,
            width: 16,
            height: 20,
          ),
        ],
      ),
    );
  }

  // Teacher's Skills Card Container (354x164 in Figma)
  Widget _buildSkillsContainer() {
    return Container(
      height: 164,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Input row for adding new skill
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller.skillInputController,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 13,
                    color: Color(0xFF131313),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Add a subject/skill (e.g. Science)...',
                    hintStyle: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12,
                      color: Color(0x55131313),
                    ),
                    isDense: true,
                    border: InputBorder.none,
                  ),
                  onSubmitted: (value) => controller.addSkill(value),
                ),
              ),
              GestureDetector(
                onTap: () => controller
                    .addSkill(controller.skillInputController.text),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    '+ Add',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF127FD2),
                    ),
                  ),
                ),
              ),
            ],
          ),

          const Divider(color: Color(0xFFF0F0F0), height: 16),

          // Skill Tags Wrap
          Expanded(
            child: Obx(() {
              return Wrap(
                spacing: 8,
                runSpacing: 8,
                children: controller.skills.map((skill) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(41),
                      border: Border.all(
                          color: const Color(0xFFE2E2E2), width: 0.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          skill,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF0E3856),
                          ),
                        ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: () => controller.removeSkill(skill),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 14,
                            color: Color(0xFF717786),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Assigned Classes List
  Widget _buildAssignedClassesList() {
    return Obx(() {
      return Column(
        children: controller.assignedClasses.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildAssignedClassCard(item),
          );
        }).toList(),
      );
    });
  }

  // Assigned Class Card (354x108 in Figma with checkbox)
  Widget _buildAssignedClassCard(AssignedClassEditItem item) {
    return GestureDetector(
      onTap: () => controller.toggleClassSelection(item),
      child: Container(
        height: 108,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFF5F5F5), width: 1),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 3,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              // Left Indicator Accent Bar (9px #0E3856)
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

              // Content Row
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 16.0, 16.0, 16.0),
                child: Row(
                  children: [
                    // Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item.title,
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
                                item.subject,
                                style: const TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF476083),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF717786),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${item.studentsCount} Students',
                                style: const TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF476083),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Selection Checkbox (26x26 in Figma)
                    Obx(() {
                      final isSelected = item.isSelected.value;
                      return Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? const Color(0xFF127FD2)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: isSelected
                              ? null
                              : Border.all(
                                  color: const Color(0xFFE3E3E3),
                                  width: 1.5,
                                ),
                        ),
                        child: isSelected
                            ? const Center(
                                child: Icon(
                                  Icons.check_rounded,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              )
                            : null,
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
