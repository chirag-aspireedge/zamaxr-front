import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'child_detail_controller.dart';

class ChildDetailView extends GetView<ChildDetailController> {
  const ChildDetailView({super.key});

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
              _buildTopBar(context),
              _buildProfileHeader(context),
              const SizedBox(height: 16),
              _buildStatCardsRow(context),
              const SizedBox(height: 28),
              _buildLessonProgressSection(context),
              const SizedBox(height: 28),
              _buildQuizResultsSection(context),
              const SizedBox(height: 28),
              _buildRecentActivitySection(context),
              const SizedBox(height: 28),
              _buildRewardHighlightCard(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: controller.onBack,
            icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF191C1D)),
            tooltip: 'Back',
          ),
          const Text(
            'Child Detail',
            style: TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191C1D),
            ),
          ),
          const SizedBox(width: 48), // Balance for back button
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0x0D0059BB), // rgba(0, 89, 187, 0.05)
              Color(0x000059BB), // transparent
            ],
          ),
          border: Border.all(color: const Color(0xFFEDEEEF)),
        ),
        child: Obx(() {
          final child = controller.child.value;
          return Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFFE8EEF5),
                  border: Border.all(color: const Color(0xFFF8F9FA), width: 4),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                  child: ClipOval(
                    child: child.avatar.isNotEmpty
                        ? Image.network(
                            child.avatar,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, err, stack) => _buildAvatarFallback(child.name),
                          )
                        : _buildAvatarFallback(child.name),
                  ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      child.name,
                      style: const TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      child.gradeAndSchool,
                      style: const TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF414754),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildAvatarFallback(String name) {
    final initials = name.trim().isNotEmpty
        ? name.trim().split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join()
        : 'C';
    return Container(
      color: const Color(0xFF127FD2),
      alignment: Alignment.center,
      child: Text(
        initials.toUpperCase(),
        style: const TextStyle(
          fontFamily: 'Google Sans Flex',
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildStatCardsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildMetricCard(
              icon: Icons.menu_book_rounded,
              valueWidget: Obx(() => Text(
                    controller.lessonsMetric.value,
                    style: const TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191C1D),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              label: 'Lessons',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildMetricCard(
              icon: Icons.verified_rounded,
              valueWidget: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        controller.quizAvgMetric.value,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                      Text(
                        controller.quizAvgMax.value,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF414754),
                        ),
                      ),
                    ],
                  )),
              label: 'Quiz Avg',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _buildMetricCard(
              icon: Icons.stars_rounded,
              valueWidget: Obx(() => Text(
                    controller.creditsMetric.value,
                    style: const TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191C1D),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
              label: 'Credits',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Widget valueWidget,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE0F6FF),
            Color(0xFFFFFFFF),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
        border: Border.all(color: const Color(0xFFEDEEEF)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: const Color(0xFF127FD2), size: 22),
          const SizedBox(height: 8),
          valueWidget,
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF414754),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLessonProgressSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lesson Progress',
            style: TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191C1D),
            ),
          ),
          const SizedBox(height: 14),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.subjects.length,
            separatorBuilder: (context, i) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final subject = controller.subjects[index];
              return _buildSubjectProgressCard(subject);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectProgressCard(ChildSubjectProgressModel subject) {
    return InkWell(
      onTap: () => controller.onSubjectTap(subject),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: subject.iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    subject.icon,
                    size: 18,
                    color: subject.iconColor,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    subject.subject,
                    style: const TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                ),
                Text(
                  subject.progressLabel,
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF414754),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(9999),
              child: Container(
                height: 8,
                width: double.infinity,
                color: const Color(0xFFFFFFFF),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: subject.progressPercent.clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: subject.progressColor,
                      borderRadius: BorderRadius.circular(9999),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizResultsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Quiz Results',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191C1D),
                ),
              ),
              Text(
                'RESULTS',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: Color(0xFF414754),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.quizResults.length,
            separatorBuilder: (context, i) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final quiz = controller.quizResults[index];
              return _buildQuizResultItem(quiz);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuizResultItem(ChildQuizResultModel quiz) {
    return InkWell(
      onTap: () => controller.onQuizResultTap(quiz),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F8F8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A000000),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    quiz.quizTitle,
                    style: const TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF191C1D),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    quiz.dateSubtitle,
                    style: const TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF414754),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFD0E7EA),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                quiz.scoreText,
                style: const TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF091F21),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivitySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191C1D),
                ),
              ),
              Text(
                'ACTIVITY',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: Color(0xFF414754),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildActivityTimeline(),
        ],
      ),
    );
  }

  Widget _buildActivityTimeline() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.activities.length,
      itemBuilder: (context, index) {
        final activity = controller.activities[index];
        final isLast = index == controller.activities.length - 1;
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: activity.iconBgColor,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0xFFEDEEEF),
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                    child: Icon(
                      activity.icon,
                      color: activity.iconColor,
                      size: 16,
                    ),
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        width: 1.5,
                        color: const Color(0xFFE1E3E4),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activity.title,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        activity.timeSubtitle,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF414754),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRewardHighlightCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF52B4DF),
              Color(0xFF11629E),
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x2411629E),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'TOTAL REWARDS',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: Color(0xFFFEFCFF),
                  ),
                ),
                const SizedBox(height: 4),
                Obx(() => Text(
                      controller.totalRewardsValue.value,
                      style: const TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.8,
                        color: Color(0xFFFEFCFF),
                      ),
                    )),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.trending_up_rounded,
                    color: Color(0xFFFEFCFF),
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Obx(() => Text(
                        controller.rewardTrend.value,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFFEFCFF),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
