import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';
import '../../individual/home/individual_home_controller.dart';
import 'student_profile_controller.dart';

class StudentProfileView extends GetView<StudentProfileController> {
  final bool showBottomNav;
  const StudentProfileView({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<StudentProfileController>()) {
      Get.put(StudentProfileController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: true,
        bottom: false,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 16,
                bottom: 110, // Safe padding for bottom floating nav bar
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Profile Card
                  _buildProfileCard(),
                  const SizedBox(height: 20),

                  // 2. Learning Progress Synced Banner (Progress Protection Area)
                  _buildProgressSyncBanner(),
                  const SizedBox(height: 24),

                  // 3. Account Settings Section
                  _buildSectionHeader('Account Settings'),
                  const SizedBox(height: 12),
                  _buildAccountSettingsCard(),
                  const SizedBox(height: 24),

                  // 4. Security Section
                  _buildSectionHeader('Security'),
                  const SizedBox(height: 12),
                  _buildSecurityCard(),
                ],
              ),
            ),
            if (showBottomNav)
              Positioned(
                left: 20,
                right: 20,
                bottom: 24,
                child: _buildStandaloneBottomNav(),
              ),
          ],
        ),
      ),
    );
  }

  // 1. Main Profile Card (Avatar, Badge, Name, Email, Individual Badge, Edit Profile Button)
  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFEFEFE),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF0F2F5), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Avatar (96x96) with Edit Badge (24x24)
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.10),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                      spreadRadius: -1,
                    ),
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                      spreadRadius: -2,
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    AppAssets.studentProfileAlex,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFD8E2FF),
                      child: const Icon(
                        Icons.person,
                        size: 52,
                        color: Color(0xFF0059BB),
                      ),
                    ),
                  ),
                ),
              ),
              // Background+Shadow edit button badge
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: controller.editAvatar,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0059BB),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Alex Johnson
          Obx(
            () => Text(
              controller.name.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
                letterSpacing: -0.2,
              ),
            ),
          ),
          const SizedBox(height: 4),

          // alex.j@email.com
          Obx(
            () => Text(
              controller.email.value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF414754),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Individual Account Badge
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF0E3856),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.person,
                    size: 11,
                    color: Color(0xFFF6FEFF),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    controller.accountType.value,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFF6FEFF),
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Edit Profile Button (#E0F6FF)
          SizedBox(
            width: double.infinity,
            height: 44,
            child: Material(
              color: const Color(0xFFE0F6FF),
              borderRadius: BorderRadius.circular(8),
              child: InkWell(
                onTap: controller.onEditProfile,
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      PhosphorIcons.userGear(PhosphorIconsStyle.regular),
                      size: 16,
                      color: const Color(0xFF191C1D),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Edit Profile',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF191C1D),
                        letterSpacing: 0.14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 2. Learning Progress Synced Banner
  Widget _buildProgressSyncBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF2FBFF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD8EEFA), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Blue circle with white sync icon
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFF127FD2),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.sync_rounded,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 14),
          // Title + Subtitle
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Learning Progress Synced',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF191C1D),
                    letterSpacing: 0.14,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  "Your progress is securely saved and will sync when you're back online.",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF414754),
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Section Header Title
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: Color(0xFF191C1D),
        letterSpacing: 0.14,
      ),
    );
  }

  // 3. Account Settings Card (Personal Info, Language, Notifications, Subscription, Rewards)
  Widget _buildAccountSettingsCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFF0F2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: PhosphorIcons.user(PhosphorIconsStyle.bold),
            iconColor: const Color(0xFF127FD2),
            title: 'Personal Information',
            subtitle: 'Edit name and account details',
            onTap: controller.onPersonalInformationTap,
          ),
          _buildCardDivider(),
          _buildSettingsTile(
            icon: PhosphorIcons.globe(PhosphorIconsStyle.bold),
            iconColor: const Color(0xFF127FD2),
            title: 'Language',
            subtitle: 'Choose preferred app language',
            onTap: controller.onLanguageTap,
          ),
          _buildCardDivider(),
          _buildSettingsTile(
            icon: PhosphorIcons.bell(PhosphorIconsStyle.bold),
            iconColor: const Color(0xFF127FD2),
            title: 'Notifications',
            subtitle: 'Manage notification preferences',
            onTap: controller.onNotificationsTap,
          ),
          _buildCardDivider(),
          _buildSettingsTile(
            icon: PhosphorIcons.creditCard(PhosphorIconsStyle.bold),
            iconColor: const Color(0xFF127FD2),
            title: 'Subscription',
            subtitle: 'View Individual subscription',
            onTap: controller.onSubscriptionTap,
          ),
          _buildCardDivider(),
          _buildSettingsTile(
            icon: PhosphorIcons.trophy(PhosphorIconsStyle.bold),
            iconColor: const Color(0xFF127FD2),
            title: 'Rewards',
            subtitle: 'View reward balance & activity',
            onTap: controller.onRewardsTap,
          ),
        ],
      ),
    );
  }

  // 4. Security Card (Change Password, Account Recovery, Log Out)
  Widget _buildSecurityCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFEFF0F2), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildSettingsTile(
            icon: PhosphorIcons.lockKey(PhosphorIconsStyle.bold),
            iconColor: const Color(0xFF414754),
            title: 'Change Password',
            onTap: controller.onChangePasswordTap,
          ),
          _buildCardDivider(),
          _buildSettingsTile(
            icon: PhosphorIcons.shieldCheck(PhosphorIconsStyle.bold),
            iconColor: const Color(0xFF414754),
            title: 'Account Recovery',
            onTap: controller.onAccountRecoveryTap,
          ),
          _buildCardDivider(),
          // Logout tile (red styling, no chevron)
          _buildSettingsTile(
            icon: PhosphorIcons.signOut(PhosphorIconsStyle.bold),
            iconColor: const Color(0xFFBA1A1A),
            circleBgColor: const Color(0xFFFFDAD6).withValues(alpha: 0.5),
            title: 'Log Out',
            titleColor: const Color(0xFFBA1A1A),
            showChevron: false,
            onTap: controller.onLogoutTap,
          ),
        ],
      ),
    );
  }

  // Reusable Tile for Settings & Security
  Widget _buildSettingsTile({
    required IconData icon,
    required Color iconColor,
    Color circleBgColor = const Color(0xFFEDEEEF),
    required String title,
    String? subtitle,
    Color titleColor = const Color(0xFF191C1D),
    bool showChevron = true,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // Circular icon container (40x40)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: circleBgColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 20,
                    color: iconColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Title and optional subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: titleColor,
                        letterSpacing: 0.14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF414754),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),

              // Chevron icon
              if (showChevron) ...[
                const SizedBox(width: 8),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: Color(0xFFC1C6D7),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  // 1px Divider (#E1E3E4) with 16px horizontal margins
  Widget _buildCardDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFE1E3E4),
      ),
    );
  }

  // Floating Pill Bottom Navigation Bar (Figma Rectangle 17)
  Widget _buildStandaloneBottomNav() {
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
      child: Row(
        children: [
          _buildNavItem(
            index: 0,
            icon: PhosphorIconsBold.house,
            isSelected: false,
            onTap: () {
              if (Get.isRegistered<IndividualHomeController>()) {
                Get.find<IndividualHomeController>().currentNavIndex.value = 0;
                Get.back();
              } else {
                Get.offAllNamed(Routes.INDIVIDUAL_HOME);
              }
            },
          ),
          _buildNavItem(
            index: 1,
            icon: PhosphorIconsBold.compass,
            isSelected: false,
            onTap: () => Get.toNamed(Routes.STUDENT_MY_LEARNING),
          ),
          _buildNavItem(
            index: 2,
            icon: PhosphorIconsBold.medal,
            isSelected: false,
            onTap: () {
              if (Get.isRegistered<IndividualHomeController>()) {
                Get.find<IndividualHomeController>().currentNavIndex.value = 2;
                Get.back();
              } else {
                Get.toNamed(Routes.STUDENT_REWARDS);
              }
            },
          ),
          _buildNavItem(
            index: 3,
            icon: PhosphorIconsBold.userCircle,
            isSelected: true,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(53),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: const Color(0xFF0E3856),
              ),
              const SizedBox(height: 4),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1.0 : 0.0,
                child: Container(
                  width: 7,
                  height: 7,
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

