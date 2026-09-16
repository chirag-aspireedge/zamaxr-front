import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import 'parent_create_quiz_controller.dart';

class ParentCreateQuizView extends GetView<ParentCreateQuizController> {
  const ParentCreateQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ParentCreateQuizController>()) {
      Get.put(ParentCreateQuizController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            _buildTopBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    // Heading: "How would you like to create your quiz?"
                    _buildHeading(),
                    const SizedBox(height: 20),

                    // Two Mode Selection Cards (Manual vs AI)
                    _buildModeSelectionCards(),
                    const SizedBox(height: 32),

                    // Section Title Row (e.g. "Manual Creation" + "0 Questions" badge)
                    _buildSectionTitleRow(),
                    const SizedBox(height: 28),

                    // Central Builder / Questions Area
                    _buildQuestionBuilderArea(),
                    const SizedBox(height: 36),

                    // Assessment Settings Section
                    _buildAssessmentSettingsSection(),
                    const SizedBox(height: 36),

                    // Bottom Save Draft Button
                    _buildSaveDraftButton(),
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
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: controller.onBack,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF191C1D),
                  size: 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Create Quiz',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191C1D),
            ),
          ),
        ],
      ),
    );
  }

  // Heading
  Widget _buildHeading() {
    return const Text(
      'How would you like to\ncreate your quiz?',
      style: TextStyle(
        fontFamily: AppTextStyle.fontFamily,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Color(0xFF191C1D),
        height: 32 / 24,
      ),
    );
  }

  // Two Mode Selection Cards (Manual vs AI)
  Widget _buildModeSelectionCards() {
    return Obx(() {
      final isManual = controller.selectedMode.value == QuizCreationMode.manual;
      final isAi = controller.selectedMode.value == QuizCreationMode.ai;

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card 1: Manual Option
          Expanded(
            child: GestureDetector(
              onTap: controller.onManualQuizSelected,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                constraints: const BoxConstraints(minHeight: 154),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isManual ? const Color(0xFF56B9E3) : const Color(0xFFC1C6D7),
                    width: isManual ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isManual
                          ? const Color(0xFF0059BB).withValues(alpha: 0.10)
                          : const Color(0xFF001F3F).withValues(alpha: 0.05),
                      offset: const Offset(0, 4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.edit_note_rounded,
                          color: Color(0xFF127FD2),
                          size: 24,
                        ),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: isManual ? const Color(0xFF127FD2) : const Color(0xFFC1C6D7),
                              width: isManual ? 4 : 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Manual Creation',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF191C1D),
                        letterSpacing: 0.14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Create and edit questions yourself',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF414754),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Card 2: AI Option
          Expanded(
            child: GestureDetector(
              onTap: controller.onAiQuizSelected,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                constraints: const BoxConstraints(minHeight: 154),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isAi ? const Color(0xFF56B9E3) : const Color(0xFFC1C6D7),
                    width: isAi ? 2 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isAi
                          ? const Color(0xFF0059BB).withValues(alpha: 0.10)
                          : const Color(0xFF001F3F).withValues(alpha: 0.05),
                      offset: const Offset(0, 4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          Icons.auto_awesome,
                          color: isAi ? const Color(0xFF127FD2) : const Color(0xFF476083),
                          size: 22,
                        ),
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: isAi ? const Color(0xFF127FD2) : const Color(0xFFC1C6D7),
                              width: isAi ? 4 : 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Create with AI',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF191C1D),
                        letterSpacing: 0.14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Let AI generate quiz questions for you',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF414754),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  // Section Title Row
  Widget _buildSectionTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Obx(
          () => Text(
            controller.selectedMode.value == QuizCreationMode.manual
                ? 'Manual Creation'
                : 'AI Generation',
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191C1D),
            ),
          ),
        ),
        Obx(
          () => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFEDEEEF),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              '${controller.questions.length} ${controller.questions.length == 1 ? "Question" : "Questions"}',
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF414754),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Central Builder / Questions Area
  Widget _buildQuestionBuilderArea() {
    return Obx(() {
      final isAi = controller.selectedMode.value == QuizCreationMode.ai;

      if (isAi && controller.questions.isEmpty) {
        return _buildAiEmptyState();
      }

      if (controller.questions.isEmpty) {
        return _buildManualEmptyState();
      }

      return Column(
        children: [
          ...controller.questions.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return _buildQuestionCard(index, item);
          }),
          const SizedBox(height: 16),
          _buildAddQuestionOutlineButton(),
        ],
      );
    });
  }

  // Manual Empty State
  Widget _buildManualEmptyState() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F9),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.post_add_rounded,
                size: 28,
                color: Color(0xFF414754),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Start Building',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(
              width: 250,
              child: Text(
                'Add your first question manually to begin creating this assessment.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF414754),
                ),
              ),
            ),
            const SizedBox(height: 28),
            _buildAddQuestionOutlineButton(),
          ],
        ),
      ),
    );
  }

  // AI Empty State
  Widget _buildAiEmptyState() {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.auto_awesome,
              color: Color(0xFF127FD2),
              size: 32,
            ),
            const SizedBox(height: 16),
            const Text(
              'Generate with AI',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 8),
            const SizedBox(
              width: 280,
              child: Text(
                'Let AI generate questions based on curriculum automatically.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF414754),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Obx(() {
              if (controller.isGeneratingAi.value) {
                return const CircularProgressIndicator(color: Color(0xFF127FD2));
              }
              return GestureDetector(
                onTap: controller.onGenerateWithAi,
                child: Container(
                  height: 46,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F6FF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFF127FD2), width: 1),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.auto_awesome, color: Color(0xFF127FD2), size: 16),
                      SizedBox(width: 8),
                      Text(
                        'GENERATE QUESTIONS',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF127FD2),
                          letterSpacing: 0.14,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  // Add Question Button
  Widget _buildAddQuestionOutlineButton() {
    return Center(
      child: GestureDetector(
        onTap: controller.onAddQuestion,
        child: Container(
          width: 242,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF717786), width: 1),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                color: Color(0xFF476083),
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'ADD QUESTION',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF476083),
                  letterSpacing: 0.14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Individual Question Card
  Widget _buildQuestionCard(int index, QuizQuestionItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${index + 1}',
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF127FD2),
                ),
              ),
              GestureDetector(
                onTap: () => controller.onRemoveQuestion(index),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Color(0xFFBA1A1A),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.question,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF191C1D),
            ),
          ),
          const SizedBox(height: 10),
          ...item.options.asMap().entries.map((opt) {
            final isCorrect = opt.key == item.correctAnswerIndex;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: isCorrect ? const Color(0xFF127FD2) : const Color(0xFF717786),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      opt.value,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 13,
                        color: isCorrect ? const Color(0xFF127FD2) : const Color(0xFF414754),
                        fontWeight: isCorrect ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  // Assessment Settings Section
  Widget _buildAssessmentSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'ASSESSMENT SETTINGS',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
                letterSpacing: 0.7,
              ),
            ),
            GestureDetector(
              onTap: controller.onEditSettings,
              child: const Icon(
                Icons.edit_outlined,
                color: Color(0xFF414754),
                size: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Row 1: Duration
        GestureDetector(
          onTap: controller.onSelectDuration,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.timer_outlined,
                  color: Color(0xFF414754),
                  size: 20,
                ),
                const SizedBox(width: 16),
                Obx(
                  () => Text(
                    controller.duration.value,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Row 2: Assigned child
        GestureDetector(
          onTap: controller.onSelectRoster,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.face_rounded,
                  color: Color(0xFF414754),
                  size: 20,
                ),
                const SizedBox(width: 16),
                Obx(
                  () => Text(
                    controller.roster.value,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Row 3: 3D Models Linked
        GestureDetector(
          onTap: controller.onSelect3DModel,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                const Icon(
                  Icons.view_in_ar_outlined,
                  color: Color(0xFF414754),
                  size: 20,
                ),
                const SizedBox(width: 16),
                Obx(
                  () => Text(
                    controller.linked3DModels.value,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF476083),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Bottom Save Draft Button
  Widget _buildSaveDraftButton() {
    return GestureDetector(
      onTap: controller.onSaveDraft,
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
            'Save Draft',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
