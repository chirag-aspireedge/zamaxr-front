import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import 'quiz_controller.dart';
import 'quiz_model.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<QuizController>()) {
      Get.put(QuizController());
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            _buildTopAppBar(context),

            // Scrollable Content Body
            Expanded(
              child: Obx(() {
                final data = controller.quizData.value;
                if (data == null) {
                  return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF127FD2)),
                  );
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),

                      // Section A: Quiz Metadata & Form
                      _buildQuizMetadataSection(data),
                      const SizedBox(height: 24),

                      // Section B: Questions Header & List
                      _buildQuestionsSection(data),
                      const SizedBox(height: 20),

                      // Section C: Add Question Action Button
                      _buildAddQuestionButton(),
                      const SizedBox(height: 20),

                      // Section D: Save Quiz Primary Action Button
                      _buildSaveQuizButton(),
                      const SizedBox(height: 32),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top App Bar: "Created Quiz" Title, "Cell Structure" & 3-Dots Action Button
  // ---------------------------------------------------------------------------
  Widget _buildTopAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left: Title & Subtitle ("Created Quiz" & "Cell Structure")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Created Quiz',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF131313),
                  letterSpacing: -0.3,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'Cell Structure',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF335E7D),
                ),
              ),
            ],
          ),

          // Right: 3-Dots Action Button (40x40 circle, #E0F6FF)
          GestureDetector(
            onTap: controller.onMoreOptions,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE0F6FF),
                boxShadow: [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.more_vert_rounded,
                  size: 20,
                  color: Color(0xFF127FD2),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section A: Quiz Metadata & Editable Form Card
  // ---------------------------------------------------------------------------
  Widget _buildQuizMetadataSection(QuizModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Tag Header: "CELL STRUCTURE QUIZ"
        Text(
          data.tag,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFF127FD2),
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 4),

        // Subtitle: "Biology Fundamentals • Chapter 1"
        Text(
          data.categorySubtitle,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF335E7D),
          ),
        ),
        const SizedBox(height: 16),

        // Form Field 1: Quiz Title
        _buildFormField(
          label: 'Quiz Title',
          controller: controller.titleController,
          hintText: 'Enter quiz title',
        ),
        const SizedBox(height: 16),

        // Form Field 2: Description (Multiline textarea)
        _buildFormField(
          label: 'Description',
          controller: controller.descriptionController,
          hintText: 'Enter quiz description',
          isMultiline: true,
        ),
        const SizedBox(height: 16),

        // Form Field 3: Passing Criteria (%)
        _buildFormField(
          label: 'Passing Criteria (%)',
          controller: controller.passingCriteriaController,
          hintText: '70',
          keyboardType: TextInputType.number,
          backgroundColor: const Color(0xFFEDEEEF),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Form Field Builder Helper
  // ---------------------------------------------------------------------------
  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    bool isMultiline = false,
    TextInputType keyboardType = TextInputType.text,
    Color backgroundColor = const Color(0xFFF4F4F4),
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF191C1D),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: isMultiline ? 96 : 48,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: isMultiline ? 4 : 1,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF191C1D),
            ),
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 14,
                color: Color(0xFF8E9192),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section B: Questions Section (Header + Cards List)
  // ---------------------------------------------------------------------------
  Widget _buildQuestionsSection(QuizModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Questions Count & Total Points Header Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${data.totalQuestions} Questions',
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F4F8),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'Total: ${data.totalPoints} pts',
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF476083),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Questions List
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: data.questions.length,
          separatorBuilder: (context, index) => const SizedBox(height: 14),
          itemBuilder: (context, index) {
            final question = data.questions[index];
            return _buildQuestionCard(question);
          },
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Single Question Card (Exact matching Figma: No card border, clean shadow)
  // ---------------------------------------------------------------------------
  Widget _buildQuestionCard(QuizQuestion question) {
    final isFirst = question.numberString == '01';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Color(0x05000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header: Badge Number, Question Type Pill & Action Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  // Number badge (01 in blue #127FD2, others in neutral)
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isFirst
                          ? const Color(0xFF127FD2)
                          : const Color(0xFFEDEEEF),
                    ),
                    child: Center(
                      child: Text(
                        question.numberString,
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isFirst ? Colors.white : const Color(0xFF414754),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Question Type Pill (#E0F6FF background, #191C1D text)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: isFirst
                          ? const Color(0xFFE0F6FF)
                          : const Color(0xFFF4F4F4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      question.questionTypeLabel,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: isFirst
                            ? const Color(0xFF191C1D)
                            : const Color(0xFF476083),
                      ),
                    ),
                  ),
                ],
              ),

              // Action Icons: Edit & Delete (Dark Grey #414754)
              Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.onEditQuestion(question),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Remix.pencil_line,
                        size: 16,
                        color: Color(0xFF414754),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => controller.onDeleteQuestion(question.id),
                    child: const Padding(
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Remix.delete_bin_line,
                        size: 16,
                        color: Color(0xFF414754),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Question Prompt Text (15px, FontWeight.w600, #191C1D)
          Text(
            question.questionText,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191C1D),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 14),

          // Options List
          Column(
            children: question.options.map((option) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildOptionItem(question.id, option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Single Option Item Builder (Exact matching Figma Radio Buttons)
  // ---------------------------------------------------------------------------
  Widget _buildOptionItem(String questionId, QuizOption option) {
    final isSelected = option.isSelected;

    return GestureDetector(
      onTap: () => controller.onSelectOption(questionId, option.id),
      child: Container(
        height: isSelected ? 42 : 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE0F6FF) : const Color(0xFFEDEEEF),
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(
                  color: const Color(0xFF127FD2),
                  width: 1,
                )
              : null,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Exact Figma Radio Indicator (Dot inside ring for checked, empty ring for unchecked)
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF0059BB)
                      : const Color(0xFF414754),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF0059BB),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 10),

            // Option text
            Expanded(
              child: Text(
                option.text,
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: isSelected
                      ? const Color(0xFF191C1D)
                      : const Color(0xFF414754),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Action Button: Add Question
  // ---------------------------------------------------------------------------
  Widget _buildAddQuestionButton() {
    return GestureDetector(
      onTap: controller.onAddQuestion,
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFE0F6FF),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF127FD2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Remix.add_line,
              size: 16,
              color: Color(0xFF127FD2),
            ),
            SizedBox(width: 8),
            Text(
              'ADD QUESTION',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF127FD2),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Action Button: Save Quiz
  // ---------------------------------------------------------------------------
  Widget _buildSaveQuizButton() {
    return GestureDetector(
      onTap: controller.onSaveQuiz,
      child: Container(
        height: 48,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFF56B9E3),
              Color(0xFF0E5E9B),
            ],
          ),
          borderRadius: BorderRadius.circular(52),
          boxShadow: const [
            BoxShadow(
              color: Color(0x4D127FD2),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'SAVE QUIZ',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }
}
