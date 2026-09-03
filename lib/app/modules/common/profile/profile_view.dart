import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

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
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 110.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top Profile Avatar & Edit Badge (Ellipse 17 & 167 in Figma)
                _buildProfileAvatarHeader(),

                const SizedBox(height: 16),

                // Institute Name (Axcel Top Institute)
                Obx(
                  () => Text(
                    controller.instituteName.value,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF191C1D),
                      letterSpacing: -0.5,
                    ),
                  ),
                ),


                const SizedBox(height: 28),

                // Section 1: Account
                _buildSectionTitle('Account'),
                const SizedBox(height: 10),
                Obx(() => _buildPersonalInfoExpandableCard()),


                const SizedBox(height: 20),

                // Section 2: Preference
                _buildSectionTitle('Preference'),
                const SizedBox(height: 10),
                _buildMenuCard(
                  icon: Remix.global_line,
                  title: 'Language',
                  trailingText: 'English',
                  onTap: () {},
                ),

                const SizedBox(height: 20),

                // Section 3: Institution
                _buildSectionTitle('Institution'),
                const SizedBox(height: 10),
                _buildMenuCard(
                  icon: Remix.file_paper_2_line,
                  title: 'Subscription Plan',
                  badgeText: 'Active',
                  onTap: () => Get.toNamed(Routes.SUBSCRIPTION),
                ),
                const SizedBox(height: 12),
                _buildMenuCard(
                  icon: Remix.group_line,
                  title: 'Manage Users',
                  onTap: () {},
                ),

                const SizedBox(height: 20),

                // Section 4: Support & About
                _buildSectionTitle('Support & About'),
                const SizedBox(height: 10),
                _buildMenuCard(
                  icon: Remix.question_line,
                  title: 'Help Center',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _buildMenuCard(
                  icon: Remix.information_line,
                  title: 'About Axcel Top Institution',
                  onTap: () {},
                ),

                const SizedBox(height: 32),

                // Logout Pill Button (Group 2072 in Figma)
                _buildLogoutButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Profile Avatar with Edit Badge
  Widget _buildProfileAvatarHeader() {
    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Circular Avatar Image (92x92)
            Container(
              width: 92,
              height: 92,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x26000000), // 0.15 opacity
                    blurRadius: 4,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  AppAssets.instituteAvatar,
                  width: 92,
                  height: 92,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFE8F5FF),
                    child: const Icon(
                      Remix.building_4_line,
                      size: 40,
                      color: Color(0xFF127FD2),
                    ),
                  ),
                ),
              ),
            ),

            // Edit Action Badge on bottom right (36x36)
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x59000000), // 0.35 opacity
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Remix.edit_line,
                      size: 18,
                      color: Color(0xFF127FD2),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section Header Title (Account, Preference, Institution, Support & About)
  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: AppTextStyle.fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF0E3856),
        ),
      ),
    );
  }

  // Common Settings Menu Card (68px min height, 6px border radius)
  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    String? subtitle,
    String? trailingText,
    String? badgeText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        constraints: const BoxConstraints(minHeight: 68),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
        ),
        child: Row(
          children: [
            // Circular Icon Badge (42x42 in #E8F5FF)
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: Color(0xFFE8F5FF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 22,
                  color: const Color(0xFF127FD2),
                ),
              ),
            ),

            const SizedBox(width: 14),

            // Title & optional subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF414754),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Optional Trailing Text or Badge
            if (badgeText != null) ...[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBFFE8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  badgeText,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF007302),
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],

            if (trailingText != null) ...[
              Text(
                trailingText,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF414754),
                ),
              ),
              const SizedBox(width: 6),
            ],

            // Right/Down Chevron in #C1C6D7
            const Icon(
              Remix.arrow_down_s_line,
              size: 20,
              color: Color(0xFFC1C6D7),
            ),
          ],
        ),
      ),
    );
  }

  // Logout Pill Button (318x54 in Figma)
  Widget _buildLogoutButton(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _showLogoutConfirmation(context),
        child: Container(
          width: 318,
          height: 54,
          decoration: BoxDecoration(
            color: const Color(0xFFFFEDED),
            borderRadius: BorderRadius.circular(52),
            border: Border.all(
              color: const Color(0xFFD00000).withValues(alpha: 0.1),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Remix.logout_box_r_line,
                size: 22,
                color: Color(0xFFC90000),
              ),
              SizedBox(width: 10),
              Text(
                'Logout',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFD00000),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  // Expandable Personal Information Card (Rectangle 92 in Figma: 354x370)
  Widget _buildPersonalInfoExpandableCard() {
    final isExpanded = controller.isPersonalInfoExpanded.value;

    return InkWell(
      onTap: controller.togglePersonalInfo,
      borderRadius: BorderRadius.circular(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Row
            Row(
              children: [
                // Circular Icon Badge (42x42 in #E8F5FF)
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5FF),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Remix.user_3_line,
                      size: 22,
                      color: Color(0xFF127FD2),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Personal Information',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                      if (!isExpanded) ...[
                        const SizedBox(height: 2),
                        const Text(
                          'Update your details',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF414754),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Icon(
                  isExpanded
                      ? Remix.arrow_up_s_line
                      : Remix.arrow_down_s_line,
                  size: 22,
                  color: isExpanded
                      ? const Color(0xFF8FA2B7)
                      : const Color(0xFFC1C6D7),
                ),
              ],
            ),

            // Expanded Details Section (Figma CSS: height: 370px, 5 details fields)
            if (isExpanded) ...[
              const SizedBox(height: 20),
              _buildInfoField(
                label: 'Institution Name',
                value: controller.infoInstitutionName.value,
              ),
              const SizedBox(height: 16),
              _buildInfoField(
                label: 'Institution Type',
                value: controller.infoInstitutionType.value,
              ),
              const SizedBox(height: 16),
              _buildInfoField(
                label: 'Registration Number',
                value: controller.infoRegistrationNumber.value,
              ),
              const SizedBox(height: 16),
              _buildInfoField(
                label: 'Official Email',
                value: controller.infoOfficialEmail.value,
              ),
              const SizedBox(height: 16),
              _buildInfoField(
                label: 'Contact Number',
                value: controller.infoContactNumber.value,
              ),
              const SizedBox(height: 4),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Color(0xFF718096),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF191C1D),
          ),
        ),
      ],
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Logout',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0E3856),
          ),
        ),
        content: const Text(
          'Are you sure you want to log out of your account?',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 14,
            color: Color(0xFF414754),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF5F6368)),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFD00000),
              foregroundColor: AppColor.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              Get.back();
              controller.logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

