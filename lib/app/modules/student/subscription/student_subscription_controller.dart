import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SubscriptionBillingCycle { monthly, yearly }

class StudentSubscriptionController extends GetxController {
  final Rx<SubscriptionBillingCycle> selectedCycle =
      SubscriptionBillingCycle.yearly.obs;

  String get proPrice =>
      selectedCycle.value == SubscriptionBillingCycle.yearly ? '\$7.99' : '\$9.99';

  String get billingFrequency =>
      selectedCycle.value == SubscriptionBillingCycle.yearly
          ? 'Billed annually'
          : 'Billed monthly';

  void setCycle(SubscriptionBillingCycle cycle) {
    selectedCycle.value = cycle;
  }

  void onBack() {
    Get.back();
  }

  void onUpgrade() {
    Get.snackbar(
      'Upgrade to Pro',
      'Processing subscription upgrade for \$$proPrice/mo...',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }
}
