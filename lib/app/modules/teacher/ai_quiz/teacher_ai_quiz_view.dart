import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import 'teacher_ai_quiz_controller.dart';

class TeacherAiQuizView extends GetView<TeacherAiQuizController> {
  const TeacherAiQuizView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<TeacherAiQuizController>()) {
      Get.put(TeacherAiQuizController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar with circular back button
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

                    // Breadcrumb: "Biology 101 > New Quiz"
                    _buildBreadcrumb(),
                    const SizedBox(height: 12),

                    // Heading: "AI Quiz Generator"
                    const Text(
                      'AI Quiz Generator',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF191C1D),
                        height: 32 / 24,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Section 1: SOURCE TOPIC
                    _buildSectionHeader(title: 'SOURCE TOPIC', textColor: const Color(0xFF414754)),
                    const SizedBox(height: 8),
                    _buildSourceTopicField(),
                    const SizedBox(height: 24),

                    // Section 2: AI INSTRUCTIONS
                    _buildAiInstructionsHeader(),
                    const SizedBox(height: 8),
                    _buildAiInstructionsTextarea(),
                    const SizedBox(height: 12),

                    // Suggestion Chips (horizontal scroll)
                    _buildSuggestionChips(),
                    const SizedBox(height: 28),

                    // Section 3: Number of Questions
                    _buildIconLabelRow(
                      icon: Icons.format_list_numbered_rounded,
                      label: 'Number of Questions',
                    ),
                    const SizedBox(height: 12),
                    _buildQuestionCountSelector(),
                    const SizedBox(height: 28),

                    // Section 4: Question Type
                    _buildIconLabelRow(
                      icon: Icons.quiz_outlined,
                      label: 'Question Type',
                    ),
                    const SizedBox(height: 12),
                    _buildQuestionTypeSelector(),
                    const SizedBox(height: 28),

                    // Section 5: Difficulty & Time / Q (2 Columns)
                    _buildDifficultyAndTimeRow(context),
                    const SizedBox(height: 28),

                    // Section 6: XR READY Banner
                    _buildXrReadyBanner(),
                    const SizedBox(height: 32),

                    // Section 7: Next Button
                    _buildNextButton(),
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

  // ---------------------------------------------------------------------------
  // Top Navigation Bar
  // ---------------------------------------------------------------------------
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

  // ---------------------------------------------------------------------------
  // Breadcrumb: "Biology 101 > New Quiz"
  // ---------------------------------------------------------------------------
  Widget _buildBreadcrumb() {
    return Row(
      children: [
        const Icon(
          Icons.science_outlined,
          color: Color(0xFF414754),
          size: 16,
        ),
        const SizedBox(width: 6),
        Obx(
          () => Text(
            controller.breadcrumbSubject.value,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF414754),
              letterSpacing: 0.14,
            ),
          ),
        ),
        const SizedBox(width: 6),
        const Icon(
          Icons.chevron_right_rounded,
          color: Color(0xFF414754),
          size: 18,
        ),
        const SizedBox(width: 6),
        Obx(
          () => Text(
            controller.breadcrumbQuiz.value,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF127FD2),
              letterSpacing: 0.14,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section Header Label
  // ---------------------------------------------------------------------------
  Widget _buildSectionHeader({required String title, required Color textColor}) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: AppTextStyle.fontFamily,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.6,
        color: textColor,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1: Source Topic Input Box
  // ---------------------------------------------------------------------------
  Widget _buildSourceTopicField() {
    return Container(
      width: double.infinity,
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.menu_book_outlined,
            color: Color(0xFF4B6062),
            size: 18,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.topicController,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF191C1D),
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: 'Enter topic (e.g. Human Cell Structure)',
                hintStyle: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 16,
                  color: Color(0xFF9CA3AF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2: AI Instructions Header with Sparkles Icon
  // ---------------------------------------------------------------------------
  Widget _buildAiInstructionsHeader() {
    return const Row(
      children: [
        Icon(
          Icons.auto_awesome_rounded,
          color: Color(0xFF0059BB),
          size: 16,
        ),
        SizedBox(width: 6),
        Text(
          'AI INSTRUCTIONS',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.6,
            color: Color(0xFF0059BB),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2: AI Instructions Textarea matching Figma inset shadow & dimensions
  // ---------------------------------------------------------------------------
  Widget _buildAiInstructionsTextarea() {
    return Container(
      width: double.infinity,
      height: 128,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: TextField(
        controller: controller.instructionsController,
        maxLines: 5,
        style: const TextStyle(
          fontFamily: AppTextStyle.fontFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF191C1D),
          height: 24 / 16,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText:
              "Tell AI what quiz you want to create... e.g., 'Focus heavily on mitochondria and cellular respiration. Include at least 2 questions about osmosis.'",
          hintStyle: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 15,
            color: Color(0xFF9CA3AF),
            height: 22 / 15,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Suggestion Chips (Horizontal Scroll)
  // ---------------------------------------------------------------------------
  Widget _buildSuggestionChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: controller.suggestionChips.map((chip) {
          final label = chip['label'] as String;
          final bgColor = chip['bgColor'] as Color;
          final textColor = chip['textColor'] as Color;
          final icon = chip['icon'] as IconData;
          final iconColor = chip['iconColor'] as Color;

          return GestureDetector(
            onTap: () => controller.onSelectSuggestion(label),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 14, color: iconColor),
                  const SizedBox(width: 4),
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Reusable Icon + Label Row
  // ---------------------------------------------------------------------------
  Widget _buildIconLabelRow({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF476083),
          size: 18,
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF191C1D),
            letterSpacing: 0.14,
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 3: Question Count Selector (5, 10, 15, 20)
  // ---------------------------------------------------------------------------
  Widget _buildQuestionCountSelector() {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
        () => Row(
          children: controller.questionCountOptions.map((count) {
            final isSelected = controller.numberOfQuestions.value == count;

            return Expanded(
              child: GestureDetector(
                onTap: () => controller.onSelectNumberOfQuestions(count),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: isSelected
                        ? const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              offset: Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      count.toString(),
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? const Color(0xFF127FD2) : const Color(0xFF414754),
                        letterSpacing: 0.14,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4: Question Type Selector ('Multiple Choice', 'True / False', 'Mixed')
  // ---------------------------------------------------------------------------
  Widget _buildQuestionTypeSelector() {
    return Container(
      height: 64,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Obx(
        () => Row(
          children: controller.questionTypeOptions.map((type) {
            final isSelected = controller.questionType.value == type;

            return Expanded(
              child: GestureDetector(
                onTap: () => controller.onSelectQuestionType(type),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: isSelected
                        ? const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              offset: Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      type,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 14,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: isSelected ? const Color(0xFF127FD2) : const Color(0xFF414754),
                        letterSpacing: 0.14,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 5: Difficulty & Time / Q (2 Columns)
  // ---------------------------------------------------------------------------
  Widget _buildDifficultyAndTimeRow(BuildContext context) {
    return Row(
      children: [
        // Left Column: Difficulty Card
        Expanded(
          child: GestureDetector(
            onTap: () => _showDifficultyPicker(context),
            child: Container(
              height: 108,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.speed_rounded, color: Color(0xFF476083), size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Difficulty',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF191C1D),
                          letterSpacing: 0.14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            controller.difficulty.value,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF191C1D),
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Color(0xFF476083)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),

        // Right Column: Time / Q Card
        Expanded(
          child: GestureDetector(
            onTap: () => _showTimePicker(context),
            child: Container(
              height: 108,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFF0F0F0), width: 1),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.timer_outlined, color: Color(0xFF476083), size: 16),
                      SizedBox(width: 8),
                      Text(
                        'Time / Q',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF191C1D),
                          letterSpacing: 0.14,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(
                          () => Text(
                            controller.timePerQuestion.value,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF191C1D),
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Color(0xFF476083)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showDifficultyPicker(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Difficulty', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            ...controller.difficultyOptions.map((diff) {
              return ListTile(
                title: Text(diff),
                trailing: Obx(() => controller.difficulty.value == diff
                    ? const Icon(Icons.check, color: Color(0xFF127FD2))
                    : const SizedBox.shrink()),
                onTap: () {
                  controller.onSelectDifficulty(diff);
                  Get.back();
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showTimePicker(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Time per Question', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            ...controller.timeOptions.map((time) {
              return ListTile(
                title: Text(time),
                trailing: Obx(() => controller.timePerQuestion.value == time
                    ? const Icon(Icons.check, color: Color(0xFF127FD2))
                    : const SizedBox.shrink()),
                onTap: () {
                  controller.onSelectTime(time);
                  Get.back();
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 6: XR READY Banner ("Spatial Assets Linked")
  // ---------------------------------------------------------------------------
  Widget _buildXrReadyBanner() {
    return Container(
      width: double.infinity,
      height: 96,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFE8F6FE),
            Color(0xFFF3F7FA),
            Color(0xFFFFFFFF),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(color: const Color(0xFFE3E8EC), width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'XR READY',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: Color(0xFF127FD2),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Spatial Assets Linked',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.6,
                  color: Color(0xFF191C1D),
                ),
              ),
            ],
          ),
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF127FD2).withValues(alpha: 0.12),
            ),
            child: const Center(
              child: Icon(
                Icons.view_in_ar_rounded,
                color: Color(0xFF127FD2),
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 7: Next Action Button
  // ---------------------------------------------------------------------------
  Widget _buildNextButton() {
    return Obx(
      () => GestureDetector(
        onTap: controller.isGenerating.value ? null : controller.onNext,
        child: Container(
          width: double.infinity,
          height: 54,
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
          child: Center(
            child: controller.isGenerating.value
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : const Text(
                    'Next',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
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

typedef AiQuizView = TeacherAiQuizView;
