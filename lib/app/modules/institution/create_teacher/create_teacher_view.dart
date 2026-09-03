import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';

import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';
import 'create_teacher_controller.dart';

class CreateTeacherView extends GetView<CreateTeacherController> {
  const CreateTeacherView({super.key});

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
              // Top Bar with Circular Back Button
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                child: _buildTopAppBar(),
              ),

              // Scrollable Form Body
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Screen Heading
                      const Text(
                        'Create Teacher’s Profile',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0E3856),
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Enter the fundamental identification details for this XR faculty member.',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF414754),
                          height: 1.35,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Input 1: Teacher Name (Rectangle 19: 354x54)
                      _buildFormInputField(
                        controller: controller.nameController,
                        hintText: 'Teacher Name',
                      ),

                      const SizedBox(height: 16),

                      // Input 2: Email Address (Rectangle 34: 354x54)
                      _buildFormInputField(
                        controller: controller.emailController,
                        hintText: 'Email Address',
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 16),

                      // Input 3: Contact Number Row (Rectangle 23 + 22: 54x54 + 292x54)
                      _buildPhoneInputField(),

                      const SizedBox(height: 16),

                      // Input 4: Subject / Specialization (Rectangle 34: 354x54)
                      _buildFormInputField(
                        controller: controller.subjectController,
                        hintText: 'Subject / Specialization',
                      ),

                      const SizedBox(height: 20),

                      // Add Photo Upload Card (Group 2043 / Rectangle 19: 354x149)
                      _buildPhotoUploadCard(),

                      const SizedBox(height: 36),

                      // Primary Action Button: Create Teacher (Rectangle 7: 318x54)
                      _buildCreateTeacherButton(),

                      const SizedBox(height: 16),

                      // Secondary Navigation: Go to Dashboard
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

  // Top App Bar with Circular Back Button
  Widget _buildTopAppBar() {
    return Row(
      children: [
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

  // Generic Form Input Box (Rectangle: 354x54)
  Widget _buildFormInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontFamily: AppTextStyle.fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Color(0xFF0E3856),
        ),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0x4F0E3856), // rgba(14, 56, 86, 0.31)
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  // Phone Input Row with Country Code Selector + Number Input
  Widget _buildPhoneInputField() {
    return Row(
      children: [
        // Country Code Box (Rectangle 23: 54x54)
        Container(
          width: 58,
          height: 54,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(
                    controller.selectedCountryCode.value,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF131313),
                    ),
                  )),
              const SizedBox(width: 2),
              const Icon(
                Icons.arrow_drop_down_rounded,
                size: 18,
                color: Color(0xFF131313),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        // Contact Number Input Box (Rectangle 22: 292x54)
        Expanded(
          child: Container(
            height: 54,
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0E3856),
              ),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                hintText: 'Contact Number',
                hintStyle: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFFCFD8DE),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Add Photo Upload Card (Group 2043 / Rectangle 19: 354x149)
  Widget _buildPhotoUploadCard() {
    return GestureDetector(
      onTap: () => controller.pickPhoto(),
      child: Container(
        width: double.infinity,
        height: 149,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular Gradient Container (64x64)
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0059BB).withValues(alpha: 0.06),
              ),
              child: Center(
                child: Obx(() {
                  final hasPhoto = controller.selectedImagePath.value.isNotEmpty;
                  return hasPhoto
                      ? const Icon(
                          Icons.check_circle_rounded,
                          size: 30,
                          color: Color(0xFF127FD2),
                        )
                      : SvgPicture.asset(
                          AppAssets.iconAddPhoto,
                          width: 30,
                          height: 27,
                        );
                }),
              ),
            ),


            const SizedBox(height: 10),

            // "Add Photo" Label
            Obx(() {
              final hasPhoto = controller.selectedImagePath.value.isNotEmpty;
              return Text(
                hasPhoto ? 'Photo Attached' : 'Add Photo',
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.8,
                  color: Color(0xFF335E7D),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Primary Action Button "Create Teacher" (Rectangle 7: 318x54)
  Widget _buildCreateTeacherButton() {
    return Center(
      child: GestureDetector(
        onTap: () => controller.createTeacher(),
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
          child: const Center(
            child: Text(
              'Create Teacher',
              style: TextStyle(
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
