import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'student_subscription_controller.dart';

class StudentSubscriptionView extends GetView<StudentSubscriptionController> {
  const StudentSubscriptionView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<StudentSubscriptionController>()) {
      Get.put(StudentSubscriptionController());
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          bottom: false,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 14,
              bottom: 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Top Header with Back Button, Title, and Subtitle
                _buildHeader(),
                const SizedBox(height: 20),

                // 2. Current Plan Card (Free - Active)
                _buildCurrentPlanCard(),
                const SizedBox(height: 20),

                // 3. Billing Cycle Toggle (Monthly / Yearly)
                _buildBillingCycleToggle(),
                const SizedBox(height: 20),

                // 4. Individual Pro Card
                _buildIndividualProCard(),
                const SizedBox(height: 28),

                // 5. Compare Plans Section
                _buildComparePlansSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 1. Top Header
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Circular Back Button with shadow (Ellipse 18)
        GestureDetector(
          onTap: controller.onBack,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
              border: Border.all(
                color: const Color(0xFFEFF2F6),
                width: 1,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF1567A2),
              size: 20,
            ),
          ),
        ),
        const SizedBox(width: 14),

        // Title and Subtitle
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Subscription',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191C1D),
                  letterSpacing: -0.2,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Choose the plan that works best for your family',
                style: TextStyle(
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
      ],
    );
  }

  // 2. Current Plan Card
  Widget _buildCurrentPlanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF127FD2), width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(18, 127, 210, 0.15),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row: "Free" + "Active" badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Free',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1D),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF127FD2),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Text(
                  'Active',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF6FEFF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // "Current Plan"
          const Text(
            'Current Plan',
            style: TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF127FD2),
            ),
          ),
          const SizedBox(height: 4),

          // "Your free plan is active"
          const Text(
            'Your free plan is active',
            style: TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF414754),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Billing Cycle Toggle (Monthly / Yearly)
  Widget _buildBillingCycleToggle() {
    return Container(
      width: double.infinity,
      height: 54,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F6FF),
        borderRadius: BorderRadius.circular(53),
      ),
      child: Obx(() {
        final isMonthly =
            controller.selectedCycle.value == SubscriptionBillingCycle.monthly;

        return Row(
          children: [
            // Monthly Tab
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setCycle(SubscriptionBillingCycle.monthly),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: isMonthly ? const Color(0xFF127FD2) : Colors.transparent,
                    borderRadius: BorderRadius.circular(53),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Monthly',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: isMonthly ? Colors.white : const Color(0xFF414754),
                    ),
                  ),
                ),
              ),
            ),

            // Yearly Tab
            Expanded(
              child: GestureDetector(
                onTap: () => controller.setCycle(SubscriptionBillingCycle.yearly),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: !isMonthly ? const Color(0xFF127FD2) : Colors.transparent,
                    borderRadius: BorderRadius.circular(53),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Yearly',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: !isMonthly ? Colors.white : const Color(0xFF414754),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // 4. Main Individual Pro Card
  Widget _buildIndividualProCard() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8ECEF), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Top-right subtle decorative curved gradient
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(9999),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(0, 89, 187, 0.12),
                    Color.fromRGBO(189, 214, 255, 0.05),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Plan Title + Price
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Left: "Individual Pro" + "Unlock the full experience"
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Individual Pro',
                            style: TextStyle(
                              fontFamily: 'Google Sans Flex',
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0059BB),
                              letterSpacing: -0.2,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Unlock the full experience',
                            style: TextStyle(
                              fontFamily: 'Google Sans Flex',
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF414754),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Right: "$[PRICE]/mo" + "Billed annually"
                    Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            '${controller.proPrice}/mo',
                            style: const TextStyle(
                              fontFamily: 'Google Sans Flex',
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF191C1D),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            controller.billingFrequency,
                            style: const TextStyle(
                              fontFamily: 'Google Sans Flex',
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF414754),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Bullet points
                _buildFeatureBullet(
                  icon: PhosphorIcons.brain(PhosphorIconsStyle.bold),
                  text: 'Unlimited AI Tutor',
                ),
                const SizedBox(height: 12),
                _buildFeatureBullet(
                  icon: Icons.view_in_ar_rounded,
                  text: 'Full AR/VR Library',
                ),
                const SizedBox(height: 12),
                _buildFeatureBullet(
                  icon: PhosphorIcons.certificate(PhosphorIconsStyle.bold),
                  text: 'Certificates of Completion',
                ),
                const SizedBox(height: 12),
                _buildFeatureBullet(
                  icon: PhosphorIcons.prohibit(PhosphorIconsStyle.bold),
                  text: 'Ad-free Experience',
                ),
                const SizedBox(height: 22),

                // "Upgrade To Pro" Gradient Button (Rectangle 8)
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF56B9E3), Color(0xFF0E5E9B)],
                      ),
                      borderRadius: BorderRadius.circular(74),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0E5E9B).withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: controller.onUpgrade,
                        borderRadius: BorderRadius.circular(74),
                        child: const Center(
                          child: Text(
                            'Upgrade To Pro',
                            style: TextStyle(
                              fontFamily: 'Google Sans Flex',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.2,
                            ),
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
    );
  }

  Widget _buildFeatureBullet({
    required IconData icon,
    required String text,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color(0xFF0059BB),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF191C1D),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // 5. Compare Plans Section
  Widget _buildComparePlansSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Compare Plans',
          style: TextStyle(
            fontFamily: 'Google Sans Flex',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF191C1D),
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 12),

        // Comparison Table Container
        Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFFE0F6FF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFD0EDFB), width: 1),
          ),
          child: Column(
            children: [
              // Table Header
              Container(
                color: const Color.fromRGBO(18, 127, 210, 0.15),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: const Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Feature',
                        style: TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF414754),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Basic',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF414754),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Pro',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0059BB),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Row 1: AR/VR Library
              _buildComparisonRow(
                feature: 'AR/VR Library',
                basic: 'Limited',
                pro: 'Full',
                showBottomDivider: true,
              ),

              // Row 2: AI Tutor
              _buildComparisonRow(
                feature: 'AI Tutor',
                basic: '1hr/day',
                pro: 'Unlimited',
                showBottomDivider: true,
              ),

              // Row 3: Certificates
              _buildComparisonIconRow(
                feature: 'Certificates',
                basicHas: false,
                proHas: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComparisonRow({
    required String feature,
    required String basic,
    required String pro,
    bool showBottomDivider = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: showBottomDivider
            ? const Border(
                bottom: BorderSide(color: Color(0xFFE1E3E4), width: 1),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              feature,
              style: const TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF191C1D),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              basic,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF414754),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              pro,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComparisonIconRow({
    required String feature,
    required bool basicHas,
    required bool proHas,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              feature,
              style: const TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF191C1D),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: basicHas
                  ? const Icon(Icons.check_rounded, size: 16, color: Color(0xFF0059BB))
                  : const Icon(Icons.close_rounded, size: 15, color: Color(0xFF717786)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: proHas
                  ? const Icon(Icons.check_rounded, size: 18, color: Color(0xFF0059BB))
                  : const Icon(Icons.close_rounded, size: 15, color: Color(0xFF717786)),
            ),
          ),
        ],
      ),
    );
  }
}
