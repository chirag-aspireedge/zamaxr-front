import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';
import 'create_class_controller.dart';
import 'create_class_model.dart';

class CreateClassView extends GetView<CreateClassController> {
  const CreateClassView({super.key});

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
              // Top Header: Back Button & Step Progress Bar
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                child: Column(
                  children: [
                    _buildTopAppBar(),
                    const SizedBox(height: 20),
                    _buildStepProgressBar(),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Main Step Content Area (Animated Switcher between 3 Steps)
              Expanded(
                child: Obx(() {
                  switch (controller.currentStep.value) {
                    case 0:
                      return _buildStep1ClassDetails();
                    case 1:
                      return _buildStep2AssignTeacher();
                    case 2:
                      return _buildStep3ReviewClass();
                    default:
                      return _buildStep1ClassDetails();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Top App Bar with Circular Back Button
  Widget _buildTopAppBar() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => controller.previousStep(),
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0x1A000000), // 0.1 opacity
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
      ],
    );
  }

  // Step Progress Bar (Rectangle 47 & 48 in Figma)
  Widget _buildStepProgressBar() {
    return Obx(() {
      final step = controller.currentStep.value;
      double progressFactor = (step + 1) / 3.0; // 0.33 -> 0.66 -> 1.0

      return Container(
        height: 10,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFE0F6FF),
          borderRadius: BorderRadius.circular(44),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: progressFactor,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: const Color(0xFF0E3856),
              borderRadius: BorderRadius.circular(44),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x40000000),
                  blurRadius: 4,
                  offset: Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // -------------------------------------------------------------
  // STEP 1: CLASS DETAILS
  // -------------------------------------------------------------
  Widget _buildStep1ClassDetails() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          const Text(
            'Class Details',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0E3856),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Let’s Set up the core details for this class',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF000000),
              letterSpacing: -0.02,
            ),
          ),

          const SizedBox(height: 24),

          // Class Name Input (Rectangle 19: 354x54)
          _buildFormInputField(
            controller: controller.classNameController,
            hintText: 'Class Name',
          ),

          const SizedBox(height: 16),

          // Grade/Level Input (Rectangle 20: 354x54)
          _buildFormInputField(
            controller: controller.gradeLevelController,
            hintText: 'Grade/Level',
          ),

          const SizedBox(height: 16),

          // Subject Input (Rectangle 34: 354x54)
          _buildFormInputField(
            controller: controller.subjectController,
            hintText: 'Subject',
          ),

          const SizedBox(height: 16),

          // Class Description Multiline Input (Rectangle 35: 354x165)
          _buildFormInputField(
            controller: controller.descriptionController,
            hintText: 'Class Description',
            height: 165,
            maxLines: 5,
          ),

          const SizedBox(height: 36),

          // Continue Button
          _buildPrimaryButton(
            title: 'Continue',
            onTap: () => controller.nextStep(),
          ),


          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // STEP 2: ASSIGN TEACHER
  // -------------------------------------------------------------
  Widget _buildStep2AssignTeacher() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Title
              const Text(
                'Assign Teacher',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0E3856),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Select the teacher responsible for this class.',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF335E7D),
                ),
              ),

              const SizedBox(height: 20),

              // Pill Search Bar (Rectangle 38 in Figma)
              _buildTeacherSearchBar(),
            ],
          ),

        ),

        const SizedBox(height: 18),

        // Teachers Selection List
        Expanded(
          child: Obx(() {
            final teachers = controller.filteredTeachers;
            return ListView(
              padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 16.0),
              children: [
                ...teachers.map((teacher) => _buildTeacherSelectItem(teacher)),
                const SizedBox(height: 12),
                // "Create New Teacher" Option Card
                _buildCreateNewTeacherCard(),
              ],
            );
          }),
        ),

        // Bottom Continue Button
        Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
          child: _buildPrimaryButton(
            title: 'Continue',
            onTap: () => controller.nextStep(),
          ),
        ),
      ],
    );
  }

  // Teacher Item Card in Step 2
  Widget _buildTeacherSelectItem(AssignTeacherModel item) {
    return Obx(() {
      final isSelected = controller.selectedTeacherId.value == item.id;

      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: InkWell(
          onTap: () => controller.selectTeacher(item.id),
          borderRadius: BorderRadius.circular(6),
          child: Container(
            constraints: const BoxConstraints(minHeight: 73),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color:
                    isSelected ? const Color(0xFFE0F6FF) : const Color(0xFFEAEAEA),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                // Initials Circle (48x48 in #E0F6FF)
                Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F6FF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      item.initials,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? const Color(0xFF56B9E3)
                            : const Color(0xFF0E3856),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                // Name & Subject
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0E3856),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.subjectTitle,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF335E7D),
                        ),
                      ),
                    ],
                  ),
                ),

                // Circular Selection Indicator (24x24)
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? const Color(0xFF127FD2)
                        : const Color(0xFFF9F9F9),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF127FD2)
                          : const Color(0xFFE3E3E3),
                      width: 1,
                    ),
                  ),
                  child: isSelected
                      ? const Center(
                          child: Icon(
                            Icons.check_rounded,
                            size: 16,
                            color: AppColor.white,
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // "Create New Teacher" Card in Step 2
  Widget _buildCreateNewTeacherCard() {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.CREATE_TEACHER);
      },
      borderRadius: BorderRadius.circular(6),

      child: Container(
        constraints: const BoxConstraints(minHeight: 73),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFEAEAEA), width: 1),
        ),
        child: Row(
          children: [
            // Plus Circle (48x48 in #127FD2)
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0xFF127FD2),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Remix.add_line,
                  size: 24,
                  color: AppColor.white,
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Title
            const Expanded(
              child: Text(
                'Create New Teacher',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0E3856),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Pill Search Bar for Step 2

  Widget _buildTeacherSearchBar() {
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
          controller: controller.searchTeacherController,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF0E3856),
          ),
          decoration: const InputDecoration(
            isDense: true,
            hintText: 'Search teacher',
            hintStyle: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: Color(0x4F000000),
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.only(left: 14, right: 8),
              child: Icon(
                Remix.search_2_line,
                size: 20,
                color: Color(0xFF0E3856),
              ),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(right: 14),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------
  // STEP 3: REVIEW CLASS
  // -------------------------------------------------------------
  Widget _buildStep3ReviewClass() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          const Text(
            'Review Class',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Color(0xFF0E3856),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Make sure everything looks correct before creating your class.',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF335E7D),
            ),
          ),

          const SizedBox(height: 24),

          // Summary Card 1: Class Information
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFEAEAEA), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Class Name & Edit Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.classNameController.text.isEmpty
                          ? 'Class 1'
                          : controller.classNameController.text,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0E3856),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.goToStep(0),
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF127FD2),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                Text(
                  controller.descriptionController.text.isEmpty
                      ? 'Lorem Ipsum'
                      : controller.descriptionController.text,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF414754),
                  ),
                ),

                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFF1F1F1)),
                const SizedBox(height: 14),

                // 2-Column Row: Subject & Academic Year
                Row(
                  children: [
                    // Subject
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Subject',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF335E7D),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            controller.subjectController.text.isEmpty
                                ? 'Mathematics'
                                : controller.subjectController.text,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0E3856),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Academic Year
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Academic Year',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF335E7D),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            '2026 – 2027',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0E3856),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 18),

          // Summary Card 2: Primary Teacher
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFEAEAEA), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Primary Teacher Label & Change Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Primary Teacher',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF335E7D),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => controller.goToStep(1),
                      child: const Text(
                        'Change',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF127FD2),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                Obx(() {
                  final teacher = controller.selectedTeacher;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teacher.name,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0E3856),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        teacher.subjectTitle,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF335E7D),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),


          const SizedBox(height: 36),

          // Create Class Action Button
          _buildPrimaryButton(
            title: 'Create Class',
            onTap: () => controller.createClass(),
          ),

          const SizedBox(height: 16),

          // Go to Dashboard Link
          Center(
            child: TextButton(
              onPressed: () {
                Get.offNamedUntil(Routes.DASHBOARD, (route) => false);
              },
              child: const Text(
                'Go to Dashboard',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF131313),
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }

  // -------------------------------------------------------------
  // REUSABLE FORM WIDGETS
  // -------------------------------------------------------------
  Widget _buildFormInputField({
    required TextEditingController controller,
    required String hintText,
    double height = 54,
    int maxLines = 1,
  }) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: maxLines > 1 ? 16 : 14,
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: const TextStyle(
          fontFamily: AppTextStyle.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF0E3856),
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF0E3856).withValues(alpha: 0.45),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }


  // Primary Gradient Pill Button (318x54 in Figma: Group 2047)
  Widget _buildPrimaryButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 318,
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(52),
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF56B9E3),
                Color(0xFF0E5E9B),
              ],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x26000000),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: AppColor.white,
              ),
            ),

          ),
        ),
      ),
    );
  }
}
