import 'dart:async';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import 'student_quiz_model.dart';

class StudentQuizController extends GetxController {
  final quizTitle = 'Cell Structure'.obs;

  // Questions List (10 questions matching Figma flow)
  final questions = <StudentQuizQuestion>[
    const StudentQuizQuestion(
      id: 'q1',
      questionText: 'Which part of the cell controls the activities of the cell?',
      options: ['Cell membrane', 'Nucleus', 'Cytoplasm', 'Mitochondria'],
      correctOptionIndex: 1,
    ),
    const StudentQuizQuestion(
      id: 'q2',
      questionText: 'Which organelle is known as the powerhouse of the cell?',
      options: ['Ribosome', 'Golgi apparatus', 'Mitochondria', 'Vacuole'],
      correctOptionIndex: 2,
    ),
    const StudentQuizQuestion(
      id: 'q3',
      questionText: 'What structure regulates what enters and exits the cell?',
      options: ['Cell wall', 'Cell membrane', 'Nucleolus', 'Lysosome'],
      correctOptionIndex: 1,
    ),
    const StudentQuizQuestion(
      id: 'q4',
      questionText: 'Which organelle is responsible for photosynthesis in plant cells?',
      options: ['Chloroplast', 'Mitochondria', 'Endoplasmic reticulum', 'Centriole'],
      correctOptionIndex: 0,
    ),
    const StudentQuizQuestion(
      id: 'q5',
      questionText: 'Where are proteins synthesized within the cell?',
      options: ['Lysosomes', 'Ribosomes', 'Golgi body', 'Vacuole'],
      correctOptionIndex: 1,
    ),
    const StudentQuizQuestion(
      id: 'q6',
      questionText: 'What gel-like substance fills the interior of the cell?',
      options: ['Cytoplasm', 'Plasma', 'Nucleoplasm', 'Chlorophyll'],
      correctOptionIndex: 0,
    ),
    const StudentQuizQuestion(
      id: 'q7',
      questionText: 'Which organelle contains digestive enzymes to break down waste?',
      options: ['Peroxisome', 'Lysosome', 'Centrosome', 'Ribosome'],
      correctOptionIndex: 1,
    ),
    const StudentQuizQuestion(
      id: 'q8',
      questionText: 'Which cellular structure packages and distributes proteins?',
      options: ['Golgi apparatus', 'Mitochondria', 'Endoplasmic reticulum', 'Nucleus'],
      correctOptionIndex: 0,
    ),
    const StudentQuizQuestion(
      id: 'q9',
      questionText: 'Which structure is found in plant cells but NOT in animal cells?',
      options: ['Cell wall', 'Cell membrane', 'Mitochondria', 'Ribosome'],
      correctOptionIndex: 0,
    ),
    const StudentQuizQuestion(
      id: 'q10',
      questionText: 'What organelle stores water, ions, and nutrients in plant cells?',
      options: ['Centriole', 'Large central vacuole', 'Lysosome', 'Ribosome'],
      correctOptionIndex: 1,
    ),
  ].obs;

  final currentQuestionIndex = 0.obs;
  final selectedOptionIndex = 1.obs; // Preselected Option B ("Nucleus") matching Figma
  final remainingSeconds = 30.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  void _startTimer() {
    _timer?.cancel();
    remainingSeconds.value = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  String get formattedTimer {
    final secs = remainingSeconds.value;
    final sStr = secs < 10 ? '0$secs' : '$secs';
    return '00:$sStr';
  }

  int get totalQuestions => questions.length;

  bool get isLastQuestion => currentQuestionIndex.value == totalQuestions - 1;

  double get progress => (currentQuestionIndex.value + 1) / totalQuestions;

  String get progressText => 'QUESTION ${currentQuestionIndex.value + 1} OF $totalQuestions';

  StudentQuizQuestion get currentQuestion {
    if (currentQuestionIndex.value < questions.length) {
      return questions[currentQuestionIndex.value];
    }
    return questions.first;
  }

  void selectOption(int index) {
    selectedOptionIndex.value = index;
  }

  void nextQuestion() {
    if (isLastQuestion) {
      // Navigate to Quiz Summary screen
      Get.toNamed(
        Routes.STUDENT_QUIZ_SUMMARY,
        arguments: {
          'score': 8,
          'total': totalQuestions,
          'correct': 8,
          'wrong': 2,
          'unanswered': 0,
        },
      );
    } else {
      currentQuestionIndex.value++;
      if (currentQuestionIndex.value < questions.length) {
        selectedOptionIndex.value = -1; // Reset selection for next question
      }
      _startTimer();
    }
  }

  void onBackTap() {
    Get.back();
  }
}
