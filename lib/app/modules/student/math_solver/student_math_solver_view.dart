import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'student_math_solver_controller.dart';

class StudentMathSolverView extends GetView<StudentMathSolverController> {
  const StudentMathSolverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            _buildTopBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input Modality Toggles (Tabs)
                    _buildInputModalityToggles(),
                    const SizedBox(height: 20),

                    // Expression Header & Input Field
                    _buildExpressionSection(),
                    const SizedBox(height: 14),

                    // Math Symbol Keypad Toolbar
                    _buildMathSymbolToolbar(),
                    const SizedBox(height: 16),

                    // Quick Suggestion Pill
                    _buildSuggestionPill(),
                    const SizedBox(height: 16),

                    // Primary Action Button (Solve Equation Now)
                    _buildPrimaryActionButton(),
                    const SizedBox(height: 28),

                    // Step-by-Step Breakdown Section
                    _buildBreakdownHeader(),
                    const SizedBox(height: 18),

                    // Original Equation Card
                    _buildOriginalEquationCard(),
                    const SizedBox(height: 20),

                    // Step 1 & Step 2 Timeline
                    _buildStepsTimeline(),
                    const SizedBox(height: 24),

                    // Final Answer Spotlight Callout
                    _buildFinalAnswerCallout(),
                    const SizedBox(height: 20),

                    // Action Row (Ask Nova AI / Solve Another)
                    _buildActionRow(),
                    const SizedBox(height: 28),

                    // Spatial Concept Visualizer
                    _buildSpatialVisualizerSection(),
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

  // 1. Top Bar
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          // Circular Back Button (Ellipse 18)
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: const Color(0xFF1567A2), width: 1.5),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF1567A2),
                size: 22,
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Math Solver',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  // 2. Input Modality Toggles (Tabs)
  Widget _buildInputModalityToggles() {
    final tabs = ['Type Equation', 'Voice Input', 'Scan & XR'];

    return Obx(() {
      return Container(
        height: 44,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: List.generate(tabs.length, (index) {
            final isSelected = controller.selectedTab.value == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.selectTab(index),
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: isSelected
                        ? const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 2,
                              offset: Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tabs[index],
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 12,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                      color: isSelected
                          ? const Color(0xFF0059BB)
                          : const Color(0xFF414754),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      );
    });
  }

  // 3. Expression Section
  Widget _buildExpressionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Expression Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.calculate_outlined,
                  size: 15,
                  color: Color(0xFF0059BB),
                ),
                SizedBox(width: 6),
                Text(
                  'EXPRESSION',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: Color(0xFF476083),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                'Algebra • Calculus • XR',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF414754).withValues(alpha: 0.7),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Expression Input Field
        Container(
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F5),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.centerLeft,
          child: TextField(
            controller: controller.equationController,
            style: const TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 20,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
              color: Color(0xFF191C1D),
            ),
            cursorColor: const Color(0xFF127FD2),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: 'Enter equation...',
              hintStyle: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xFF94A3B8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 4. Math Symbol Keypad Toolbar
  Widget _buildMathSymbolToolbar() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: controller.mathSymbols.map((symbol) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => controller.insertSymbol(symbol),
              borderRadius: BorderRadius.circular(8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                constraints: const BoxConstraints(minWidth: 36, minHeight: 34),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F5),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  symbol,
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF191C1D),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 5. Quick Suggestion Pill
  Widget _buildSuggestionPill() {
    return Obx(() {
      if (!controller.showSuggestion.value) {
        return const SizedBox.shrink();
      }

      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F5).withValues(alpha: 0.75),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.lightbulb_outline_rounded,
              size: 16,
              color: Color(0xFF0059BB),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text(
                    'Try: ',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF476083),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.setEquation('∫ 3x² dx'),
                    child: const Text(
                      '∫ 3x² dx',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  const Text(
                    ' or ',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF476083),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.setEquation('3x + 9 = 24'),
                    child: const Text(
                      '3x + 9 = 24',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: controller.closeSuggestion,
              child: const Icon(
                Icons.close_rounded,
                size: 18,
                color: Color(0xFF476083),
              ),
            ),
          ],
        ),
      );
    });
  }

  // 6. Primary Action Button
  Widget _buildPrimaryActionButton() {
    return Obx(() {
      final isSolving = controller.isSolving.value;

      return Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF53B5E0), Color(0xFF11629E)],
          ),
          borderRadius: BorderRadius.circular(58),
          boxShadow: const [
            BoxShadow(
              color: Color(0x400059BB),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(58),
            onTap: isSolving ? null : controller.solve,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isSolving)
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                else ...[
                  const Icon(
                    Icons.bolt_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'SOLVE EQUATION NOW',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    });
  }

  // 7. Step-by-Step Breakdown Header
  Widget _buildBreakdownHeader() {
    return Row(
      children: [
        const Icon(
          Icons.verified_rounded,
          color: Color(0xFF127FD2),
          size: 20,
        ),
        const SizedBox(width: 8),
        const Expanded(
          child: Text(
            'Step-by-Step Breakdown',
            style: TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191C1D),
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFF127FD2),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            const Text(
              'ZAMA AI Engine',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF091F21),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 8. Original Equation Card
  Widget _buildOriginalEquationCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ORIGINAL EQUATION',
          style: TextStyle(
            fontFamily: 'Google Sans Flex',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: Color(0xFF476083),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller.equationController,
                builder: (context, value, child) {
                  final text = value.text.isNotEmpty ? value.text : '2x + 5 = 15';
                  return Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: Color(0xFF191C1D),
                    ),
                    overflow: TextOverflow.ellipsis,
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F5),
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.functions_rounded,
                color: Color(0xFF0059BB),
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 9. Step 1 & Step 2 Timeline
  Widget _buildStepsTimeline() {
    return Column(
      children: [
        // Step 1
        _buildTimelineStep(
          stepNumber: '1',
          title: 'Isolate the variable term',
          property: 'Subtraction Property',
          instruction: 'Subtract 5 from both sides of the equation to balance:',
          leftFormula: '2x + 5 - 5 = 15 - 5',
          rightResult: '→ 2x = 10',
          isLast: false,
        ),
        const SizedBox(height: 16),

        // Step 2
        _buildTimelineStep(
          stepNumber: '2',
          title: 'Solve for coefficient x',
          property: 'Division Property',
          instruction: 'Divide both sides by the constant multiplier 2:',
          leftFormula: '2x / 2 = 10 / 2',
          rightResult: '→ x = 5',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineStep({
    required String stepNumber,
    required String title,
    required String property,
    required String instruction,
    required String leftFormula,
    required String rightResult,
    required bool isLast,
  }) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step circle badge and vertical line
          Column(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Color(0xFF127FD2),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  stepNumber,
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: const Color(0xFFE7E8E9),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Step title & property badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF191C1D),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F4F5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        property,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF476083),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),

                // Explanatory note
                Text(
                  instruction,
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF414754),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 10),

                // Calculation Result Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          leftFormula,
                          style: const TextStyle(
                            fontFamily: 'Google Sans Flex',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF191C1D),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        rightResult,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF127FD2),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 10. Final Answer Spotlight Callout
  Widget _buildFinalAnswerCallout() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F6FF),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x140059BB),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text(
                  'FINAL VERIFIED SOLUTION',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                    color: Color(0xFF476083),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Text(
                  'Coordinate: (5, 0)',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0059BB),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Root Found Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const [
              Text(
                'x = 5',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF127FD2),
                  letterSpacing: -0.6,
                ),
              ),
              SizedBox(width: 12),
              Text(
                'Real root found',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF476083),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Explanation Text
          const Text(
            'The linear equation evaluates to a single real solution. The line intersects the primary Cartesian X-axis at point (5, 0) with a slope of 2.',
            style: TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF445D80),
              height: 1.45,
            ),
          ),
          const SizedBox(height: 16),

          // Mini XR Spatial Preview Teaser
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.view_in_ar_rounded,
                  size: 20,
                  color: Color(0xFF127FD2),
                ),
                const SizedBox(width: 10),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3D Graph Projection',
                        style: TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'View Cartesian plane in XR',
                        style: TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF476083),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: controller.onProjectInXr,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                    decoration: BoxDecoration(
                      color: const Color(0xFF127FD2),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0D000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Text(
                          'Project',
                          style: TextStyle(
                            fontFamily: 'Google Sans Flex',
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.open_in_new_rounded,
                          size: 12,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 11. Action Row (Ask Nova AI / Solve Another)
  Widget _buildActionRow() {
    return Row(
      children: [
        // Ask Nova AI
        Expanded(
          child: InkWell(
            onTap: controller.onAskNovaAi,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: const [
                  Icon(
                    Icons.auto_awesome_rounded,
                    size: 16,
                    color: Color(0xFF127FD2),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ask Nova AI',
                          style: TextStyle(
                            fontFamily: 'Google Sans Flex',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF127FD2),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Understand linear proofs',
                          style: TextStyle(
                            fontFamily: 'Google Sans Flex',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF476083),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),

        // Solve Another
        Expanded(
          child: InkWell(
            onTap: controller.onSolveAnother,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                children: const [
                  Icon(
                    Icons.refresh_rounded,
                    size: 18,
                    color: Color(0xFF476083),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Solve Another',
                          style: TextStyle(
                            fontFamily: 'Google Sans Flex',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF191C1D),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Clear and start anew',
                          style: TextStyle(
                            fontFamily: 'Google Sans Flex',
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF476083),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
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

  // 12. Spatial Concept Visualizer
  Widget _buildSpatialVisualizerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Expanded(
              child: Text(
                'SPATIAL CONCEPT VISUALIZER',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                  color: Color(0xFF476083),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 8),
            Text(
              'ZAMA Studio',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF127FD2),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 3D Visualizer Banner
        GestureDetector(
          onTap: controller.onLaunch3DModel,
          child: Container(
            height: 132,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F172A),
                  Color(0xFF0369A1),
                  Color(0xFF0284C7),
                ],
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1F000000),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Geometric XR Grid lines decoration
                Positioned.fill(
                  child: CustomPaint(
                    painter: _GridPatternPainter(),
                  ),
                ),

                // Blur overlay
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0059BB).withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                // Floating Action Pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.96),
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.view_in_ar_rounded,
                        size: 16,
                        color: Color(0xFF127FD2),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Tap to launch Interactive 3D Model',
                        style: TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF127FD2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Subtle grid lines painter for the XR visualizer preview banner
class _GridPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1.0;

    const spacing = 22.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
