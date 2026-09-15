import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/themes/app_textstyle.dart';
import 'student_quiz_controller.dart';

class StudentQuizView extends GetView<StudentQuizController> {
  const StudentQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFC),
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              child: _buildTopBar(),
            ),
            // Progress & Timer Bar
            _buildProgressAndTimerBar(),
            // Main Quiz Content (Question + Options)
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                physics: const BouncingScrollPhysics(),
                children: [
                  // Question Card
                  _buildQuestionCard(),
                  const SizedBox(height: 24),
                  // Answer Options
                  _buildAnswerOptions(),
                ],
              ),
            ),
            // Bottom Action Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: _buildNextButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      children: [
        // Circular Back Button (Ellipse 18: 44x44, #1567A2 icon)
        GestureDetector(
          onTap: controller.onBackTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F5),
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(
              PhosphorIcons.arrowLeft(PhosphorIconsStyle.bold),
              size: 20,
              color: const Color(0xFF1567A2),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Obx(
            () => Text(
              controller.quizTitle.value,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressAndTimerBar() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8F9FA),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Obx(() {
        final progressText = controller.progressText;
        final timerText = controller.formattedTimer;
        final progress = controller.progress;

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  progressText,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.8,
                    color: Color(0xFF414754),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      PhosphorIcons.timer(PhosphorIconsStyle.bold),
                      size: 16,
                      color: const Color(0xFF0059BB),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      timerText,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF0059BB),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(9999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: const Color(0xFFE7E8E9),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF0059BB),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildQuestionCard() {
    return Obx(() {
      final question = controller.currentQuestion;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 31, 63, 0.05),
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            question.questionText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 1.5,
              color: Color(0xFF191C1D),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildAnswerOptions() {
    return Obx(() {
      final question = controller.currentQuestion;
      final selectedIndex = controller.selectedOptionIndex.value;

      return Column(
        children: List.generate(question.options.length, (index) {
          final isSelected = selectedIndex == index;
          final optionText = question.options[index];

          return _buildOptionCard(
            optionText: optionText,
            isSelected: isSelected,
            onTap: () => controller.selectOption(index),
          );
        }),
      );
    });
  }

  Widget _buildOptionCard({
    required String optionText,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1B61AE) : Colors.white,
        gradient: isSelected
            ? const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF1B61AE),
                  Color(0xFF165293),
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          isSelected
              ? const BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.1),
                  blurRadius: 6,
                  offset: Offset(0, 4),
                  spreadRadius: -1,
                )
              : const BoxShadow(
                  color: Color.fromRGBO(0, 31, 63, 0.05),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    optionText,
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                      height: 1.5,
                      color: isSelected ? const Color(0xFFFEFCFF) : const Color(0xFF191C1D),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                // Radio indicator
                if (isSelected)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      PhosphorIcons.check(PhosphorIconsStyle.bold),
                      size: 13,
                      color: const Color(0xFF127FD2),
                    ),
                  )
                else
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFC1C6D7),
                        width: 2,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
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
          borderRadius: BorderRadius.circular(74),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(14, 94, 155, 0.28),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: controller.nextQuestion,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(74),
            ),
          ),
          child: Obx(() {
            final isLast = controller.isLastQuestion;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLast ? 'Finish Quiz' : 'Next Question',
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isLast
                      ? PhosphorIcons.checkCircle(PhosphorIconsStyle.bold)
                      : PhosphorIcons.arrowRight(PhosphorIconsStyle.bold),
                  size: 16,
                  color: Colors.white,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
