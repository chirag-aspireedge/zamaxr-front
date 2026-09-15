import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'student_quiz_summary_controller.dart';

class StudentQuizSummaryView extends GetView<StudentQuizSummaryController> {
  const StudentQuizSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: _buildTopBar(),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    // Celebration Trophy Image Avatar
                    _buildTrophyAvatar(),
                    const SizedBox(height: 18),

                    // Headings
                    const Text(
                      'Quiz Completed!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Here's how you performed.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                        color: Color(0xFF414754),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Score Visualization Card
                    _buildScoreVisualizationCard(),
                    const SizedBox(height: 26),

                    // Answer Summary Section
                    _buildAnswerSummarySection(),
                    const SizedBox(height: 20),

                    // Quiz Status Details Card
                    _buildQuizStatusCard(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Action Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: _buildContinueButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: controller.onBackTap,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Color(0xFFF3F4F5),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(
              PhosphorIcons.arrowLeft(PhosphorIconsStyle.bold),
              size: 20,
              color: const Color(0xFF191C1D),
            ),
          ),
        ),
        const Text(
          'Quiz Summary',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: Color(0xFF191C1D),
          ),
        ),
        const SizedBox(width: 40), // Balance left button
      ],
    );
  }

  Widget _buildTrophyAvatar() {
    return Container(
      width: 128,
      height: 128,
      decoration: const BoxDecoration(
        color: Color(0xFFF3F4F5),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          AppAssets.studentQuizTrophy,
          width: 128,
          height: 128,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.memory(
              base64Decode(_trophyBase64),
              width: 128,
              height: 128,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }


  Widget _buildScoreVisualizationCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(0, 89, 187, 0.06),
            Color.fromRGBO(0, 89, 187, 0.0),
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 31, 63, 0.07),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Your Score',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.14,
              color: Color(0xFF414754),
            ),
          ),
          const SizedBox(height: 20),

          // Circular Progress Gauge
          Obx(() {
            final score = controller.score.value;
            final total = controller.totalQuestions.value;
            final ratio = controller.progressRatio;
            final percentage = controller.percentage;

            return Column(
              children: [
                SizedBox(
                  width: 160,
                  height: 160,
                  child: CustomPaint(
                    painter: _CircularScorePainter(
                      progress: ratio,
                      trackColor: const Color(0xFFEDEEEF),
                      progressColor: const Color(0xFF127FD2),
                      strokeWidth: 12.8,
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '$score',
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 46,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.96,
                              color: Color(0xFF127FD2),
                            ),
                          ),
                          Text(
                            '/$total',
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.96,
                              color: Color(0xFF414754),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                // Percentage Badge Pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: BoxDecoration(
                    color: const Color(0xFF127FD2),
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(18, 127, 210, 0.3),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '$percentage%',
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.14,
                      color: Color(0xFFFEFCFF),
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildAnswerSummarySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Answer Summary',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.14,
            color: Color(0xFF191C1D),
          ),
        ),
        const SizedBox(height: 12),
        Obx(() {
          final correct = controller.correctCount.value;
          final wrong = controller.wrongCount.value;
          final unanswered = controller.unansweredCount.value;

          return Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  count: '$correct',
                  label: 'Correct',
                  borderColor: const Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricCard(
                  count: '$wrong',
                  label: 'Wrong',
                  borderColor: const Color(0xFFBA1A1A),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricCard(
                  count: '$unanswered',
                  label: 'Unanswered',
                  borderColor: const Color(0xFF717786),
                ),
              ),
            ],
          );
        }),
      ],
    );
  }

  Widget _buildMetricCard({
    required String count,
    required String label,
    required Color borderColor,
  }) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: borderColor, width: 4),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191C1D),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF414754),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F6FF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Color(0xFF0059BB),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.check,
              size: 14,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 10),
          Obx(
            () => Text(
              'Status: ${controller.status.value}',
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.14,
                color: Color(0xFF191C1D),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF56B9E3),
              Color(0xFF0E5E9B),
            ],
          ),
          borderRadius: BorderRadius.circular(9999),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(14, 94, 155, 0.28),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: controller.onContinueLearning,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9999),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Continue Learning',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                PhosphorIcons.arrowRight(PhosphorIconsStyle.bold),
                size: 18,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CircularScorePainter extends CustomPainter {
  final double progress;
  final Color trackColor;
  final Color progressColor;
  final double strokeWidth;

  const _CircularScorePainter({
    required this.progress,
    required this.trackColor,
    required this.progressColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background track circle
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, radius, trackPaint);

    // Foreground progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * math.pi * progress.clamp(0.0, 1.0);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2, // Start at 12 o'clock
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularScorePainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

const String _trophyBase64 =
    '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';

