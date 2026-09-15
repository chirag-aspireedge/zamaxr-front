import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParentSubscriptionController extends GetxController {
  // Billing cycle: 'monthly' or 'yearly'
  final RxString billingCycle = 'monthly'.obs;

  // Selected plan: 'free', 'pro', 'family'
  final RxString selectedPlan = 'pro'.obs;

  // Monthly vs Yearly pricing details
  String get proPrice => billingCycle.value == 'monthly' ? '\$15' : '\$12';
  String get proPeriod => billingCycle.value == 'monthly' ? '/mo' : '/mo billed yearly';

  String get familyPrice => billingCycle.value == 'monthly' ? '\$25' : '\$20';
  String get familyPeriod => billingCycle.value == 'monthly' ? '/mo' : '/mo billed yearly';

  // Feature lists
  final List<String> proFeatures = [
    'More children',
    'Unlimited AI Tutor',
    'Unlimited Math Problem Solver',
    'Unlimited AI Quizzes',
    'Full AR/VR Experience',
    'Detailed Progress Reports',
    'West Africa Lesson Notes',
    'Unlimited AI Lesson Notes',
    'Certificates & Ad-free',
    'Offline Access & Priority Support',
  ];

  final List<String> familyFeatures = [
    'Higher child limit',
    '1 Individual Pro account included',
    'All Pro benefits included',
  ];

  final List<String> yearlyRewards = [
    'Bonus points',
    'Exclusive badge',
    'Higher reward rate',
    'Early access',
    'Special certificates',
  ];

  void setBillingCycle(String cycle) {
    billingCycle.value = cycle;
  }

  void onBack() {
    Get.back();
  }

  void onUpgradeToParentPro() {
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
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.star_rounded, color: Color(0xFF127FD2), size: 28),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upgrade to Parent Pro',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                    Text(
                      '$proPrice$proPeriod • Instant Access',
                      style: const TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 13,
                        color: Color(0xFF127FD2),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'Unlocks unlimited AI tutor support, full interactive 3D/AR modules, and comprehensive multi-child tracking.',
              style: TextStyle(fontSize: 13, color: Color(0xFF414754), height: 1.4),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127FD2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    'Success',
                    'Parent Pro activated successfully!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF127FD2),
                    colorText: Colors.white,
                  );
                },
                child: const Text(
                  'Confirm & Subscribe',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onChooseFamilyPlan() {
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
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F6FF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.family_restroom_rounded, color: Color(0xFF127FD2), size: 28),
                ),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Choose Family Plan',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                    Text(
                      '$familyPrice$familyPeriod • Full Family Tier',
                      style: const TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 13,
                        color: Color(0xFF127FD2),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              'Specially crafted for larger families needing comprehensive multi-device access with 1 included Pro account.',
              style: TextStyle(fontSize: 13, color: Color(0xFF414754), height: 1.4),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127FD2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Get.back();
                  Get.snackbar(
                    'Success',
                    'Family Plan activated successfully!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFF127FD2),
                    colorText: Colors.white,
                  );
                },
                child: const Text(
                  'Confirm Family Plan',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
