import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

                      const SizedBox(height: 24),

                      // List of Roles
                      Obx(
                        () => Column(
                          children: controller.roles.map((item) {
                            final isSelected =
                                controller.selectedRole.value == item.role;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 14.0),
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
      onTap: () {
        controller.selectRole(item.role);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE0F6FF)
              : const Color(0x33F6F6F6),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF1667A2)
                : const Color(0xFFE7E7E7),
            width: isSelected ? 1.4 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: const Color(0xFF1667A2).withValues(alpha: 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: isSelected
            ? _buildSelectedCardContent(item)
            : _buildUnselectedCardContent(item),
      ),
    );
  }

  Widget _buildUnselectedCardContent(RoleItem item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circular Icon Container (52x52)
        Container(
          width: 52,
          height: 52,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFE0F6FF),
          ),
          child: Center(
            child: _getRoleIcon(item.role, isSelected: false),
          ),
        ),

        const SizedBox(width: 16),

        // Text details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 16.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1E),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                item.description,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF464555),
                  height: 1.45,
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
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1567A2),
              ),
              child: Center(
                child: _getRoleIcon(item.role, isSelected: true),
              ),
            ),
            Container(
              width: 28,
              height: 28,
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
                size: 16,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        // Title
        Text(
          item.title,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: Color(0xFF131313),
          ),
        ),

        const SizedBox(height: 6),

        // Description
        Text(
          item.description,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF131313),
            height: 1.45,
          ),
        ),
      ],
    );
  }

  Widget _getRoleIcon(UserRole role, {required bool isSelected}) {
    final color = isSelected ? AppColor.white : const Color(0xFF1567A2);

    switch (role) {
      case UserRole.student:
        return Icon(
          Remix.graduation_cap_line,
          color: color,
          size: 26,
        );
      case UserRole.teacher:
        return Icon(
          Remix.presentation_line,
          color: color,
          size: 26,
        );
      case UserRole.institution:
        return Icon(
          Remix.bank_line,
          color: color,
          size: 26,
        );
      case UserRole.parent:
        return Icon(
          Remix.parent_line,
          color: color,
          size: 26,
        );
      case UserRole.individual:
        return Icon(
          Remix.user_3_line,
          color: color,
          size: 26,
        );
    }
  }

  Widget _buildContinueButton() {
    final currentRole = controller.roles.firstWhere(
      (r) => r.role == controller.selectedRole.value,
      orElse: () => controller.roles.first,
    );

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: RichText(
                  maxLines: 1,
                  text: TextSpan(
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 17,
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
        ),
      ),
    );
  }
}
