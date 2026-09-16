import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'parent_final_quiz_controller.dart';

class ParentFinalQuizView extends GetView<ParentFinalQuizController> {
  const ParentFinalQuizView({super.key});

  static const String fontFamily = 'Google Sans Flex';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ParentFinalQuizController>()) {
      Get.put(ParentFinalQuizController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Back Row
                    Row(
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
                    ),
                    const SizedBox(height: 16),

                    // 1. Summary Card: Quiz Ready
                    _buildSummaryCard(),
                    const SizedBox(height: 24),

                    // 2. Child Selection Button
                    _buildChildSelectionButton(),
                    const SizedBox(height: 24),

                    // 3. Select Lesson Section
                    _buildSelectLessonSection(),
                    const SizedBox(height: 20),

                    // 4. Select Specific Children Button
                    _buildSelectSpecificChildrenButton(),
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
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Row(
                        children: [
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

  // 2. Child Selection Button
  Widget _buildChildSelectionButton() {
    return GestureDetector(
      onTap: controller.onOpenChildPicker,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E4E8), width: 1),
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
            Row(
              children: [
                const Icon(
                  Icons.face_rounded,
                  size: 20,
                  color: Color(0xFF127FD2),
                ),
                const SizedBox(width: 12),
                Obx(() => Text(
                      controller.selectedChild.value,
                      style: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF191C1D),
                      ),
                    )),
              ],
            ),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: Color(0xFF717786),
              size: 20,
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
        const Text(
          'SELECT LESSON TO LINK',
          style: TextStyle(
            fontFamily: fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            color: Color(0xFF414754),
          ),
        ),
        const SizedBox(height: 12),
        ...controller.lessonOptions.asMap().entries.map((entry) {
          final index = entry.key;
          final lesson = entry.value;

          return Obx(() {
            final isSelected = controller.selectedLessonIndex.value == index;

            return GestureDetector(
              onTap: () => controller.onSelectLesson(index),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFFE0F6FF).withValues(alpha: 0.4) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF127FD2) : const Color(0xFFE2E4E8),
                    width: isSelected ? 1.5 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF127FD2).withValues(alpha: 0.15) : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        lesson.icon,
                        size: 20,
                        color: isSelected ? const Color(0xFF127FD2) : const Color(0xFF476083),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lesson.subject,
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 12,
                              color: isSelected ? const Color(0xFF127FD2) : const Color(0xFF476083),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            lesson.title,
                            style: const TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF191C1D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                      color: isSelected ? const Color(0xFF127FD2) : const Color(0xFF717786),
                      size: 22,
                    ),
                  ],
                ),
              ),
            );
          });
        }),
      ],
    );
  }

  // 4. Select Specific Children Button
  Widget _buildSelectSpecificChildrenButton() {
    return GestureDetector(
      onTap: controller.onSelectSpecificChildren,
      child: Container(
        constraints: const BoxConstraints(minHeight: 48),
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
              Icons.group_add_outlined,
              size: 20,
              color: Color(0xFF127FD2),
            ),
            const SizedBox(width: 10),
            Flexible(
              child: Obx(() {
                if (controller.specificChildrenSelected.value) {
                  return Text(
                    '${controller.selectedChildren.length} Child(ren) Selected',
                    style: const TextStyle(
                      fontFamily: fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF127FD2),
                    ),
                  );
                }
                return const Text(
                  'Select Specific Child',
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
        height: 52,
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
                fontSize: 16,
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
