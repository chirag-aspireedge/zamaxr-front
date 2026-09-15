import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'parent_profile_controller.dart';

class ParentProfileView extends GetView<ParentProfileController> {
  const ParentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(context),
              _buildProfileCard(context),
              const SizedBox(height: 28),
              _buildMyChildrenSection(context),
              const SizedBox(height: 28),
              _buildSubscriptionCard(context),
              const SizedBox(height: 28),
              _buildAccountSettingsSection(context),
              const SizedBox(height: 28),
              _buildPrivacySupportSection(context),
              const SizedBox(height: 28),
              _buildLogoutButton(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: controller.onBack,
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF191C1D)),
            tooltip: 'Back',
          ),
          const Text(
            'My Profile',
            style: TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191C1D),
            ),
          ),
          const SizedBox(width: 48), // Balance spacing
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
          border: Border.all(color: const Color(0xFFEDEEEF)),
        ),
        child: Column(
          children: [
            // Avatar with Edit badge
            Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Obx(
                        () => Image.network(
                          controller.avatar.value,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, stack) => _buildAvatarFallback(),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -2,
                    bottom: -2,
                    child: InkWell(
                      onTap: controller.onChangeAvatar,
                      borderRadius: BorderRadius.circular(9999),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF127FD2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x2E000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Parent Name
            Obx(
              () => Text(
                controller.name.value,
                style: const TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191C1D),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 4),
            // Parent Email
            Obx(
              () => Text(
                controller.email.value,
                style: const TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF414754),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 18),
            // Edit Profile Pill Button
            OutlinedButton(
              onPressed: controller.onEditProfile,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF717786)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text(
                'Edit Profile',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1D),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarFallback() {
    return Container(
      color: const Color(0xFFD8E2FF),
      alignment: Alignment.center,
      child: const Icon(Icons.person_rounded, size: 48, color: Color(0xFF0059BB)),
    );
  }

  Widget _buildMyChildrenSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Children',
            style: TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191C1D),
            ),
          ),
          const SizedBox(height: 14),
          // Children List
          Obx(
            () => ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.children.length,
              separatorBuilder: (context, i) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(color: Color(0xFFE1E3E4), height: 1),
              ),
              itemBuilder: (context, index) {
                final child = controller.children[index];
                return InkWell(
                  onTap: () => controller.onChildTap(child),
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: Image.network(
                              child.avatar,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, stack) => Container(
                                color: const Color(0xFFE0F6FF),
                                child: const Icon(Icons.person, color: Color(0xFF127FD2)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                child.name,
                                style: const TextStyle(
                                  fontFamily: 'Google Sans Flex',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF191C1D),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                child.grade,
                                style: const TextStyle(
                                  fontFamily: 'Google Sans Flex',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF414754),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0E3856),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: const Text(
                            'Linked',
                            style: TextStyle(
                              fontFamily: 'Google Sans Flex',
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFF6FEFF),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: Color(0xFFC1C6D7),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Action Buttons: Manage & Add
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: controller.onManageChildren,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0x1A0059BB),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Manage',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0059BB),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: controller.onAddChild,
                    icon: const Icon(Icons.add_rounded, color: Colors.white, size: 18),
                    label: const Text(
                      'Add',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF127FD2),
                      elevation: 1,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: const Color(0xFF127FD2),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x2E127FD2),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // Ambient watermark icon
            Positioned(
              right: -10,
              top: -10,
              child: Icon(
                Icons.stars_rounded,
                size: 80,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Family\nPlan',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFEFCFF),
                        height: 1.25,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          CircleAvatar(
                            radius: 4,
                            backgroundColor: Color(0xFF4ADE80),
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Active',
                            style: TextStyle(
                              fontFamily: 'Google Sans Flex',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFEFCFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  controller.subscriptionDetails.value,
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  onPressed: controller.onManageSubscription,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFEFCFF),
                    foregroundColor: const Color(0xFF127FD2),
                    elevation: 1,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  ),
                  child: const Text(
                    'Manage Subscription',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountSettingsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'ACCOUNT SETTINGS',
            style: TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: Color(0xFF414754),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
              border: Border.all(color: const Color(0xFFEDEEEF)),
            ),
            child: Column(
              children: [
                _buildSettingRow(
                  icon: Icons.person_rounded,
                  title: 'Personal Information',
                  onTap: controller.onPersonalInformation,
                ),
                const Divider(height: 1, color: Color(0xFFE1E3E4), indent: 16, endIndent: 16),
                _buildSettingRow(
                  icon: Icons.lock_rounded,
                  title: 'Password & Security',
                  onTap: controller.onPasswordSecurity,
                ),
                const Divider(height: 1, color: Color(0xFFE1E3E4), indent: 16, endIndent: 16),
                _buildSettingRow(
                  icon: Icons.language_rounded,
                  title: 'Language',
                  trailingText: controller.selectedLanguage,
                  onTap: controller.onLanguageTap,
                ),
                const Divider(height: 1, color: Color(0xFFE1E3E4), indent: 16, endIndent: 16),
                _buildSettingRow(
                  icon: Icons.notifications_rounded,
                  title: 'Notification Preferences',
                  subtitle: 'Manage updates about children',
                  onTap: controller.onNotificationPreferences,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacySupportSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'PRIVACY & SUPPORT',
            style: TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: Color(0xFF414754),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(14),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
              border: Border.all(color: const Color(0xFFEDEEEF)),
            ),
            child: Column(
              children: [
                _buildSettingRow(
                  icon: Icons.shield_outlined,
                  title: 'Privacy Policy',
                  trailingIcon: Icons.open_in_new_rounded,
                  onTap: controller.onPrivacyPolicy,
                ),
                const Divider(height: 1, color: Color(0xFFE1E3E4), indent: 16, endIndent: 16),
                _buildSettingRow(
                  icon: Icons.description_outlined,
                  title: 'Terms & Conditions',
                  trailingIcon: Icons.open_in_new_rounded,
                  onTap: controller.onTermsConditions,
                ),
                const Divider(height: 1, color: Color(0xFFE1E3E4), indent: 16, endIndent: 16),
                _buildSettingRow(
                  icon: Icons.help_outline_rounded,
                  title: 'Help & Support',
                  onTap: controller.onHelpSupport,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    String? subtitle,
    RxString? trailingText,
    IconData trailingIcon = Icons.chevron_right_rounded,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: const BoxDecoration(
                color: Color(0xFFE1E3E4),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF414754), size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF414754),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailingText != null) ...[
              Obx(
                () => Text(
                  trailingText.value,
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF414754),
                  ),
                ),
              ),
              const SizedBox(width: 4),
            ],
            Icon(
              trailingIcon,
              color: const Color(0xFFC1C6D7),
              size: trailingIcon == Icons.open_in_new_rounded ? 16 : 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0x4DFFDAD6), // rgba(255, 218, 214, 0.3)
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: controller.onLogOut,
            borderRadius: BorderRadius.circular(12),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.logout_rounded, color: Color(0xFFBA1A1A), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Log Out',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFBA1A1A),
                      letterSpacing: 0.14,
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
