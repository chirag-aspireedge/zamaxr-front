import 'package:get/get.dart';
import 'subscription_model.dart';

class SubscriptionController extends GetxController {
  // Billing cycle toggle: false = Monthly, true = Yearly
  final RxBool isYearly = false.obs;

  // Selected plan identifier
  final RxString selectedPlanId = 'standard'.obs;

  // Current active plan info
  final RxString currentPlanName = 'School Starter'.obs;
  final RxString currentPlanType = 'FREE'.obs;
  final RxString currentPlanStatus = 'Active'.obs;

  // Standard Plan
  final standardPlan = const SubscriptionPlanModel(
    id: 'standard',
    name: 'School Standard',
    monthlyPrice: '\$--',
    yearlyPrice: '\$--',
    billingPeriod: '/ Month',
    isRecommended: true,
    features: [
      'Unlimited students/teachers',
      'Unlimited AI Tutor (Text + Voice)',
      'Math Problem Solver',
      'AI Quiz Generator',
      'Full AR/VR library access',
      'West Africa Lesson Notes',
      'Class Leaderboards & Rewards',
    ],
    ctaText: 'Upgrade To Standard',
    isPrimaryGradient: true,
  );

  // Premium Plan
  final premiumPlan = const SubscriptionPlanModel(
    id: 'premium',
    name: 'School Premium',
    monthlyPrice: '\$--',
    yearlyPrice: '\$--',
    billingPeriod: '/ Month',
    isRecommended: false,
    subheader: 'All Standard features, plus:',
    features: [
      'Custom Branding',
      'Advanced API Access',
      'Dedicated Account Manager',
      'Teacher Training Support',
    ],
    ctaText: 'Upgrade To Premium',
    isPrimaryGradient: false,
  );

  // Feature Comparison Table Data
  final List<FeatureComparisonItem> comparisonFeatures = const [
    FeatureComparisonItem(
      featureName: 'AI Tutor (Voice & Text)',
      standardAvailable: true,
      premiumAvailable: true,
    ),
    FeatureComparisonItem(
      featureName: 'Math Problem Solver',
      standardAvailable: true,
      premiumAvailable: true,
    ),
    FeatureComparisonItem(
      featureName: 'AR/VR Library',
      standardAvailable: true,
      standardText: 'Full',
      premiumAvailable: true,
      premiumText: 'Full',
    ),
    FeatureComparisonItem(
      featureName: 'Custom Branding',
      standardAvailable: false,
      premiumAvailable: true,
    ),
    FeatureComparisonItem(
      featureName: 'API Access',
      standardAvailable: false,
      premiumAvailable: true,
    ),
  ];

  void toggleBillingCycle(bool yearly) {
    isYearly.value = yearly;
  }

  void onViewPlanDetails() {
    Get.snackbar(
      'Current Plan',
      'You are currently on the School Starter Free Plan.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onUpgradePlan(SubscriptionPlanModel plan) {
    selectedPlanId.value = plan.id;
    Get.snackbar(
      'Upgrade Plan',
      'Proceeding to upgrade to ${plan.name} (${isYearly.value ? 'Yearly' : 'Monthly'}).',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
