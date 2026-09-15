import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../routes/app_pages.dart';
import '../../individual/home/individual_home_controller.dart';
import 'student_rewards_controller.dart';

class StudentRewardsView extends GetView<StudentRewardsController> {
  final bool showBottomNav;
  const StudentRewardsView({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    // Ensure controller is registered if opened directly or as tab
    final c = Get.isRegistered<StudentRewardsController>()
        ? Get.find<StudentRewardsController>()
        : Get.put(StudentRewardsController());

    final canPop = Navigator.canPop(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(left: 20, right: 20, top: 14, bottom: 110),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header: Rewards + Wallet Icon
                    _buildHeader(c, canPop),

                const SizedBox(height: 18),

                // 2. Reward Balance Card (Gradient Blue)
                _buildRewardBalanceCard(c),

                const SizedBox(height: 14),

                // 3. 1 Day Premium Access Card
                _buildPremiumAccessCard(c),

                const SizedBox(height: 12),

                // 4. Your Ranking Card
                _buildRankingCard(c),

                const SizedBox(height: 24),

                // 5. Earn More Rewards Section
                _buildEarnMoreRewardsSection(c),

                const SizedBox(height: 24),

                // 6. Achievements Section
                _buildAchievementsSection(c),

                const SizedBox(height: 24),

                // 7. Use Your Rewards Section
                _buildUseYourRewardsSection(c),

                const SizedBox(height: 24),

                // 8. Recent Activity Section
                _buildRecentActivitySection(c),

                const SizedBox(height: 32),
              ],
            ),
          ),
          if (showBottomNav)
            Positioned(
              left: 20,
              right: 20,
              bottom: 24,
              child: _buildStandaloneBottomNav(),
            ),
        ],
      ),
    ),
  ),
);
}

  // ==========================================
  // 1. TOP HEADER (Rewards + Wallet Button)
  // ==========================================
  Widget _buildHeader(StudentRewardsController c, bool canPop) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (canPop) ...[
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 38,
                  height: 38,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F8F8),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE5E7EB),
                      width: 1,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    size: 18,
                    color: Color(0xFF191C1D),
                  ),
                ),
              ),
            ],
            const Text(
              'Rewards',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
                letterSpacing: -0.2,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: c.onWalletTap,
          child: Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFFF8F8F8),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(
              PhosphorIcons.wallet(PhosphorIconsStyle.bold),
              size: 18,
              color: const Color(0xFF191C1D),
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 2. REWARD BALANCE CARD
  // ==========================================
  Widget _buildRewardBalanceCard(StudentRewardsController c) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1466A1),
            Color(0xFF51B2DE),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.06),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Overlay+Blur Circle
          Positioned(
            right: -40,
            top: -40,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ),
          ),

          // Content with standard mobile padding
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: REWARD BALANCE + Synced Pill
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        'REWARD BALANCE',
                        style: TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.85),
                          letterSpacing: 0.6,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: c.onSyncTap,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9999),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Obx(
                                  () => c.isSynced.value
                                      ? const Icon(
                                          Icons.sync_rounded,
                                          size: 11,
                                          color: Colors.white,
                                        )
                                      : const SizedBox(
                                          width: 10,
                                          height: 10,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.5,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'Synced',
                                  style: TextStyle(
                                    fontFamily: 'Google Sans Flex',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Middle: 120 Credits
                Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '${c.rewardBalance.value}',
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.6,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Credits',
                        style: TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),

                // Bottom Description
                Text(
                  'Keep learning and complete activities to earn more rewards.',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 1.4,
                    color: Colors.white.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 3. 1 DAY PREMIUM ACCESS CARD
  // ==========================================
  Widget _buildPremiumAccessCard(StudentRewardsController c) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFE1E3E4),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Icon Box (44x44, radius 10, #127FD2)
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFF127FD2),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(
              PhosphorIcons.medal(PhosphorIconsStyle.fill),
              size: 20,
              color: const Color(0xFFF6FEFF),
            ),
          ),
          const SizedBox(width: 14),

          // Title & Subtitle
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1 Day Premium Access',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                    color: Color(0xFF191C1D),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Unlocked',
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
          const SizedBox(width: 8),

          // Time Left countdown
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Time Left',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF127FD2),
                ),
              ),
              const SizedBox(height: 2),
              Obx(
                () => Text(
                  c.formattedCountdown,
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF191C1D),
                    letterSpacing: 0.1,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 4. YOUR RANKING CARD
  // ==========================================
  Widget _buildRankingCard(StudentRewardsController c) {
    return Container(
      width: double.infinity,
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFEDEEEF),
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                PhosphorIcons.chartBar(PhosphorIconsStyle.fill),
                size: 18,
                color: const Color(0xFF127FD2),
              ),
              const SizedBox(width: 8),
              const Text(
                'Your Ranking',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                  color: Color(0xFF191C1D),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Obx(
            () => Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFF0059BB).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                c.ranking.value,
                style: const TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.1,
                  color: Color(0xFF127FD2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 5. EARN MORE REWARDS SECTION
  // ==========================================
  Widget _buildEarnMoreRewardsSection(StudentRewardsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Earn More Rewards',
          style: TextStyle(
            fontFamily: 'Google Sans Flex',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF191C1D),
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 12),
        Column(
          children: c.earnMoreRewards
              .map((item) => _buildEarnRewardRow(item))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildEarnRewardRow(EarnRewardItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: GestureDetector(
        onTap: item.onTap,
        child: Container(
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.04),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
            border: Border.all(
              color: const Color(0xFFF1F2F4),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Icon Box (38x38, #E0F6FF, radius 8)
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F6FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Icon(
                  item.icon,
                  size: 18,
                  color: const Color(0xFF445D80),
                ),
              ),
              const SizedBox(width: 14),

              // Title
              Expanded(
                child: Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                    color: Color(0xFF191C1D),
                  ),
                ),
              ),
              const SizedBox(width: 8),

              // Points badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF127FD2),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  item.points,
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 6. ACHIEVEMENTS SECTION
  // ==========================================
  Widget _buildAchievementsSection(StudentRewardsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Achievements',
          style: TextStyle(
            fontFamily: 'Google Sans Flex',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF191C1D),
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 12),
        // 2x2 Grid with standard mobile scaling
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: c.achievements.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.28,
          ),
          itemBuilder: (context, index) {
            final item = c.achievements[index];
            return _buildAchievementCard(c, item);
          },
        ),
      ],
    );
  }

  Widget _buildAchievementCard(
      StudentRewardsController c, AchievementItem item) {
    final unlocked = item.isUnlocked;
    return GestureDetector(
      onTap: () => c.onAchievementTap(item),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        decoration: BoxDecoration(
          color: unlocked
              ? Colors.white
              : const Color(0xFFEDEEEF).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(12),
          gradient: unlocked
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF0059BB).withValues(alpha: 0.05),
                    Colors.white,
                  ],
                )
              : null,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.04),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
          border: Border.all(
            color: unlocked ? const Color(0xFFE2E8F0) : const Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular Badge (42x42)
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: unlocked
                    ? const Color(0xFF127FD2)
                    : const Color(0xFFE1E3E4),
              ),
              alignment: Alignment.center,
              child: Icon(
                item.icon,
                size: 20,
                color: unlocked ? Colors.white : const Color(0xFF414754),
              ),
            ),
            const SizedBox(height: 6),

            // Title
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 2),

            // Status
            Text(
              unlocked ? 'Unlocked' : 'Locked',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: unlocked
                    ? const Color(0xFF127FD2)
                    : const Color(0xFF414754),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 7. USE YOUR REWARDS SECTION
  // ==========================================
  Widget _buildUseYourRewardsSection(StudentRewardsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Use Your Rewards',
          style: TextStyle(
            fontFamily: 'Google Sans Flex',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF191C1D),
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 178,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: c.rewardsCatalog.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final item = c.rewardsCatalog[index];
              return _buildCatalogCard(c, item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCatalogCard(StudentRewardsController c, RewardCatalogItem item) {
    return GestureDetector(
      onTap: () => c.onRedeemReward(item),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.05),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
          border: Border.all(
            color: const Color(0xFFF1F2F4),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover Image (156x88, radius 8)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                item.assetPath,
                height: 88,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 88,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F172A), Color(0xFF0284C7)],
                      ),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),

            // Title
            Text(
              item.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 13,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.1,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 2),

            // Subtitle + Cost badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF414754),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F6FF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${item.costCredits} pts',
                    style: const TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0059BB),
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

  // ==========================================
  // 8. RECENT ACTIVITY SECTION
  // ==========================================
  Widget _buildRecentActivitySection(StudentRewardsController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activity',
          style: TextStyle(
            fontFamily: 'Google Sans Flex',
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF191C1D),
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 14),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: c.recentActivity.length,
          itemBuilder: (context, index) {
            final item = c.recentActivity[index];
            final isLast = index == c.recentActivity.length - 1;
            return _buildActivityRow(item, isLast);
          },
        ),
      ],
    );
  }

  Widget _buildActivityRow(RewardActivityItem item, bool isLast) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator with vertical connector line
          Column(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF0059BB).withValues(alpha: 0.1),
                ),
                alignment: Alignment.center,
                child: Icon(
                  item.icon,
                  size: 14,
                  color: const Color(0xFF0059BB),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 1,
                    color: const Color(0xFFC1C6D7),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),

          // Details
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Google Sans Flex',
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.1,
                            color: Color(0xFF191C1D),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        item.timeAgo,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF414754),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.points,
                    style: const TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0059BB),
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

  // Floating Pill Bottom Navigation Bar (Figma Rectangle 17)
  Widget _buildStandaloneBottomNav() {
    return Container(
      height: 61,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(53),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(9, 30, 66, 0.25),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: Color.fromRGBO(9, 30, 66, 0.08),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildNavItem(
            index: 0,
            icon: PhosphorIconsBold.house,
            isSelected: false,
            onTap: () {
              if (Get.isRegistered<IndividualHomeController>()) {
                Get.find<IndividualHomeController>().currentNavIndex.value = 0;
                Get.back();
              } else {
                Get.offAllNamed(Routes.INDIVIDUAL_HOME);
              }
            },
          ),
          _buildNavItem(
            index: 1,
            icon: PhosphorIconsBold.compass,
            isSelected: false,
            onTap: () => Get.toNamed(Routes.STUDENT_MY_LEARNING),
          ),
          _buildNavItem(
            index: 2,
            icon: PhosphorIconsBold.medal,
            isSelected: true,
            onTap: () {},
          ),
          _buildNavItem(
            index: 3,
            icon: PhosphorIconsBold.userCircle,
            isSelected: false,
            onTap: () {
              if (Get.isRegistered<IndividualHomeController>()) {
                Get.find<IndividualHomeController>().currentNavIndex.value = 3;
                Get.back();
              } else {
                Get.toNamed(Routes.STUDENT_PROFILE);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(53),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: const Color(0xFF0E3856),
              ),
              const SizedBox(height: 4),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1.0 : 0.0,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF4CACD9),
                        Color(0xFF2175AE),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
