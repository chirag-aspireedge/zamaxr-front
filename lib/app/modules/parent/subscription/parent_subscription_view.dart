import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'parent_subscription_controller.dart';

class ParentSubscriptionView extends GetView<ParentSubscriptionController> {
  const ParentSubscriptionView({super.key});

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
              _buildTopHeader(context),
              const SizedBox(height: 16),
              _buildFreeCurrentPlanCard(context),
              const SizedBox(height: 20),
              _buildBillingCycleToggle(context),
              const SizedBox(height: 24),
              _buildParentProCard(context),
              const SizedBox(height: 24),
              _buildFamilyPlanCard(context),
              const SizedBox(height: 24),
              _buildYearlyRewardsSection(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // 1. Top Header with Back Button, Title, and Subtitle
  Widget _buildTopHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: IconButton(
              onPressed: controller.onBack,
              icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1567A2)),
              tooltip: 'Back',
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Subscription',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF191C1D),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Choose the plan that works best for your family',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
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

  // 2. Free Current Plan Card
  Widget _buildFreeCurrentPlanCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF127FD2).withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF127FD2).withValues(alpha: 0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Free',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF191C1D),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFF127FD2),
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: const Text(
                    'Active',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF6FEFF),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Up to 2 children',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF127FD2),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Your free plan supports up to 2 children. Upgrade to unlock more features and support more children.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF414754),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. Billing Cycle Toggle (Monthly vs Yearly)
  Widget _buildBillingCycleToggle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F6FF),
              borderRadius: BorderRadius.circular(53),
            ),
            child: Obx(() {
              final isMonthly = controller.billingCycle.value == 'monthly';
              return Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () => controller.setBillingCycle('monthly'),
                      borderRadius: BorderRadius.circular(53),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: isMonthly ? const Color(0xFF127FD2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(53),
                        ),
                        child: Center(
                          child: Text(
                            'Monthly',
                            style: TextStyle(
                              fontFamily: 'Google Sans Flex',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: isMonthly ? Colors.white : const Color(0xFF414754),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => controller.setBillingCycle('yearly'),
                      borderRadius: BorderRadius.circular(53),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: !isMonthly ? const Color(0xFF127FD2) : Colors.transparent,
                          borderRadius: BorderRadius.circular(53),
                        ),
                        child: Center(
                          child: Text(
                            'Yearly',
                            style: TextStyle(
                              fontFamily: 'Google Sans Flex',
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: !isMonthly ? Colors.white : const Color(0xFF414754),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
          const SizedBox(height: 8),
          // Save with Yearly pill badge
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFF222222),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.local_offer_rounded, size: 14, color: Colors.white),
                  SizedBox(width: 6),
                  Text(
                    'Save with Yearly',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4. Parent Pro Card (Highlighted Tier)
  Widget _buildParentProCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF127FD2), width: 2),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1A127FD2),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recommended Badge
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: const BoxDecoration(
                    color: Color(0xFF127FD2),
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10)),
                  ),
                  child: const Text(
                    'Recommended',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Parent Pro',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Price Row
                    Obx(
                      () => Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            controller.proPrice,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF191C1D),
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            controller.proPeriod,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF414754),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'More features for families with multiple children.',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        color: Color(0xFF414754),
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Upgrade Button
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF52B4DF), Color(0xFF11629E)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF11629E).withValues(alpha: 0.25),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: controller.onUpgradeToParentPro,
                            borderRadius: BorderRadius.circular(10),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Center(
                                child: Text(
                                  'UPGRADE TO PARENT PRO',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Features list
                    for (final feature in controller.proFeatures) ...[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            size: 18,
                            color: Color(0xFF127FD2),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF191C1D),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                    ],
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 5. Family Plan Card
  Widget _buildFamilyPlanCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE1E3E4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Family Plan',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 6),
            // Price Row
            Obx(
              () => Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    controller.familyPrice,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    controller.familyPeriod,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF414754),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Designed for larger families needing comprehensive access.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: Color(0xFF414754),
              ),
            ),
            const SizedBox(height: 16),
            // Outline Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: controller.onChooseFamilyPlan,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF127FD2), width: 1.5),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  'CHOOSE FAMILY PLAN',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF127FD2),
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 18),
            // Feature check items
            for (final feature in controller.familyFeatures) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_rounded,
                    size: 18,
                    color: Color(0xFF476083),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      feature,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ],
        ),
      ),
    );
  }

  // 6. Yearly Rewards Section (Chips / Highlights)
  Widget _buildYearlyRewardsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFFF0FBFF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFD0E7EA)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.card_giftcard_rounded,
                  size: 20,
                  color: Color(0xFF445D80),
                ),
                SizedBox(width: 8),
                Text(
                  'Yearly plan rewards',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF445D80),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final reward in controller.yearlyRewards)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      reward,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF191C1D),
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
}
