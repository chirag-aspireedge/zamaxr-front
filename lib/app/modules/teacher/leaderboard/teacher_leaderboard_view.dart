import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import 'teacher_leaderboard_controller.dart';
import 'teacher_leaderboard_model.dart';

class TeacherLeaderboardView extends GetView<TeacherLeaderboardController> {
  const TeacherLeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    const fontFamily = AppTextStyle.fontFamily;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header (Back Button + Title + Subtitle)
                    _buildHeader(fontFamily),

                    const SizedBox(height: 24),

                    // 2. Segmented Pill Switcher (This Week / This Month)
                    _buildTimeFilterSwitcher(fontFamily),

                    const SizedBox(height: 24),

                    // 3. Top 3 Podium (Rank 2 Left, Rank 1 Center, Rank 3 Right)
                    _buildPodiumSection(fontFamily),

                    const SizedBox(height: 24),

                    // 4. Active Students Card (Rectangle 17)
                    _buildActiveStudentsCard(fontFamily),

                    const SizedBox(height: 22),

                    // 5. Information Header
                    _buildInformationHeader(fontFamily),

                    const SizedBox(height: 12),

                    // 6. Ranked List (Ranks 4, 5, 6)
                    _buildRankedList(fontFamily),

                    const SizedBox(height: 28),

                    // 7. View All Students Button (Group 2047 / Rectangle 7)
                    _buildViewAllStudentsButton(fontFamily),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 1. Header: Back Button + Title + Subtitle
  Widget _buildHeader(String fontFamily) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Circular Back Button with Shadow
              GestureDetector(
                onTap: controller.onBack,
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: Color(0xFF1567A2),
                      size: 22,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Review AI Quiz Title (20px w600 per ARCHITECTURE.md section 10)
              Expanded(
                child: Obx(
                  () => Text(
                    controller.title.value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF131313),
                      height: 26 / 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Grade 8 – A • 32 Students (13px w400 per ARCHITECTURE.md secondary text)
          Padding(
            padding: const EdgeInsets.only(left: 58.0),
            child: Obx(
              () => Text(
                controller.subtitle.value,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF131313).withValues(alpha: 0.65),
                  height: 18 / 13,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 2. Time Filter Switcher: 48px height, #F8F9FA, This Week / This Month
  Widget _buildTimeFilterSwitcher(String fontFamily) {
    return Center(
      child: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 30.0),
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: Obx(() {
          final isWeek = controller.selectedPeriod.value == 'This Week';
          return Row(
            children: [
              // This Week (15px w500 per ARCHITECTURE.md)
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.onSelectPeriod('This Week'),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: isWeek ? const Color(0xFF127FD2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: isWeek
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'This Week',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: isWeek ? Colors.white : const Color(0xFF414754),
                        height: 20 / 15,
                      ),
                    ),
                  ),
                ),
              ),

              // This Month (15px w500 per ARCHITECTURE.md)
              Expanded(
                child: GestureDetector(
                  onTap: () => controller.onSelectPeriod('This Month'),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: !isWeek ? const Color(0xFF127FD2) : Colors.transparent,
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: !isWeek
                          ? [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'This Month',
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: !isWeek ? Colors.white : const Color(0xFF414754),
                        height: 20 / 15,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  // 3. Podium Section: Subtle Gradient + Rank 2 (Left), Rank 1 (Center Elevated), Rank 3 (Right)
  Widget _buildPodiumSection(String fontFamily) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0x33D8E2FF),
            Color(0x00D8E2FF),
          ],
        ),
      ),
      child: Obx(() {
        final rank1 = controller.rank1Student.value;
        final rank2 = controller.rank2Student.value;
        final rank3 = controller.rank3Student.value;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Rank 2 (Left): Sarah J.
            Expanded(
              child: _buildPodiumAvatar(
                student: rank2,
                avatarSize: 64,
                badgeSize: 24,
                badgeColor: const Color(0xFFF8F9FA),
                badgeTextColor: const Color(0xFF191C1D),
                isWinner: false,
                fontFamily: fontFamily,
              ),
            ),

            // Rank 1 (Center): Michael C.
            Expanded(
              child: _buildPodiumAvatar(
                student: rank1,
                avatarSize: 76,
                badgeSize: 28,
                badgeColor: const Color(0xFF127FD2),
                badgeTextColor: Colors.white,
                isWinner: true,
                fontFamily: fontFamily,
              ),
            ),

            // Rank 3 (Right): Emma P.
            Expanded(
              child: _buildPodiumAvatar(
                student: rank3,
                avatarSize: 64,
                badgeSize: 24,
                badgeColor: const Color(0xFFF8F9FA),
                badgeTextColor: const Color(0xFF191C1D),
                isWinner: false,
                fontFamily: fontFamily,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildPodiumAvatar({
    required LeaderboardStudentModel student,
    required double avatarSize,
    required double badgeSize,
    required Color badgeColor,
    required Color badgeTextColor,
    required bool isWinner,
    required String fontFamily,
  }) {
    return GestureDetector(
      onTap: () => controller.onStudentTap(student),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Avatar with Rank Badge Stack
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Rank 1 Blur Glow Background
              if (isWinner)
                Positioned(
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      width: avatarSize + 10,
                      height: avatarSize + 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0x330059BB),
                            Color(0x334B6062),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              // Outer Avatar Container with Shadow
              Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFEDEEEF),
                  boxShadow: isWinner
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 6,
                            spreadRadius: -1,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 4,
                            spreadRadius: -2,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                ),
                padding: const EdgeInsets.all(2.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: Image.asset(
                    student.avatarAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFE0F6FF),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          color: Color(0xFF1567A2),
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Overlapping Rank Badge (12px per ARCHITECTURE.md micro badge standard)
              Positioned(
                right: -4,
                bottom: -4,
                child: Container(
                  width: badgeSize,
                  height: badgeSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: badgeColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 3,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${student.rank}',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: badgeTextColor,
                      height: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Student Name: 14px w500/w600 per ARCHITECTURE.md section 10
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Text(
              student.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 14,
                fontWeight: isWinner ? FontWeight.w600 : FontWeight.w500,
                color: const Color(0xFF191C1D),
                height: 18 / 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4. Active Students Card: 354x141px, #E7E7E7 border, 7px blue accent stripe, 78% fill
  Widget _buildActiveStudentsCard(String fontFamily) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24.0),
      decoration: BoxDecoration(
        color: const Color(0x33F6F6F6),
        border: Border.all(color: const Color(0xFFE7E7E7), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            // Left blue accent stripe (width 7px, #127FD2)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 7,
                color: const Color(0xFF127FD2),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 26.0,
                right: 24.0,
                top: 14.0,
                bottom: 14.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Percentage + Active Students label & Circular Group Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 78% (18px w600)
                            Obx(
                              () => Text(
                                '${controller.participationPercentage.value}%',
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF191C1D),
                                  height: 24 / 18,
                                ),
                              ),
                            ),
                            // Active Students (13px w400 per ARCHITECTURE.md secondary text)
                            Text(
                              'Active Students',
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF414754),
                                height: 18 / 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Overlay 40x40 circle: rgba(0, 112, 234, 0.2) with group icon
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0x330070EA),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.group_outlined,
                            size: 22,
                            color: Color(0xFF127FD2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Progress Bar: 6px height, track #E7E8E9, fill 78% #127FD2
                  Obx(() {
                    final progress =
                        (controller.participationPercentage.value / 100).clamp(0.0, 1.0);
                    return Container(
                      height: 6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7E8E9),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF127FD2),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 10),

                  // 25 of 32 students participated this week (13px w400 per ARCHITECTURE.md)
                  Obx(
                    () => Text(
                      controller.participationText.value,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF414754),
                        height: 18 / 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 5. Information Section Header: 16px / 20px, #0E3856, w600
  Widget _buildInformationHeader(String fontFamily) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Information',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF0E3856),
              height: 20 / 16,
            ),
          ),
          const Icon(
            Icons.info_outline,
            size: 16,
            color: Color(0xFF414754),
          ),
        ],
      ),
    );
  }

  // 6. Ranked List (Ranks 4, 5, 6): Cards with rank, avatar, name, subtitle, score, delta
  Widget _buildRankedList(String fontFamily) {
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        itemCount: controller.rankedList.length,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          final student = controller.rankedList[index];
          return _buildRankedStudentCard(student, fontFamily);
        },
      ),
    );
  }

  Widget _buildRankedStudentCard(
    LeaderboardStudentModel student,
    String fontFamily,
  ) {
    return GestureDetector(
      onTap: () => controller.onStudentTap(student),
      child: Container(
        constraints: const BoxConstraints(minHeight: 74),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: const Color(0x33F6F6F6),
          border: Border.all(color: const Color(0xFFE7E7E7), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Rank Number: 14px w500
            SizedBox(
              width: 24,
              child: Text(
                '${student.rank}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF414754),
                  height: 20 / 14,
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Avatar: 42x42 circle with #D1D1D1 2px border
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFD1D1D1), width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9999),
                child: Image.asset(
                  student.avatarAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFFE0F6FF),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 24,
                        color: Color(0xFF1567A2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Student Name & Role Subtitle (15px w500, 13px w400 per ARCHITECTURE.md)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    student.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF191C1D),
                      height: 20 / 15,
                    ),
                  ),
                  if (student.subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      student.subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF414754),
                        height: 18 / 13,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Score & Trend Delta (15px w500, 12px w500 per ARCHITECTURE.md)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  student.score,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF191C1D),
                    height: 20 / 15,
                  ),
                ),
                const SizedBox(height: 2),
                _buildTrendIndicator(student.trend, student.delta, fontFamily),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendIndicator(
    LeaderboardTrend trend,
    String delta,
    String fontFamily,
  ) {
    switch (trend) {
      case LeaderboardTrend.up:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.arrow_drop_up,
              color: Color(0xFF4B6062),
              size: 16,
            ),
            Text(
              delta,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF4B6062),
              ),
            ),
          ],
        );
      case LeaderboardTrend.neutral:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.remove,
              color: Color(0xFF414754),
              size: 14,
            ),
            const SizedBox(width: 2),
            Text(
              delta,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF414754),
              ),
            ),
          ],
        );
      case LeaderboardTrend.down:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.arrow_drop_down,
              color: Color(0xFFBA1A1A),
              size: 16,
            ),
            Text(
              delta,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFBA1A1A),
              ),
            ),
          ],
        );
    }
  }

  // 7. View All Students Button: 318x54px, gradient 90deg (#56B9E3 to #0E5E9B), 16px w500 per ARCHITECTURE.md
  Widget _buildViewAllStudentsButton(String fontFamily) {
    return Center(
      child: GestureDetector(
        onTap: controller.onViewAllStudents,
        child: Container(
          width: 318,
          height: 54,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF56B9E3),
                Color(0xFF0E5E9B),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0E5E9B).withValues(alpha: 0.25),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(52),
          ),
          alignment: Alignment.center,
          child: Text(
            'View All Students',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 22 / 16,
            ),
          ),
        ),
      ),
    );
  }
}
