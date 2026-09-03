import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import 'select_role_controller.dart';

class SelectRoleView extends GetView<SelectRoleController> {
  const SelectRoleView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),

                      // Header Title
                      const Text(
                        'Choose Your Role',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF131313),
                          height: 25 / 20,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Subtitle
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF131313),
                            height: 18 / 14,
                          ),
                          children: [
                            TextSpan(text: 'Select how you’ll use '),
                            TextSpan(
                              text: 'ZamaXR',
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // List of Roles
                      Obx(
                        () => Column(
                          children: controller.roles.map((item) {
                            final isSelected =
                                controller.selectedRole.value == item.role;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: _buildRoleCard(item, isSelected),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Bottom Action Button
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 24.0),
                child: Obx(() => _buildContinueButton()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(RoleItem item, bool isSelected) {
    return GestureDetector(
      onTap: () => controller.selectRole(item.role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE0F6FF)
              : const Color(0x33F6F6F6),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1667A2)
                : const Color(0xFFE7E7E7),
            width: isSelected ? 0.8 : 1.0,
          ),
        ),
        padding: isSelected
            ? const EdgeInsets.all(16.0)
            : const EdgeInsets.symmetric(horizontal: 14.0, vertical: 18.0),
        child: isSelected
            ? _buildSelectedCardContent(item)
            : _buildUnselectedCardContent(item),
      ),
    );
  }

  Widget _buildUnselectedCardContent(RoleItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Circular Icon Container (50x50)
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE0F6FF),
          ),
          child: Center(
            child: _getRoleIcon(item.role, isSelected: false),
          ),
        ),

        const SizedBox(width: 14),

        // Text details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1E),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                item.description,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF464555),
                  height: 17 / 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedCardContent(RoleItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top row with Icon and Checkmark
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1567A2),
              ),
              child: Center(
                child: _getRoleIcon(item.role, isSelected: true),
              ),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1567A2),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.check,
                color: AppColor.white,
                size: 18,
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Title
        Text(
          item.title,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF131313),
          ),
        ),

        const SizedBox(height: 4),

        // Description
        Text(
          item.description,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF131313),
            height: 20 / 13,
          ),
        ),
      ],
    );
  }

  Widget _getRoleIcon(UserRole role, {required bool isSelected}) {
    final color = isSelected ? AppColor.white : const Color(0xFF131313);

    switch (role) {
      case UserRole.student:
        return Icon(
          PhosphorIcons.student(PhosphorIconsStyle.regular),
          color: color,
          size: 24,
        );
      case UserRole.teacher:
        return Icon(
          PhosphorIcons.chalkboardTeacher(PhosphorIconsStyle.regular),
          color: color,
          size: 24,
        );
      case UserRole.parent:
        return Icon(
          Remix.parent_line,
          color: color,
          size: 24,
        );
      case UserRole.institution:
        return Icon(
          Remix.bank_line,
          color: color,
          size: 24,
        );
      case UserRole.individual:
        return Icon(
          Remix.admin_line,
          color: color,
          size: 24,
        );
    }
  }

  Widget _buildContinueButton() {
    final currentRole = controller.roles
        .firstWhere((r) => r.role == controller.selectedRole.value);

    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: AppColor.primaryButtonGradient,
        borderRadius: BorderRadius.circular(74),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.continueWithRole,
          borderRadius: BorderRadius.circular(74),
          splashColor: Colors.white24,
          highlightColor: Colors.white10,
          child: Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColor.white,
                ),
                children: [
                  const TextSpan(text: 'Continue as '),
                  TextSpan(
                    text: currentRole.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
