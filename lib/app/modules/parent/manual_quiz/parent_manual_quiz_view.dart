import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import 'parent_manual_quiz_controller.dart';

class ParentManualQuizView extends GetView<ParentManualQuizController> {
  const ParentManualQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ParentManualQuizController>()) {
      Get.put(ParentManualQuizController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation & Actions Bar
            _buildTopNavBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Header: "Create Quiz" & "Cell Structure" + More Options
                    _buildHeaderRow(),
                    const SizedBox(height: 28),

                    // Category Banner: "CELL STRUCTURE QUIZ" & "Science Fundamentals"
                    _buildCategoryHeader(),
                    const SizedBox(height: 24),

                    // Input: Quiz Title
                    _buildInputLabel('Quiz Title'),
                    const SizedBox(height: 8),
                    _buildInputField(
                      controller: controller.titleController,
                      hint: 'Enter quiz title',
                    ),
                    const SizedBox(height: 20),

                    // Input: Description
                    _buildInputLabel('Description'),
                    const SizedBox(height: 8),
                    _buildInputField(
                      controller: controller.descriptionController,
                      hint: 'Enter quiz description',
                      maxLines: 2,
                    ),
                    const SizedBox(height: 20),

                    // Input: Passing Criteria (%)
                    _buildInputLabel('Passing Criteria (%)'),
                    const SizedBox(height: 8),
                    _buildInputField(
                      controller: controller.passingCriteriaController,
                      hint: 'e.g. 70',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 28),

                    // Section: "X Questions" & "Total: X pts"
                    _buildQuestionsHeaderRow(),
                    const SizedBox(height: 16),

                    // Question Cards List
                    _buildQuestionsList(),
                    const SizedBox(height: 16),

                    // "+ Add Question" dashed button
                    _buildAddQuestionDashedButton(),
                    const SizedBox(height: 24),

                    // "Save Quiz" bottom button
                    _buildSaveQuizButton(),
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

  // Top Navigation Bar
  Widget _buildTopNavBar() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 12.0, bottom: 4.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.onBack,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: const Color(0xFFE7E7E7), width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF1567A2),
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Header Row
  Widget _buildHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create Quiz',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
                height: 32 / 24,
              ),
            ),
            const SizedBox(height: 4),
            Obx(
              () => Text(
                controller.lessonTitle.value,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF414754),
                  height: 24 / 16,
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: controller.onMoreOptions,
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFF4F4F4),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.more_vert,
                color: Color(0xFF191C1D),
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Category Header
  Widget _buildCategoryHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () => Text(
            controller.quizCategory.value,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFF127FD2),
              letterSpacing: 0.8,
              height: 24 / 16,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Obx(
          () => Text(
            controller.quizSubheader.value,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF414754),
            ),
          ),
        ),
      ],
    );
  }

  // Input Label
  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: AppTextStyle.fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF0E3856),
      ),
    );
  }

  // Input Field Box
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      width: double.infinity,
      height: maxLines > 1 ? 78 : 50,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F6F6).withValues(alpha: 0.35),
        border: Border.all(color: const Color(0xFFE7E7E7), width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xFF191C1D),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            isDense: true,
            hintText: hint,
            hintStyle: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFF717786),
            ),
          ),
        ),
      ),
    );
  }

  // Questions Header Row
  Widget _buildQuestionsHeaderRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Text(
            '${controller.questions.length} Questions',
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191C1D),
            ),
          ),
        ),
        Obx(
          () => Text(
            'Total: ${controller.totalPoints} pts',
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF476083),
            ),
          ),
        ),
      ],
    );
  }

  // Question Cards List
  Widget _buildQuestionsList() {
    return Obx(() {
      if (controller.questions.isEmpty) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 36),
          child: const Center(
            child: Text(
              'No questions added yet. Tap "+ Add Question" below.',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 14,
                color: Color(0xFF717786),
              ),
            ),
          ),
        );
      }

      return Column(
        children: controller.questions.asMap().entries.map((entry) {
          final qIndex = entry.key;
          final q = entry.value;

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE7E7E7), width: 1),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0A000000),
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'QUESTION ${q.number}',
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                        color: Color(0xFF127FD2),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => controller.onEditQuestion(qIndex),
                          child: const Icon(Icons.edit_outlined, size: 18, color: Color(0xFF476083)),
                        ),
                        const SizedBox(width: 12),
                        GestureDetector(
                          onTap: () => controller.onDeleteQuestion(qIndex),
                          child: const Icon(Icons.delete_outline, size: 18, color: Color(0xFFBA1A1A)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  q.questionText,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF191C1D),
                  ),
                ),
                const SizedBox(height: 12),
                ...q.options.asMap().entries.map((optEntry) {
                  final optIndex = optEntry.key;
                  final optText = optEntry.value;
                  final isSelected = optIndex == q.selectedCorrectIndex;

                  return GestureDetector(
                    onTap: () => controller.onSelectOption(qIndex, optIndex),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFFE0F6FF) : const Color(0xFFEDEEEF),
                        border: Border.all(
                          color: isSelected ? const Color(0xFF127FD2) : Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          _buildOptionRadio(isSelected),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              optText,
                              style: TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 14,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                                color: isSelected ? const Color(0xFF191C1D) : const Color(0xFF414754),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            ),
          );
        }).toList(),
      );
    });
  }

  // Option Radio
  Widget _buildOptionRadio(bool isSelected) {
    if (isSelected) {
      return Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFF0059BB),
            width: 2,
          ),
        ),
        child: Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF0059BB),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 18,
      height: 18,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        border: Border.all(
          color: const Color(0xFF414754),
          width: 1.5,
        ),
      ),
    );
  }

  // "+ Add Question" dashed button
  Widget _buildAddQuestionDashedButton() {
    return GestureDetector(
      onTap: controller.onAddQuestion,
      child: CustomPaint(
        painter: _DashedBorderPainter(
          color: const Color(0xFFD7D7D7),
          strokeWidth: 1.2,
          dashPattern: const [6, 4],
          radius: 11,
        ),
        child: Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            color: Colors.transparent,
          ),
          child: const Center(
            child: Text(
              '+ Add Question',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0E3856),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // "Save Quiz" bottom button
  Widget _buildSaveQuizButton() {
    return GestureDetector(
      onTap: controller.onSaveQuiz,
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(74),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF56B9E3),
              Color(0xFF0E5E9B),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Save Quiz',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

// Dashed border painter
class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final List<double> dashPattern;
  final double radius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashPattern,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rrect);
    final dashedPath = _createDashedPath(path, dashPattern[0], dashPattern[1]);
    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source, double dashLength, double dashSpace) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0.0;
      while (distance < metric.length) {
        final length = (distance + dashLength < metric.length)
            ? dashLength
            : metric.length - distance;
        dest.addPath(metric.extractPath(distance, distance + length), Offset.zero);
        distance += dashLength + dashSpace;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
