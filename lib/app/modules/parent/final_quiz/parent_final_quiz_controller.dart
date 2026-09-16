import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../routes/app_pages.dart';

class ParentFinalLessonOption {
  final String id;
  final String title;
  final String subject;
  final IconData icon;

  ParentFinalLessonOption({
    required this.id,
    required this.title,
    required this.subject,
    required this.icon,
  });
}

class ParentFinalQuizController extends GetxController {
  final RxString quizTitle = 'Quiz Ready'.obs;
  final RxString subject = 'Science Fundamentals'.obs;
  final RxInt questionCount = 10.obs;
  final RxString duration = '~10m'.obs;
  final RxString selectedChild = 'Daniel (Grade 8)'.obs;

  final List<String> availableChildren = ['Daniel (Grade 8)', 'Tony (Grade 6)', 'Both Children'];

  // Available lessons to link quiz with
  final List<ParentFinalLessonOption> lessonOptions = [
    ParentFinalLessonOption(
      id: 'lesson_1',
      title: 'Chapter 1 — Cell Structure',
      subject: 'Science Fundamentals',
      icon: Icons.biotech,
    ),
    ParentFinalLessonOption(
      id: 'lesson_2',
      title: 'Chapter 2 — Cell Division',
      subject: 'Science Fundamentals',
      icon: Icons.biotech,
    ),
    ParentFinalLessonOption(
      id: 'lesson_3',
      title: 'Chapter 1 — Motion & Force',
      subject: 'Physics Fundamentals',
      icon: Icons.science_outlined,
    ),
  ];

  final RxInt selectedLessonIndex = 0.obs;
  final RxBool specificChildrenSelected = false.obs;
  final RxList<String> selectedChildren = <String>[].obs;

  final List<String> allChildren = [
    'Daniel (Grade 8)',
    'Tony (Grade 6)',
  ];

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      if (args['quizTitle'] != null && (args['quizTitle'] as String).isNotEmpty) {
        quizTitle.value = args['quizTitle'];
      }
      if (args['subject'] != null && (args['subject'] as String).isNotEmpty) {
        subject.value = args['subject'];
      }
      if (args['questionCount'] != null && (args['questionCount'] as int) > 0) {
        questionCount.value = args['questionCount'];
      }
      if (args['duration'] != null && (args['duration'] as String).isNotEmpty) {
        duration.value = args['duration'];
      }
      if (args['selectedChild'] != null && (args['selectedChild'] as String).isNotEmpty) {
        selectedChild.value = args['selectedChild'];
      }
    }
  }

  void onBack() {
    Get.back();
  }

  void onSelectChild(String childName) {
    selectedChild.value = childName;
  }

  void onSelectLesson(int index) {
    if (index >= 0 && index < lessonOptions.length) {
      selectedLessonIndex.value = index;
    }
  }

  void onOpenChildPicker() {
    if (Get.context == null) return;
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
            const Text(
              'Assign To Child',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 12),
            ...availableChildren.map(
              (ch) => ListTile(
                title: Text(
                  ch,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF191C1D),
                  ),
                ),
                trailing: selectedChild.value == ch
                    ? const Icon(Icons.check_circle, color: Color(0xFF127FD2))
                    : null,
                onTap: () {
                  selectedChild.value = ch;
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelectSpecificChildren() {
    if (Get.context == null) {
      specificChildrenSelected.value = true;
      selectedChildren.assignAll(['Daniel (Grade 8)']);
      return;
    }

    final tempSelected = RxList<String>.from(selectedChildren);

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
            const Text(
              'Select Specific Child',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 12),
            ...allChildren.map(
              (child) => Obx(
                () => CheckboxListTile(
                  title: Text(
                    child,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  activeColor: const Color(0xFF127FD2),
                  value: tempSelected.contains(child),
                  onChanged: (val) {
                    if (val == true) {
                      tempSelected.add(child);
                    } else {
                      tempSelected.remove(child);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127FD2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  selectedChildren.assignAll(tempSelected);
                  specificChildrenSelected.value = selectedChildren.isNotEmpty;
                  Get.back();
                  _showNotice(
                    'Children Assigned',
                    '${selectedChildren.length} child(ren) selected for this assessment',
                  );
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onAssignQuiz() {
    _showNotice(
      'Quiz Assigned!',
      'Quiz successfully assigned to ${selectedChild.value}',
      bgColor: const Color(0xFF127FD2),
    );

    if (Get.testMode || Get.context == null) return;

    // Return to Parent Quizzes or Parent Home
    Get.offNamedUntil(
      Routes.PARENT_QUIZZES,
      (route) => route.settings.name == Routes.PARENT_HOME || route.settings.name == Routes.PARENT_QUIZZES,
    );
  }

  void _showNotice(String title, String message, {Color? bgColor}) {
    if (Get.testMode || Get.context == null) return;
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: bgColor ?? const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }
}
