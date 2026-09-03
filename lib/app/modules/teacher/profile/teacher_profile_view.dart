import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'teacher_profile_controller.dart';

class TeacherProfileView extends GetView<TeacherProfileController> {
  const TeacherProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    const fontFamily = AppTextStyle.fontFamily;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Top subtle gradient: 176px height (180deg from rgba(18,127,210,0.2) to 0)
            Container(
              height: 176,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x33127FD2),
                    Color(0x00127FD2),
                  ],
                ),
              ),
            ),

            // Profile Content Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 104),

                // Center Avatar Container (96x96, 2px white border, shadow, edit button)
                Center(child: _buildAvatar(controller)),
                const SizedBox(height: 16),

                // Teacher Name: Sarah Johnson (24px, FontWeight.w700, #191C1D)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Obx(
                    () => Text(
                      controller.teacherName.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                        height: 32 / 24,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),

                // Email: sarah.johnson@example.com (16px, FontWeight.w400, #414754)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Obx(
                    () => Text(
                      controller.email.value,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF414754),
                        height: 24 / 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Institution Pill: ABC International Institute (Background #E0F6FF, border-radius: 9999px)
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0F6FF),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssets.iconSchoolCap,
                          width: 15,
                          height: 12,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF4B6062),
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Obx(
                            () => Text(
                              controller.institution.value,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF4B6062),
                                height: 16 / 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Four Action Menu Items (88px height each, with #EDEEEF dividers)
                _buildMenuItem(
                  iconAsset: AppAssets.iconProfileLanguage,
                  iconColor: const Color(0xFF127FD2),
                  title: 'Language',
                  subtitle: controller.selectedLanguage.value,
                  onTap: controller.onLanguageTap,
                  isObxSubtitle: true,
                ),
                _buildDivider(),

                _buildMenuItem(
                  iconAsset: AppAssets.iconProfileBell,
                  iconColor: const Color(0xFF476083),
                  title: 'Notifications',
                  subtitle: 'Manage notification preferences',
                  onTap: controller.onNotificationsTap,
                ),
                _buildDivider(),

                _buildMenuItem(
                  iconAsset: AppAssets.iconProfileLock,
                  iconColor: const Color(0xFF4B6062),
                  title: 'Change Password',
                  subtitle: 'Update your account password',
                  onTap: controller.onChangePasswordTap,
                ),
                _buildDivider(),

                _buildMenuItem(
                  iconAsset: AppAssets.iconProfileAccount,
                  iconColor: const Color(0xFF004493),
                  title: 'Account',
                  subtitle: 'Manage account settings',
                  onTap: controller.onAccountTap,
                ),
                const SizedBox(height: 36),

                // Logout Button: 318x54, #FFEDED, inset shadow, 52px radius
                Center(
                  child: GestureDetector(
                    onTap: controller.onLogoutTap,
                    child: Container(
                      width: 318,
                      height: 54,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEDED),
                        borderRadius: BorderRadius.circular(52),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            AppAssets.iconProfileLogout,
                            width: 22,
                            height: 22,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFFC90000),
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Logout',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFD00000),
                              height: 23 / 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Bottom padding to clear floating navigation bar (61px + 24px + extra)
                const SizedBox(height: 110),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar(TeacherProfileController controller) {
    return SizedBox(
      width: 96,
      height: 96,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 96x96 Avatar with 2px white border and shadow
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Obx(
                () => Image.asset(
                  controller.avatarAsset.value,
                  width: 96,
                  height: 96,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFE0F6FF),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 48,
                        color: Color(0xFF127FD2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Edit Button (32x32 #0059BB circle with white edit pencil icon)
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: controller.onEditAvatar,
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0059BB),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required String iconAsset,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isObxSubtitle = false,
  }) {
    const fontFamily = AppTextStyle.fontFamily;

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
        child: Row(
          children: [
            // 40x40 circular light blue container
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE0F6FF),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconAsset,
                  width: 20,
                  height: 20,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Title & Subtitle Column
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF191C1D),
                      height: 24 / 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (isObxSubtitle)
                    Obx(
                      () => Text(
                        controller.selectedLanguage.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF414754),
                          height: 16 / 12,
                        ),
                      ),
                    )
                  else
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF414754),
                        height: 16 / 12,
                      ),
                    ),
                ],
              ),
            ),

            // Trailing Chevron: #414754
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFF414754),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 80.0, right: 24.0),
      child: Divider(
        height: 1,
        thickness: 1,
        color: Color(0xFFEDEEEF),
      ),
    );
  }
}
