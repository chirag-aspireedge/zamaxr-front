import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'teacher_review_quiz_controller.dart';

class TeacherReviewQuizView extends GetView<TeacherReviewQuizController> {
  const TeacherReviewQuizView({super.key});

  static const String fontFamily = 'Google Sans Flex';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable content area
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Navigation Bar
                    _buildTopBar(),
                    const SizedBox(height: 16),

                    // Title & Subtitle
                    _buildTitleAndSubtitle(),
                    const SizedBox(height: 24),

                    // Stats Row
                    _buildStatsRow(),
                    const SizedBox(height: 24),

                    // Questions List
                    _buildQuestionsList(),
                    const SizedBox(height: 20),

                    // Add Question Button
                    _buildAddQuestionButton(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // Bottom Fixed Action Area
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  // 1. Top Navigation Bar
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
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
                  offset: const Offset(0, 2),
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 18,
                color: Color(0xFF1567A2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 2. Title & Subtitle
  Widget _buildTitleAndSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Review AI Quiz',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF191C1D),
            height: 32 / 24,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Review and adjust the AI-generated questions before sharing with your students.',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF414754),
            height: 24 / 16,
          ),
        ),
      ],
    );
  }

  // 3. Stats Row
  Widget _buildStatsRow() {
    return Obx(() {
      return Row(
        children: [
          // Card 1: QUESTIONS
          Expanded(
            child: Container(
              height: 104,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEEEF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF001F3F).withValues(alpha: 0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'QUESTIONS',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF414754),
                      letterSpacing: 0.6,
                      height: 16 / 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${controller.questions.length}',
                    style: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0059BB),
                      height: 32 / 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Card 2: EST. TIME
          Expanded(
            child: Container(
              height: 104,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEDEEEF),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF001F3F).withValues(alpha: 0.05),
                    offset: const Offset(0, 4),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'EST. TIME',
                    style: TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF414754),
                      letterSpacing: 0.6,
                      height: 16 / 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    controller.estimatedTime,
                    style: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0059BB),
                      height: 32 / 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  // 4. Questions List
  Widget _buildQuestionsList() {
    return Obx(() {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.questions.length,
        separatorBuilder: (context, index) => const SizedBox(height: 24),
        itemBuilder: (context, index) {
          final q = controller.questions[index];
          return _buildQuestionCard(q, index);
        },
      );
    });
  }

  // Question Card
  Widget _buildQuestionCard(ReviewQuizQuestionItem q, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECECEC)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF001F3F).withValues(alpha: 0.05),
            offset: const Offset(0, 4),
            blurRadius: 20,
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row: Number + Time estimate | Edit + Delete
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Number badge
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: Color(0xFF127FD2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        q.number,
                        style: const TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFFEFCFF),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Time estimate pill
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDEEEF),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 14,
                          color: Color(0xFF414754),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          q.timeEstimate,
                          style: const TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF414754),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Action buttons: Edit & Delete
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.onEditQuestion(index),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FA),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.edit_outlined,
                          size: 14,
                          color: Color(0xFF414754),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => controller.onDeleteQuestion(index),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FA),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.delete_outline,
                          size: 14,
                          color: Color(0xFF414754),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Question Title Text
          Text(
            q.question,
            style: const TextStyle(
              fontFamily: fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xFF191C1D),
              height: 28 / 18,
            ),
          ),
          const SizedBox(height: 16),

          // Options List
          ...q.options.asMap().entries.map((entry) {
            final optIndex = entry.key;
            final optText = entry.value;
            final isSelected = optIndex == q.correctAnswerIndex;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: GestureDetector(
                onTap: () => controller.onSelectOption(index, optIndex),
                child: Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFD0E7EA) : const Color(0xFFF3F4F5),
                    borderRadius: BorderRadius.circular(8),
                    border: isSelected
                        ? Border.all(color: const Color(0xFF0059BB).withValues(alpha: 0.2), width: 1)
                        : null,
                  ),
                  child: Row(
                    children: [
                      // Radio / Check Indicator
                      if (isSelected)
                        Container(
                          width: 20,
                          height: 20,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0059BB),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(
                              color: const Color(0xFFC1C6D7),
                              width: 1,
                            ),
                          ),
                        ),
                      const SizedBox(width: 16),

                      // Option text
                      Expanded(
                        child: Text(
                          optText,
                          style: TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                            color: isSelected ? const Color(0xFF091F21) : const Color(0xFF191C1D),
                            height: 24 / 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 8),

          // Regenerate Question Button
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton.icon(
              onPressed: () => controller.onRegenerateQuestion(index),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF127FD2),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              icon: const Icon(
                Icons.sync,
                size: 16,
                color: Colors.white,
              ),
              label: const Text(
                'Regenerate Question',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 5. Add Question Button with Dashed Border
  Widget _buildAddQuestionButton() {
    return GestureDetector(
      onTap: controller.onAddQuestion,
      child: CustomPaint(
        painter: _DashedRectPainter(
          color: const Color(0xFFC1C6D7),
          strokeWidth: 2,
          gap: 6,
          radius: 12,
        ),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF001F3F).withValues(alpha: 0.05),
                offset: const Offset(0, 4),
                blurRadius: 20,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.add,
                size: 20,
                color: Color(0xFF127FD2),
              ),
              SizedBox(width: 12),
              Text(
                'ADD QUESTION',
                style: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.7,
                  color: Color(0xFF127FD2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 6. Bottom Fixed Action Area: Create Quiz Button
  Widget _buildBottomActionBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -4),
            blurRadius: 16,
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 54,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF56B9E3), Color(0xFF0E5E9B)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(74),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0E5E9B).withValues(alpha: 0.3),
                offset: const Offset(0, 4),
                blurRadius: 10,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: controller.onCreateQuiz,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(74),
              ),
            ),
            child: const Text(
              'Create Quiz',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Painter for dashed border
class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final double radius;

  _DashedRectPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.gap = 5.0,
    this.radius = 12.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint dashedPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    final Path dashPath = Path();

    for (final metric in path.computeMetrics()) {
      double distance = 0.0;
      bool draw = true;
      while (distance < metric.length) {
        final double len = gap;
        if (draw) {
          dashPath.addPath(
            metric.extractPath(distance, distance + len),
            Offset.zero,
          );
        }
        distance += len;
        draw = !draw;
      }
    }

    canvas.drawPath(dashPath, dashedPaint);
  }

  @override
  bool shouldRepaint(covariant _DashedRectPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.gap != gap ||
        oldDelegate.radius != radius;
  }
}

typedef ReviewQuizView = TeacherReviewQuizView;
