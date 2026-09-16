import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ParentAiQuizController extends GetxController {
  // Form text controllers
  late final TextEditingController topicController;
  late final TextEditingController instructionsController;

  // Breadcrumb and topic metadata
  final RxString breadcrumbSubject = 'Science Grade 8'.obs;
  final RxString breadcrumbQuiz = 'New Quiz'.obs;

  // Configuration options
  final RxInt numberOfQuestions = 10.obs;
  final List<int> questionCountOptions = const [5, 10, 15, 20];

  final RxString questionType = 'Multiple Choice'.obs;
  final List<String> questionTypeOptions = const ['Multiple Choice', 'True / False', 'Mixed'];

  final RxString difficulty = 'Medium'.obs;
  final List<String> difficultyOptions = const ['Easy', 'Medium', 'Hard'];

  final RxString timePerQuestion = '30s'.obs;
  final List<String> timeOptions = const ['15s', '30s', '45s', '60s'];

  // Suggestion chips
  final List<Map<String, dynamic>> suggestionChips = const [
    {
      'label': 'Focus on concepts',
      'bgColor': Color(0xFFE0F6FF),
      'textColor': Color(0xFF445D80),
      'icon': Icons.psychology_outlined,
      'iconColor': Color(0xFF445D80),
    },
    {
      'label': 'Include real-world examples',
      'bgColor': Color(0xFF63787B),
      'textColor': Color(0xFFF6FEFF),
      'icon': Icons.lightbulb_outline,
      'iconColor': Color(0xFFF6FEFF),
    },
    {
      'label': 'Definition matching',
      'bgColor': Color(0xFFE1E3E4),
      'textColor': Color(0xFF414754),
      'icon': Icons.menu_book_outlined,
      'iconColor': Color(0xFF414754),
    },
  ];

  final RxBool isGenerating = false.obs;

  @override
  void onInit() {
    super.onInit();
    topicController = TextEditingController(text: 'Human Cell Structure');
    instructionsController = TextEditingController();

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final args = Get.arguments as Map<String, dynamic>;
      if (args['subject'] != null) {
        breadcrumbSubject.value = args['subject'];
      }
      if (args['lessonTitle'] != null) {
        topicController.text = args['lessonTitle'];
      }
    }
  }

  @override
  void onClose() {
    topicController.dispose();
    instructionsController.dispose();
    super.onClose();
  }

  void onBack() {
    Get.back();
  }

  void onSelectSuggestion(String suggestion) {
    if (instructionsController.text.trim().isEmpty) {
      instructionsController.text = suggestion;
    } else if (!instructionsController.text.contains(suggestion)) {
      instructionsController.text = '${instructionsController.text.trim()}. $suggestion';
    }
  }

  void onSelectNumberOfQuestions(int count) {
    numberOfQuestions.value = count;
  }

  void onSelectQuestionType(String type) {
    questionType.value = type;
  }

  void onSelectDifficulty(String diff) {
    difficulty.value = diff;
  }

  void onSelectTime(String time) {
    timePerQuestion.value = time;
  }

  void onSelectTimePerQuestion(String time) {
    timePerQuestion.value = time;
  }

  void onNext() {
    onGenerateQuiz();
  }

  void onGenerateQuiz() {
    final topic = topicController.text.trim();
    if (topic.isEmpty) {
      _showNotice('Required', 'Please enter a source topic');
      return;
    }

    isGenerating.value = true;

    // Simulate AI Generation delay then navigate to Review Quiz screen
    Future.delayed(const Duration(milliseconds: 1000), () {
      isGenerating.value = false;

      _showNotice(
        'Quiz Generated',
        'Generated ${numberOfQuestions.value} questions on "$topic"!',
        bgColor: const Color(0xFF127FD2),
      );

      // Navigate to Parent Review Quiz screen
      Get.toNamed(
        Routes.PARENT_REVIEW_QUIZ,
        arguments: {
          'lessonTitle': topic,
          'subject': breadcrumbSubject.value,
        },
      );
    });
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
}
