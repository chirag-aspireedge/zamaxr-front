import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';

class EarnRewardItem {
  final String title;
  final String points;
  final IconData icon;
  final VoidCallback? onTap;

  const EarnRewardItem({
    required this.title,
    required this.points,
    required this.icon,
    this.onTap,
  });
}

class AchievementItem {
  final String title;
  final bool isUnlocked;
  final IconData icon;
  final String description;

  const AchievementItem({
    required this.title,
    required this.isUnlocked,
    required this.icon,
    required this.description,
  });
}

class RewardCatalogItem {
  final String title;
  final String subtitle;
  final String assetPath;
  final int costCredits;

  const RewardCatalogItem({
    required this.title,
    required this.subtitle,
    required this.assetPath,
    required this.costCredits,
  });
}

class RewardActivityItem {
  final String title;
  final String points;
  final String timeAgo;
  final IconData icon;

  const RewardActivityItem({
    required this.title,
    required this.points,
    required this.timeAgo,
    required this.icon,
  });
}

class StudentRewardsController extends GetxController {
  final RxInt rewardBalance = 120.obs;
  final RxBool isSynced = true.obs;
  final RxString ranking = '#7 Today'.obs;

  // Countdown timer for 1 Day Premium Access
  late Timer _countdownTimer;
  final Rx<Duration> premiumDuration =
      const Duration(hours: 14, minutes: 22, seconds: 5).obs;

  String get formattedCountdown {
    final d = premiumDuration.value;
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  // Earn More Rewards List
  late final List<EarnRewardItem> earnMoreRewards = [
    EarnRewardItem(
      title: 'Complete a Quiz',
      points: '+10 pts',
      icon: PhosphorIcons.question(PhosphorIconsStyle.bold),
      onTap: () => Get.toNamed(Routes.STUDENT_QUIZ),
    ),
    EarnRewardItem(
      title: 'Keep Your Streak',
      points: '+25 pts',
      icon: PhosphorIcons.fire(PhosphorIconsStyle.bold),
      onTap: () {
        if (Get.context != null) {
          Get.snackbar(
            'Streak Maintained! 🔥',
            'You are on a 5-day streak. Earn +25 pts on your next streak milestone!',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
        }
      },
    ),
    EarnRewardItem(
      title: 'Complete Activities',
      points: '+50 pts',
      icon: PhosphorIcons.graduationCap(PhosphorIconsStyle.bold),
      onTap: () => Get.toNamed(Routes.STUDENT_AR_LEARNING),
    ),
  ];

  // Achievements List
  final List<AchievementItem> achievements = [
    AchievementItem(
      title: 'Weekly Star',
      isUnlocked: true,
      icon: PhosphorIcons.star(PhosphorIconsStyle.fill),
      description: 'Completed at least 3 lessons and 1 quiz in a single week.',
    ),
    AchievementItem(
      title: 'Monthly Elite',
      isUnlocked: true,
      icon: PhosphorIcons.medal(PhosphorIconsStyle.fill),
      description: 'Scored in the top 10% of class performance this month.',
    ),
    AchievementItem(
      title: 'Monthly Champ',
      isUnlocked: false,
      icon: PhosphorIcons.trophy(PhosphorIconsStyle.bold),
      description: 'Finish #1 on the leaderboard at the end of the calendar month.',
    ),
    AchievementItem(
      title: 'Quarter Master',
      isUnlocked: false,
      icon: PhosphorIcons.shieldCheck(PhosphorIconsStyle.bold),
      description: 'Complete 100% of the curriculum requirements in a quarter.',
    ),
  ];

  // Use Your Rewards Catalog
  final List<RewardCatalogItem> rewardsCatalog = const [
    RewardCatalogItem(
      title: 'AR/VR Experiences',
      subtitle: 'Unlock modules',
      assetPath: AppAssets.studentRewardArVr,
      costCredits: 80,
    ),
    RewardCatalogItem(
      title: 'Extra AI Uses',
      subtitle: 'Expand limits',
      assetPath: AppAssets.studentRewardAiUses,
      costCredits: 40,
    ),
    RewardCatalogItem(
      title: 'Certificates',
      subtitle: 'Claim credentials',
      assetPath: AppAssets.studentRewardCertificates,
      costCredits: 100,
    ),
  ];

  // Recent Activity Timeline
  final List<RewardActivityItem> recentActivity = [
    RewardActivityItem(
      title: 'Biology Quiz Completed',
      points: '+10 pts',
      timeAgo: 'Today',
      icon: PhosphorIcons.flask(PhosphorIconsStyle.bold),
    ),
    RewardActivityItem(
      title: 'Daily Top 10',
      points: '+50 pts',
      timeAgo: 'Yesterday',
      icon: PhosphorIcons.trendUp(PhosphorIconsStyle.bold),
    ),
    RewardActivityItem(
      title: 'Weekly Top 20',
      points: '+150 pts',
      timeAgo: 'Aug 28',
      icon: PhosphorIcons.star(PhosphorIconsStyle.fill),
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    _startCountdownTimer();
  }

  void _startCountdownTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (premiumDuration.value.inSeconds > 0) {
        premiumDuration.value =
            premiumDuration.value - const Duration(seconds: 1);
      } else {
        timer.cancel();
      }
    });
  }

  void onSyncTap() {
    isSynced.value = false;
    Future.delayed(const Duration(milliseconds: 600), () {
      isSynced.value = true;
      if (Get.context != null) {
        Get.snackbar(
          'Rewards Synced',
          'Your credits and achievements are up to date.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    });
  }

  void onWalletTap() {
    if (Get.context != null) {
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
                  const Text(
                    'Zama Rewards Pass',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Available Credits: ${rewardBalance.value}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1466A1),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Earn credits by exploring 3D models, asking questions to the AI Tutor, completing quizzes, and achieving top rankings.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF414754),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF127FD2),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  void onAchievementTap(AchievementItem item) {
    if (Get.context != null) {
      Get.bottomSheet(
        Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.isUnlocked
                      ? const Color(0xFF127FD2)
                      : const Color(0xFFE1E3E4),
                ),
                alignment: Alignment.center,
                child: Icon(
                  item.icon,
                  size: 32,
                  color: item.isUnlocked
                      ? Colors.white
                      : const Color(0xFF414754),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: item.isUnlocked
                      ? const Color(0xFFE0F6FF)
                      : const Color(0xFFEDEEEF),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  item.isUnlocked ? 'Unlocked' : 'Locked',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: item.isUnlocked
                        ? const Color(0xFF127FD2)
                        : const Color(0xFF414754),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                item.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF414754),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    }
  }

  void onRedeemReward(RewardCatalogItem item) {
    if (rewardBalance.value >= item.costCredits) {
      rewardBalance.value -= item.costCredits;
      if (Get.context != null) {
        Get.snackbar(
          'Unlocked Successfully!',
          'You redeemed ${item.title} for ${item.costCredits} credits.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFFE0F6FF),
          colorText: const Color(0xFF0059BB),
          duration: const Duration(seconds: 3),
        );
      }
    } else {
      if (Get.context != null) {
        Get.snackbar(
          'Not Enough Credits',
          'You need ${item.costCredits} credits for ${item.title}. Keep learning to earn more!',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  @override
  void onClose() {
    _countdownTimer.cancel();
    super.onClose();
  }
}
