import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../lesson_detail/teacher_lesson_detail_controller.dart';
import '../lesson_detail/teacher_lesson_detail_model.dart';

enum ManualQuestionType { multipleChoice, trueFalse, shortAnswer }

class ManualQuizQuestion {
  final String id;
  String number; // e.g. '01', '02'
  String typeName; // 'Multiple Choice', 'True / False'
  ManualQuestionType type;
  String questionText;
  List<String> options;
  int selectedCorrectIndex;
  int points;

  ManualQuizQuestion({
    required this.id,
    required this.number,
    required this.typeName,
    required this.type,
    required this.questionText,
    required this.options,
    required this.selectedCorrectIndex,
    this.points = 10,
  });
}

class TeacherManualQuizController extends GetxController {
  // Form Controllers
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController passingCriteriaController;

  // Header info
  final RxString quizCategory = 'CELL STRUCTURE QUIZ'.obs;
  final RxString quizSubheader = 'Biology Fundamentals • Chapter 1'.obs;
  final RxString lessonTitle = 'Cell Structure'.obs;

  // Questions List
  final RxList<ManualQuizQuestion> questions = <ManualQuizQuestion>[].obs;

  int get totalPoints => questions.fold(0, (sum, q) => sum + q.points);

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController(text: 'Cell Structure Masterclass');
    descriptionController = TextEditingController(
      text: 'A comprehensive quiz to test knowledge on basic cell',
    );
    passingCriteriaController = TextEditingController(text: '70');

    // Read route arguments if passed
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final args = Get.arguments as Map<String, dynamic>;
      if (args['subject'] != null) {
        quizCategory.value = '${(args['subject'] as String).toUpperCase()} QUIZ';
        quizSubheader.value = '${args['subject']} Fundamentals • Chapter 1';
      }
      if (args['lessonTitle'] != null) {
        lessonTitle.value = args['lessonTitle'];
        titleController.text = '${args['lessonTitle']} Masterclass';
      }
    }

    _loadDefaultQuestions();
  }

  void _loadDefaultQuestions() {
    questions.assignAll([
      ManualQuizQuestion(
        id: 'q_1',
        number: '01',
        typeName: 'Multiple Choice',
        type: ManualQuestionType.multipleChoice,
        questionText: 'What is the main function of the nucleus?',
        options: [
          'Controls cell activities',
          'Produces energy',
          'Stores water',
        ],
        selectedCorrectIndex: 0,
        points: 10,
      ),
      ManualQuizQuestion(
        id: 'q_2',
        number: '02',
        typeName: 'True / False',
        type: ManualQuestionType.trueFalse,
        questionText: 'Mitochondria are known as the powerhouse of the cell.',
        options: [
          'True',
          'False',
        ],
        selectedCorrectIndex: 0,
        points: 10,
      ),
    ]);
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    passingCriteriaController.dispose();
    super.onClose();
  }

  void _showNotice(String title, String message, {Color? bgColor}) {
    if (Get.testMode) return;
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

  void onBack() {
    Get.back();
  }

  void onMoreOptions() {
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
              'Quiz Options',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.refresh_rounded, color: Color(0xFF414754)),
              title: const Text('Reset to Sample Questions'),
              onTap: () {
                _loadDefaultQuestions();
                Get.back();
                _showNotice('Reset', 'Questions were reset to defaults');
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_sweep_outlined, color: Color(0xFFBA1A1A)),
              title: const Text('Clear All Questions', style: TextStyle(color: Color(0xFFBA1A1A))),
              onTap: () {
                questions.clear();
                Get.back();
                _showNotice('Cleared', 'All questions removed');
              },
            ),
          ],
        ),
      ),
    );
  }

  void onSelectOption(int questionIndex, int optionIndex) {
    if (questionIndex >= 0 && questionIndex < questions.length) {
      final q = questions[questionIndex];
      q.selectedCorrectIndex = optionIndex;
      questions.refresh();
    }
  }

  void onDeleteQuestion(int index) {
    if (index >= 0 && index < questions.length) {
      questions.removeAt(index);
      // Re-number questions
      for (int i = 0; i < questions.length; i++) {
        questions[i].number = (i + 1).toString().padLeft(2, '0');
      }
      _showNotice('Removed', 'Question removed');
    }
  }

  void onEditQuestion(int index) {
    if (index < 0 || index >= questions.length) return;
    final q = questions[index];
    final qTextCtrl = TextEditingController(text: q.questionText);
    final optCtrls = q.options.map((o) => TextEditingController(text: o)).toList();
    final selectedIdx = q.selectedCorrectIndex.obs;

    if (Get.context == null) return;

    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Edit Question ${q.number}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Get.back()),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: qTextCtrl,
                decoration: const InputDecoration(
                  labelText: 'Question Text',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Options & Correct Answer:', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ...optCtrls.asMap().entries.map((entry) {
                final optIdx = entry.key;
                final ctrl = entry.value;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Obx(
                        () => GestureDetector(
                          onTap: () => selectedIdx.value = optIdx,
                          child: Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                color: selectedIdx.value == optIdx
                                    ? const Color(0xFF127FD2)
                                    : const Color(0xFFC1C6D7),
                                width: selectedIdx.value == optIdx ? 5 : 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: ctrl,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Option ${optIdx + 1}',
                            border: const OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF127FD2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    q.questionText = qTextCtrl.text.trim();
                    q.options = optCtrls.map((c) => c.text.trim()).toList();
                    q.selectedCorrectIndex = selectedIdx.value;
                    questions.refresh();
                    Get.back();
                    _showNotice('Updated', 'Question ${q.number} updated successfully');
                  },
                  child: const Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAddQuestion() {
    final qTextCtrl = TextEditingController();
    final opt1Ctrl = TextEditingController(text: 'Controls metabolism');
    final opt2Ctrl = TextEditingController(text: 'Provides structural support');
    final opt3Ctrl = TextEditingController(text: 'Synthesizes proteins');
    final selectedIdx = 0.obs;
    final selectedType = ManualQuestionType.multipleChoice.obs;

    if (Get.context == null) {
      // Direct add for testing
      final newIndex = questions.length + 1;
      questions.add(
        ManualQuizQuestion(
          id: 'q_${DateTime.now().millisecondsSinceEpoch}',
          number: newIndex.toString().padLeft(2, '0'),
          typeName: 'Multiple Choice',
          type: ManualQuestionType.multipleChoice,
          questionText: 'What is the function of ribosomes?',
          options: ['Synthesizes proteins', 'Energy storage', 'Cell division'],
          selectedCorrectIndex: 0,
        ),
      );
      return;
    }

    Get.bottomSheet(
      isScrollControlled: true,
      Container(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 20,
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Question ${(questions.length + 1).toString().padLeft(2, "0")}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Get.back()),
                ],
              ),
              const SizedBox(height: 12),
              Obx(
                () => Row(
                  children: [
                    ChoiceChip(
                      label: const Text('Multiple Choice'),
                      selected: selectedType.value == ManualQuestionType.multipleChoice,
                      onSelected: (val) {
                        if (val) selectedType.value = ManualQuestionType.multipleChoice;
                      },
                      selectedColor: const Color(0xFFE0F6FF),
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('True / False'),
                      selected: selectedType.value == ManualQuestionType.trueFalse,
                      onSelected: (val) {
                        if (val) selectedType.value = ManualQuestionType.trueFalse;
                      },
                      selectedColor: const Color(0xFFE0F6FF),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: qTextCtrl,
                decoration: const InputDecoration(
                  labelText: 'Question Text',
                  hintText: 'e.g. Which organelle contains chlorophyll?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Options (select the correct answer):', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Obx(() {
                if (selectedType.value == ManualQuestionType.trueFalse) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => selectedIdx.value = 0,
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: selectedIdx.value == 0
                                      ? const Color(0xFF127FD2)
                                      : const Color(0xFFC1C6D7),
                                  width: selectedIdx.value == 0 ? 5 : 1,
                                ),
                              ),
                            ),
                          ),
                          const Text('True', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => selectedIdx.value = 1,
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: selectedIdx.value == 1
                                      ? const Color(0xFF127FD2)
                                      : const Color(0xFFC1C6D7),
                                  width: selectedIdx.value == 1 ? 5 : 1,
                                ),
                              ),
                            ),
                          ),
                          const Text('False', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    ...[opt1Ctrl, opt2Ctrl, opt3Ctrl].asMap().entries.map((entry) {
                      final optIdx = entry.key;
                      final ctrl = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => selectedIdx.value = optIdx,
                              child: Container(
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                    color: selectedIdx.value == optIdx
                                        ? const Color(0xFF127FD2)
                                        : const Color(0xFFC1C6D7),
                                    width: selectedIdx.value == optIdx ? 5 : 1,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: ctrl,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Option ${optIdx + 1}',
                                  border: const OutlineInputBorder(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                );
              }),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF127FD2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    final qText = qTextCtrl.text.trim();
                    if (qText.isEmpty) {
                      _showNotice('Required', 'Please enter question text');
                      return;
                    }

                    final newIndex = questions.length + 1;
                    final isTf = selectedType.value == ManualQuestionType.trueFalse;
                    final options = isTf
                        ? ['True', 'False']
                        : [opt1Ctrl.text.trim(), opt2Ctrl.text.trim(), opt3Ctrl.text.trim()];

                    questions.add(
                      ManualQuizQuestion(
                        id: 'q_${DateTime.now().millisecondsSinceEpoch}',
                        number: newIndex.toString().padLeft(2, '0'),
                        typeName: isTf ? 'True / False' : 'Multiple Choice',
                        type: selectedType.value,
                        questionText: qText,
                        options: options,
                        selectedCorrectIndex: selectedIdx.value,
                        points: 10,
                      ),
                    );
                    Get.back();
                    _showNotice('Added', 'Question added to quiz');
                  },
                  child: const Text('Add Question', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onSaveQuiz() {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      _showNotice('Required', 'Please enter a quiz title');
      return;
    }

    // Connect with TeacherLessonDetailController
    if (Get.isRegistered<TeacherLessonDetailController>()) {
      final detailCtrl = Get.find<TeacherLessonDetailController>();
      if (detailCtrl.lessonData.value != null) {
        final current = detailCtrl.lessonData.value!;
        final newQuiz = TeacherLessonQuizItem(
          title: title,
          subtitle: '${questions.length} Questions • ${passingCriteriaController.text}% Passing',
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
      'Quiz Saved',
      'Quiz "$title" saved with ${questions.length} questions!',
      bgColor: const Color(0xFF127FD2),
    );

    // Redirect to Review Quiz screen as specified
    Get.toNamed(
      Routes.TEACHER_REVIEW_QUIZ,
      arguments: {
        'lessonTitle': title,
        'subject': quizSubheader.value.split(' ').first,
      },
    );
  }
}

typedef ManualQuizController = TeacherManualQuizController;
