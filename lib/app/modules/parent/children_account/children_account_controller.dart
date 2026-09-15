import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ChildrenAccountController extends GetxController {
  void onCreateNewAccount() {
    Get.toNamed(Routes.PARENT_ADD_CHILD);
  }

  void onLinkExistingAccount() {
    _showLinkStudentBottomSheet();
  }

  void _showLinkStudentBottomSheet() {
    final studentIdController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFF0E3856),
                      child: Icon(Icons.link_rounded, color: Colors.white, size: 20),
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Link Student Account',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Enter your child’s student code or registered school email to link their account.',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 13,
                color: Color(0xFF414754),
                height: 1.4,
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: studentIdController,
              decoration: InputDecoration(
                hintText: 'e.g. STU-2024 or student@school.edu',
                hintStyle: const TextStyle(color: Color(0xFF717786), fontSize: 14),
                prefixIcon: const Icon(Icons.badge_outlined, color: Color(0xFF127FD2)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFE1E3E4)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF127FD2), width: 1.5),
                ),
                filled: true,
                fillColor: const Color(0xFFF9FAFC),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0E5E9B),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  final code = studentIdController.text.trim();
                  if (code.isEmpty) {
                    Get.snackbar(
                      'Student Code Required',
                      'Please enter student ID or email',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    return;
                  }
                  Get.back();
                  Get.snackbar(
                    'Link Request Sent',
                    'A verification request has been sent for student $code.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF0E5E9B),
                    colorText: Colors.white,
                  );
                },
                child: const Text(
                  'Send Link Request',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
