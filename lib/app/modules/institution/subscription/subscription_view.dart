import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import 'subscription_controller.dart';

class SubscriptionView extends GetView<SubscriptionController> {
  const SubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<SubscriptionController>()) {
      Get.put(SubscriptionController());
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            _buildTopAppBar(context),

            // Scrollable Content Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),

                    // Section 1: Current Plan Card
                    _buildCurrentPlanCard(),
                    const SizedBox(height: 24),

                    // Section 2: Billing Toggle (Monthly / Yearly)
                    _buildBillingToggle(),
                    const SizedBox(height: 28),

                    // Section 3: Plan 1 - School Standard (Recommended)
                    _buildRecommendedStandardPlanCard(),
                    const SizedBox(height: 24),

                    // Section 4: Plan 2 - School Premium
                    _buildPremiumPlanCard(),
                    const SizedBox(height: 32),

                    // Section 5: Compare Features Table
                    _buildCompareFeaturesSection(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top App Bar (Back Button + Title & Subtitle)
  // ---------------------------------------------------------------------------
  Widget _buildTopAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (Navigator.of(context).canPop()) {
                    Get.back();
                  }
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE0F6FF),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16,
                      color: Color(0xFF127FD2),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Text(
                'Subscription',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF131313),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Choose the plan that fits your institution.',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF414754),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1: Current Plan Card (#FBFBFB, 12px radius, shadow)
  // ---------------------------------------------------------------------------
  Widget _buildCurrentPlanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFBFB),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Plan Name + FREE Badge | Active Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.currentPlanName.value,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFF127FD2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      controller.currentPlanType.value,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              // Active Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F6FF),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF20E679),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      controller.currentPlanStatus.value,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: Color(0xFF0E3856),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Plan Description
          const Text(
            'Unlock advanced AI features and institutional management tools with premium plans.',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF414754),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),

          // Action: View Plan Details
          GestureDetector(
            onTap: controller.onViewPlanDetails,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Text(
                  'View Plan Details',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0059BB),
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 11,
                  color: Color(0xFF0059BB),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2: Billing Toggle (Exact matching Figma: 64px pill + bottom badge)
  // ---------------------------------------------------------------------------
  Widget _buildBillingToggle() {
    return Obx(() {
      final isYearly = controller.isYearly.value;

      return Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // 1. "Save with Yearly" Bottom Attached Badge (#222222, 0 0 7px 7px)
              Positioned(
                bottom: -26,
                right: 20,
                child: Container(
                  width: 156,
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    color: Color(0xFF222222),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Icon(
                        Remix.price_tag_3_line,
                        size: 14,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Save with Yearly',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 2. Main Pill Switch (#E0F6FF, 64px height, 53px radius)
              Container(
                width: double.infinity,
                height: 64,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F6FF),
                  borderRadius: BorderRadius.circular(53),
                ),
                child: Row(
                  children: [
                    // Monthly Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.toggleBillingCycle(false),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: !isYearly
                                ? const Color(0xFF127FD2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(53),
                          ),
                          child: Center(
                            child: Text(
                              'Monthly',
                              style: TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: !isYearly
                                    ? Colors.white
                                    : const Color(0xFF414754),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Yearly Tab
                    Expanded(
                      child: GestureDetector(
                        onTap: () => controller.toggleBillingCycle(true),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: isYearly
                                ? const Color(0xFF127FD2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(53),
                          ),
                          child: Center(
                            child: Text(
                              'Yearly',
                              style: TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: isYearly
                                    ? Colors.white
                                    : const Color(0xFF414754),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
        ],
      );
    });
  }

  // ---------------------------------------------------------------------------
  // Section 3: Plan 1 - School Standard (Recommended Card)
  // ---------------------------------------------------------------------------
  Widget _buildRecommendedStandardPlanCard() {
    final plan = controller.standardPlan;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Main Standard Card
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 26, 20, 24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF127FD2),
              width: 1.5,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x14000000),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
              BoxShadow(
                color: Color(0x08000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 6),

              // Plan Title
              Text(
                plan.name,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 8),

              // Price Row: $-- / Month
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    plan.monthlyPrice,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF127FD2),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    plan.billingPeriod,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF414754),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Features Checklist
              Column(
                children: plan.features.map((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Blue Checkmark Icon
                        Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF127FD2),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              size: 11,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),

                        // Feature Text
                        Expanded(
                          child: Text(
                            feature,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF191C1D),
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Primary Upgrade Button (Rectangle 7 Gradient 318x54)
              Center(
                child: GestureDetector(
                  onTap: () => controller.onUpgradePlan(plan),
                  child: Container(
                    width: 318,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(52),
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color(0xFF56B9E3),
                          Color(0xFF0E5E9B),
                        ],
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'Upgrade To Standard',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // "RECOMMENDED" Top Floating Pill Badge
        Positioned(
          top: -12,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F6FF),
              borderRadius: BorderRadius.circular(9999),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: const Text(
              'RECOMMENDED',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: Color(0xFF127FD2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4: Plan 2 - School Premium Card
  // ---------------------------------------------------------------------------
  Widget _buildPremiumPlanCard() {
    final plan = controller.premiumPlan;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFC1C6D7).withValues(alpha: 0.4),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Plan Title
          Text(
            plan.name,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191C1D),
            ),
          ),
          const SizedBox(height: 8),

          // Price Row: $-- / Month
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                plan.monthlyPrice,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(width: 4),
              Text(
                plan.billingPeriod,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF414754),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Subheader: "All Standard features, plus:"
          if (plan.subheader != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  const Icon(
                    Remix.sparkling_fill,
                    size: 15,
                    color: Color(0xFF476083),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    plan.subheader!,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                ],
              ),
            ),

          // Features Checklist
          Column(
            children: plan.features.map((feature) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 2),
                      child: Icon(
                        Remix.check_line,
                        size: 15,
                        color: Color(0xFF476083),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        feature,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF191C1D),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 16),

          // Secondary Action Button (Overlay+Border: #E0F6FF, #127FD2 border)
          GestureDetector(
            onTap: () => controller.onUpgradePlan(plan),
            child: Container(
              height: 44,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE0F6FF),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF127FD2),
                  width: 1,
                ),
              ),
              child: const Center(
                child: Text(
                  'Upgrade To Premium',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF3A4346),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 5: Compare Features Section (Alternating Striped Table)
  // ---------------------------------------------------------------------------
  Widget _buildCompareFeaturesSection() {
    final features = controller.comparisonFeatures;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Compare Features',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF191C1D),
          ),
        ),
        const SizedBox(height: 14),

        // Comparison Table Container
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFFC1C6D7).withValues(alpha: 0.3),
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 4,
                offset: Offset(0, 1),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: List.generate(features.length, (index) {
              final item = features[index];
              final isStriped = index % 2 == 1;
              final isLast = index == features.length - 1;

              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isStriped ? const Color(0xFFF8F9FA) : Colors.white,
                  border: isLast
                      ? null
                      : const Border(
                          bottom: BorderSide(
                            color: Color(0xFFE1E3E4),
                            width: 1,
                          ),
                        ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Feature Name
                    Expanded(
                      flex: 3,
                      child: Text(
                        item.featureName,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                    ),

                    // Columns: Standard & Premium
                    Row(
                      children: [
                        // Standard Column
                        SizedBox(
                          width: 56,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Standard',
                                style: TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF414754),
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (item.standardText != null)
                                Text(
                                  item.standardText!,
                                  style: const TextStyle(
                                    fontFamily: AppTextStyle.fontFamily,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF191C1D),
                                  ),
                                )
                              else if (item.standardAvailable)
                                const Icon(
                                  Remix.check_line,
                                  size: 16,
                                  color: Color(0xFF127FD2),
                                )
                              else
                                const Icon(
                                  Remix.subtract_line,
                                  size: 16,
                                  color: Color(0xFFC1C6D7),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 14),

                        // Premium Column
                        SizedBox(
                          width: 56,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Premium',
                                style: TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF414754),
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (item.premiumText != null)
                                Text(
                                  item.premiumText!,
                                  style: const TextStyle(
                                    fontFamily: AppTextStyle.fontFamily,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF191C1D),
                                  ),
                                )
                              else if (item.premiumAvailable)
                                const Icon(
                                  Remix.check_line,
                                  size: 16,
                                  color: Color(0xFF127FD2),
                                )
                              else
                                const Icon(
                                  Remix.subtract_line,
                                  size: 16,
                                  color: Color(0xFFC1C6D7),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
