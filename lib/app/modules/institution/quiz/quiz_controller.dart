import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'quiz_model.dart';

class QuizController extends GetxController {
  final Rxn<QuizModel> quizData = Rxn<QuizModel>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController passingCriteriaController;

  @override
  void onInit() {
    super.onInit();
    _loadQuizData();

    titleController = TextEditingController(text: quizData.value?.title ?? '');
    descriptionController =
        TextEditingController(text: quizData.value?.description ?? '');
    passingCriteriaController = TextEditingController(
      text: quizData.value?.passingCriteria.toString() ?? '70',
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    passingCriteriaController.dispose();
    super.onClose();
  }

  void _loadQuizData() {
    final defaultQuestions = [
      QuizQuestion(
        id: 'q1',
        numberString: '01',
        questionTypeLabel: 'Multiple Choice',
        type: QuizQuestionType.multipleChoice,
        questionText: 'What is the main function of the nucleus?',
        points: 10,
        options: [
          const QuizOption(
            id: 'opt1_1',
            text: 'Controls cell activities',
            isCorrect: true,
            isSelected: true,
          ),
          const QuizOption(
            id: 'opt1_2',
            text: 'Produces energy',
            isCorrect: false,
            isSelected: false,
          ),
          const QuizOption(
            id: 'opt1_3',
            text: 'Stores water',
            isCorrect: false,
            isSelected: false,
          ),
        ],
      ),
      QuizQuestion(
        id: 'q2',
        numberString: '02',
        questionTypeLabel: 'True / False',
        type: QuizQuestionType.trueFalse,
        questionText: 'Mitochondria are known as the powerhouse of the cell.',
        points: 10,
        options: [
          const QuizOption(
            id: 'opt2_1',
            text: 'True',
            isCorrect: true,
            isSelected: true,
          ),
          const QuizOption(
            id: 'opt2_2',
            text: 'False',
            isCorrect: false,
            isSelected: false,
          ),
        ],
      ),
    ];

    quizData.value = QuizModel(
      id: 'quiz_cell_structure',
      tag: 'CELL STRUCTURE QUIZ',
      categorySubtitle: 'Biology Fundamentals • Chapter 1',
      title: 'Cell Structure Masterclass',
      description:
          'A comprehensive quiz to test knowledge on basic cell structures and their functions.',
      passingCriteria: 70,
      totalQuestions: 10,
      totalPoints: 100,
      questions: defaultQuestions,
    );
  }

  void onSelectOption(String questionId, String optionId) {
    final current = quizData.value;
    if (current == null) return;

    final updatedQuestions = current.questions.map((q) {
      if (q.id != questionId) return q;

      final updatedOptions = q.options.map((opt) {
        return opt.copyWith(isSelected: opt.id == optionId);
      }).toList();

      return q.copyWith(options: updatedOptions);
    }).toList();

    quizData.value = current.copyWith(questions: updatedQuestions);
  }

  void onEditQuestion(QuizQuestion question) {
    Get.snackbar(
      'Edit Question',
      'Editing Question ${question.numberString}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onDeleteQuestion(String questionId) {
    final current = quizData.value;
    if (current == null) return;

    final updated = current.questions.where((q) => q.id != questionId).toList();
    quizData.value = current.copyWith(questions: updated);

    Get.snackbar(
      'Deleted',
      'Question removed from quiz',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onAddQuestion() {
    final current = quizData.value;
    if (current == null) return;

    final nextNum = (current.questions.length + 1).toString().padLeft(2, '0');
    final newQuestion = QuizQuestion(
      id: 'q_${DateTime.now().millisecondsSinceEpoch}',
      numberString: nextNum,
      questionTypeLabel: 'Multiple Choice',
      type: QuizQuestionType.multipleChoice,
      questionText: 'New question description...',
      points: 10,
      options: [
        const QuizOption(
          id: 'new_opt_1',
          text: 'Option A',
          isCorrect: true,
          isSelected: true,
        ),
        const QuizOption(
          id: 'new_opt_2',
          text: 'Option B',
          isCorrect: false,
          isSelected: false,
        ),
      ],
    );

    quizData.value = current.copyWith(
      questions: [...current.questions, newQuestion],
    );

    Get.snackbar(
      'Add Question',
      'New question card added',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onSaveQuiz() {
    Get.snackbar(
      'Quiz Saved',
      'Quiz details and questions saved successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
  }

  void onMoreOptions() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share_rounded, color: Color(0xFF127FD2)),
              title: const Text('Share Quiz'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy_rounded, color: Color(0xFF127FD2)),
              title: const Text('Duplicate Quiz'),
              onTap: () {
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete_outline_rounded, color: Colors.red),
              title: const Text('Delete Quiz', style: TextStyle(color: Colors.red)),
              onTap: () {
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
