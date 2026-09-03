import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'teacher_final_quiz_controller.dart';

class TeacherFinalQuizView extends GetView<TeacherFinalQuizController> {
  const TeacherFinalQuizView({super.key});

  static const String fontFamily = 'Google Sans Flex';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Summary Card: Quiz Ready (matches Figma top: 78px)
                    _buildSummaryCard(),
                    const SizedBox(height: 24),

                    // 2. Class Selection Button
                    _buildClassSelectionButton(),
                    const SizedBox(height: 24),

                    // 3. Select Lesson Section
                    _buildSelectLessonSection(),
                    const SizedBox(height: 20),

                    // 4. Select Specific Students Button
                    _buildSelectSpecificStudentsButton(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // 5. Fixed Bottom Button: Assign Quiz
            _buildBottomActionBar(),
          ],
        ),
      ),
    );
  }

  // 1. Summary Card
  Widget _buildSummaryCard() {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFE0F6FF).withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF127FD2).withValues(alpha: 0.32),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF127FD2).withValues(alpha: 0.20),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative Blurred Accent Circle
          Positioned(
            right: -32,
            top: -32,
            child: Container(
              width: 128,
              height: 128,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF127FD2).withValues(alpha: 0.17),
              ),
            ),
          ),

          // Main Card Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Icon Box (48x48)
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFF127FD2),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        offset: const Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.assignment_turned_in_outlined,
                      color: Color(0xFFFEFCFF),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),

                // Text & Stats Column
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Heading: Main Title (20px - 21px, w600 per ARCHITECTURE.md)
                      Obx(() => Text(
                            controller.quizTitle.value,
                            style: const TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF191C1D),
                              letterSpacing: -0.2,
                            ),
                          )),
                      const SizedBox(height: 2),

                      // Subtitle: Secondary Text (12px - 13px, w400 per ARCHITECTURE.md)
                      Obx(() => Text(
                            controller.subject.value,
                            style: const TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF414754),
                            ),
                          )),
                      const SizedBox(height: 12),

                      // Stat Chips: Questions & Duration (Micro Badges: 11px - 12px per ARCHITECTURE.md)
                      Row(
                        children: [
                          // Chip 1: Questions
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.format_list_numbered,
                                    size: 16,
                                    color: Color(0xFF127FD2),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Questions',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF414754),
                                          ),
                                        ),
                                        Obx(() => Text(
                                              '${controller.questionCount.value}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontFamily: fontFamily,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF191C1D),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),

                          // Chip 2: Duration
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    offset: const Offset(0, 1),
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.access_time,
                                    size: 16,
                                    color: Color(0xFF127FD2),
                                  ),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          'Duration',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: fontFamily,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                            color: Color(0xFF414754),
                                          ),
                                        ),
                                        Obx(() => Text(
                                              controller.duration.value,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontFamily: fontFamily,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF191C1D),
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 2. Class Selection Button
  Widget _buildClassSelectionButton() {
    return GestureDetector(
      onTap: controller.onOpenClassPicker,
      child: Container(
        constraints: const BoxConstraints(minHeight: 56),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  const Icon(
                    Icons.groups_outlined,
                    size: 20,
                    color: Color(0xFF191C1D),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Obx(() => Text(
                          controller.selectedClass.value,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF191C1D),
                          ),
                        )),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.check_circle,
              color: Color(0xFF127FD2),
              size: 22,
            ),
          ],
        ),
      ),
    );
  }

  // 3. Select Lesson Section
  Widget _buildSelectLessonSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header: 15px - 17px, w600 per ARCHITECTURE.md
        const Text(
          'Select Lesson',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
            color: Color(0xFF191C1D),
          ),
        ),
        const SizedBox(height: 12),

        // List of Lesson cards
        ...controller.lessonOptions.asMap().entries.map((entry) {
          final idx = entry.key;
          final lesson = entry.value;

          return Obx(() {
            final isSelected = controller.selectedLessonIndex.value == idx;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: GestureDetector(
                onTap: () => controller.onSelectLesson(idx),
                child: Container(
                  constraints: const BoxConstraints(minHeight: 74),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFE0F6FF).withValues(alpha: 0.24)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF127FD2) : const Color(0xFFECECEC),
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        offset: const Offset(0, 1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Icon Container (40x40)
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFFF8F9FA) : const Color(0xFFEDEEEF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Icon(
                            lesson.icon,
                            size: 20,
                            color: isSelected
                                ? const Color(0xFF127FD2)
                                : const Color(0xFF476083),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),

                      // Titles
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              lesson.subject,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: isSelected
                                    ? const Color(0xFF127FD2)
                                    : const Color(0xFF476083),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              lesson.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF191C1D),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),

                      // Radio Button
                      if (isSelected)
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF127FD2),
                          ),
                          child: Center(
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            border: Border.all(
                              color: const Color(0xFF717786),
                              width: 2,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          });
        }),
      ],
    );
  }

  // 4. Select Specific Students Button
  Widget _buildSelectSpecificStudentsButton() {
    return GestureDetector(
      onTap: controller.onSelectSpecificStudents,
      child: Container(
        constraints: const BoxConstraints(minHeight: 52),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person_add_alt_1_outlined,
              size: 20,
              color: Color(0xFF127FD2),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Obx(() {
                if (controller.specificStudentsSelected.value) {
                  return Text(
                    '${controller.selectedStudents.length} Students Selected',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.1,
                      color: Color(0xFF127FD2),
                    ),
                  );
                }
                return const Text(
                  'Select Specific Students',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                    color: Color(0xFF127FD2),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // 5. Fixed Bottom Action: Assign Quiz Button
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
            onPressed: controller.onAssignQuiz,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(74),
              ),
            ),
            child: const Text(
              'Assign Quiz',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

typedef FinalQuizView = TeacherFinalQuizView;
