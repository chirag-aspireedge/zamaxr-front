import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'children_account_controller.dart';

class ChildrenAccountView extends GetView<ChildrenAccountController> {
  const ChildrenAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF191C1D)),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              const Text(
                'Children’s Account',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191C1D),
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Select an option below to get started with setting up your child\'s educational experience.',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF414754),
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 36),
              // Option 1: Create New Account
              _buildOptionCard(
                icon: Icons.person_add_alt_1_rounded,
                iconBgColor: const Color(0xFFE0F6FF),
                iconColor: const Color(0xFF127FD2),
                title: 'Create New Account',
                subtitle: 'Set up a fresh profile for your child to begin their learning journey.',
                onTap: controller.onCreateNewAccount,
              ),
              const SizedBox(height: 20),
              // Option 2: Link Existing Account
              _buildOptionCard(
                icon: Icons.link_rounded,
                iconBgColor: const Color(0xFF0E3856),
                iconColor: const Color(0xFFF6FEFF),
                title: 'Link Existing Account',
                subtitle: 'Connect a profile already created by a school or another parent.',
                onTap: controller.onLinkExistingAccount,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionCard({
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECEFF2), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: const Color(0xFF127FD2).withValues(alpha: 0.08),
          highlightColor: const Color(0xFF127FD2).withValues(alpha: 0.04),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
            child: Row(
              children: [
                // Icon Circle
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 18),
                // Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF414754),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Trailing Arrow
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Color(0xFFEDEEEF),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Color(0xFF414754),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
