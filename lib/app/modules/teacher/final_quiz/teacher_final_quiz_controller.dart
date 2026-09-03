import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../routes/app_pages.dart';
import '../lesson_detail/teacher_lesson_detail_controller.dart';
import '../lesson_detail/teacher_lesson_detail_model.dart';

class FinalLessonOption {
  final String id;
  final String title;
  final String subject;
  final IconData icon;

  FinalLessonOption({
    required this.id,
    required this.title,
    required this.subject,
    required this.icon,
  });
}

class TeacherFinalQuizController extends GetxController {
  final RxString quizTitle = 'Quiz Ready'.obs;
  final RxString subject = 'Biology Fundamentals'.obs;
  final RxInt questionCount = 15.obs;
  final RxString duration = '~10m'.obs;
  final RxString selectedClass = 'Class 8-A'.obs;

  final List<String> availableClasses = ['Class 8-A', 'Class 8-B', 'Class 9-A', 'Class 10-B'];

  // Available lessons to link quiz with
  final List<FinalLessonOption> lessonOptions = [
    FinalLessonOption(
      id: 'lesson_1',
      title: 'Chapter 1 — Cell Structure',
      subject: 'Biology Fundamentals',
      icon: Icons.biotech,
    ),
    FinalLessonOption(
      id: 'lesson_2',
      title: 'Chapter 2 — Cell Division',
      subject: 'Biology Fundamentals',
      icon: Icons.biotech,
    ),
    FinalLessonOption(
      id: 'lesson_3',
      title: 'Chapter 1 — Motion',
      subject: 'Physics Fundamentals',
      icon: Icons.science_outlined,
    ),
  ];

  final RxInt selectedLessonIndex = 0.obs;
  final RxBool specificStudentsSelected = false.obs;
  final RxList<String> selectedStudents = <String>[].obs;

  final List<String> allStudents = [
    'Alice Johnson',
    'Benjamin Lee',
    'Chloe Davis',
    'Daniel Martinez',
    'Emma Wilson',
    'Franklin Wright',
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
      if (args['selectedClass'] != null && (args['selectedClass'] as String).isNotEmpty) {
        selectedClass.value = args['selectedClass'];
      }
    }
  }

  void onBack() {
    Get.back();
  }

  void onSelectClass(String className) {
    selectedClass.value = className;
  }

  void onSelectLesson(int index) {
    if (index >= 0 && index < lessonOptions.length) {
      selectedLessonIndex.value = index;
    }
  }

  void onOpenClassPicker() {
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
              'Select Class',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 12),
            ...availableClasses.map(
              (cls) => ListTile(
                title: Text(
                  cls,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF191C1D),
                  ),
                ),
                trailing: selectedClass.value == cls
                    ? const Icon(Icons.check_circle, color: Color(0xFF127FD2))
                    : null,
                onTap: () {
                  selectedClass.value = cls;
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelectSpecificStudents() {
    if (Get.context == null) {
      specificStudentsSelected.value = true;
      selectedStudents.assignAll(['Alice Johnson', 'Benjamin Lee']);
      return;
    }

    final tempSelected = RxList<String>.from(selectedStudents);

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
              'Select Specific Students',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 12),
            ...allStudents.map(
              (student) => Obx(
                () => CheckboxListTile(
                  title: Text(
                    student,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  activeColor: const Color(0xFF127FD2),
                  value: tempSelected.contains(student),
                  onChanged: (val) {
                    if (val == true) {
                      tempSelected.add(student);
                    } else {
                      tempSelected.remove(student);
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
                  selectedStudents.assignAll(tempSelected);
                  specificStudentsSelected.value = selectedStudents.isNotEmpty;
                  Get.back();
                  _showNotice(
                    'Students Assigned',
                    '${selectedStudents.length} students selected for this assessment',
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
    final chosenLesson = lessonOptions[selectedLessonIndex.value];

    // Update TeacherLessonDetailController
    if (Get.isRegistered<TeacherLessonDetailController>()) {
      final detailCtrl = Get.find<TeacherLessonDetailController>();
      if (detailCtrl.lessonData.value != null) {
        final current = detailCtrl.lessonData.value!;
        final newQuiz = TeacherLessonQuizItem(
          title: '${chosenLesson.title} Assessment',
          subtitle: '${questionCount.value} Questions • ${duration.value} • ${selectedClass.value}',
          isAttached: true,
        );

        detailCtrl.lessonData.value = TeacherLessonDetailModel(
          id: current.id,
          title: current.title,
          subject: current.subject,
          grade: current.grade,
          category: current.category,
          status: current.status,
          isVisibleToStudents: current.isVisibleToStudents,
          teacherName: current.teacherName,
          teacherAvatar: current.teacherAvatar,
          description: current.description,
          documents: current.documents,
          videos: current.videos,
          audio: current.audio,
          images: current.images,
          quiz: newQuiz,
          arExperience: current.arExperience,
          vrAsset: current.vrAsset,
        );
      }
    }

    _showNotice(
      'Quiz Assigned!',
      'Quiz successfully assigned to ${selectedClass.value}',
      bgColor: const Color(0xFF127FD2),
    );

    if (Get.testMode || Get.context == null) return;

    // Return to Lesson Detail or Home
    if (Get.isRegistered<TeacherLessonDetailController>()) {
      Get.until((route) => route.settings.name == Routes.TEACHER_LESSON_DETAIL);
    } else {
      Get.offAllNamed(Routes.TEACHER_DASHBOARD);
    }
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

typedef FinalQuizController = TeacherFinalQuizController;
