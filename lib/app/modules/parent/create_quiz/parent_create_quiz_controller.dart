import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

enum QuizCreationMode { manual, ai }

class QuizQuestionItem {
  final String id;
  String question;
  List<String> options;
  int correctAnswerIndex;
  int points;

  QuizQuestionItem({
    required this.id,
    required this.question,
    required this.options,
    this.correctAnswerIndex = 0,
    this.points = 10,
  });
}

class ParentCreateQuizController extends GetxController {
  final Rx<QuizCreationMode> selectedMode = QuizCreationMode.manual.obs;

  // Questions List
  final RxList<QuizQuestionItem> questions = <QuizQuestionItem>[].obs;

  // Settings
  final RxString duration = '30 Minutes'.obs;
  final RxString roster = 'Daniel (Grade 8)'.obs;
  final RxString linked3DModels = 'No 3D Models Linked'.obs;
  final RxString quizTitle = 'Cell Structure Assessment'.obs;

  // AI Generation State
  final isGeneratingAi = false.obs;
  final aiPromptController = TextEditingController();

  final availableDurations = const ['15 Minutes', '30 Minutes', '45 Minutes', '60 Minutes'];
  final availableRosters = const [
    'Daniel (Grade 8)',
    'Tony (Grade 6)',
    'All Children',
  ];
  final available3DModels = const [
    'No 3D Models Linked',
    'Animal Cell 3D Organelles',
    'Plant Cell Chloroplast Model',
    'Mitochondria Ultrastructure',
  ];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final args = Get.arguments as Map<String, dynamic>;
      if (args['child'] != null) {
        roster.value = args['child'];
      }
      if (args['lessonTitle'] != null) {
        quizTitle.value = '${args['lessonTitle']} Assessment';
      }
    }
  }

  @override
  void onClose() {
    aiPromptController.dispose();
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

  void setMode(QuizCreationMode mode) {
    selectedMode.value = mode;
  }

  void onManualQuizSelected() {
    selectedMode.value = QuizCreationMode.manual;
    if (Get.context != null) {
      Get.toNamed(
        Routes.PARENT_MANUAL_QUIZ,
        arguments: {
          'lessonTitle': quizTitle.value.replaceAll(' Assessment', ''),
          'subject': 'Science',
        },
      );
    }
  }

  void onAiQuizSelected() {
    selectedMode.value = QuizCreationMode.ai;
    if (Get.context != null) {
      Get.toNamed(
        Routes.PARENT_AI_QUIZ,
        arguments: {
          'lessonTitle': quizTitle.value.replaceAll(' Assessment', ''),
          'subject': 'Science',
        },
      );
    }
  }

  void onAddQuestion() {
    if (Get.context != null) {
      Get.toNamed(
        Routes.PARENT_MANUAL_QUIZ,
        arguments: {
          'lessonTitle': quizTitle.value.replaceAll(' Assessment', ''),
          'subject': 'Science',
        },
      );
      return;
    }

    questions.add(
      QuizQuestionItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        question: 'Which organelle is known as the control center of the cell?',
        options: ['Nucleus', 'Mitochondria', 'Ribosome', 'Cell Wall'],
        correctAnswerIndex: 0,
      ),
    );
  }

  void onGenerateWithAi() {
    isGeneratingAi.value = true;
    Future.delayed(const Duration(milliseconds: 1200), () {
      questions.addAll([
        QuizQuestionItem(
          id: 'ai_1',
          question: 'What is the primary function of the cell membrane?',
          options: [
            'Regulation of substances entering and exiting',
            'Energy production through respiration',
            'Protein synthesis',
            'DNA storage and replication',
          ],
          correctAnswerIndex: 0,
        ),
        QuizQuestionItem(
          id: 'ai_2',
          question: 'Which organelle contains digestive enzymes to break down waste?',
          options: ['Lysosome', 'Ribosome', 'Golgi apparatus', 'Vacuole'],
          correctAnswerIndex: 0,
        ),
        QuizQuestionItem(
          id: 'ai_3',
          question: 'Which structure is present in plant cells but absent in animal cells?',
          options: ['Cell Wall', 'Mitochondria', 'Endoplasmic Reticulum', 'Nucleus'],
          correctAnswerIndex: 0,
        ),
      ]);
      isGeneratingAi.value = false;
      _showNotice('AI Generated', '3 questions generated successfully!', bgColor: const Color(0xFF127FD2));
    });
  }

  void onRemoveQuestion(int index) {
    if (index >= 0 && index < questions.length) {
      questions.removeAt(index);
    }
  }

  void onEditSettings() {
    onSelectDuration();
  }

  void onSelectDuration() {
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
              'Select Quiz Duration',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF191C1D)),
            ),
            const SizedBox(height: 12),
            ...availableDurations.map(
              (d) => ListTile(
                title: Text(d),
                trailing: duration.value == d
                    ? const Icon(Icons.check_circle, color: Color(0xFF127FD2))
                    : null,
                onTap: () {
                  duration.value = d;
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelectRoster() {
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
              'Assign To',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF191C1D)),
            ),
            const SizedBox(height: 12),
            ...availableRosters.map(
              (r) => ListTile(
                title: Text(r),
                trailing: roster.value == r
                    ? const Icon(Icons.check_circle, color: Color(0xFF127FD2))
                    : null,
                onTap: () {
                  roster.value = r;
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSelect3DModel() {
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
              'Link 3D Model',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF191C1D)),
            ),
            const SizedBox(height: 12),
            ...available3DModels.map(
              (m) => ListTile(
                title: Text(m),
                trailing: linked3DModels.value == m
                    ? const Icon(Icons.check_circle, color: Color(0xFF127FD2))
                    : null,
                onTap: () {
                  linked3DModels.value = m;
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSaveDraft() {
    _showNotice(
      'Draft Saved',
      'Quiz assessment "${quizTitle.value}" was saved to drafts!',
      bgColor: const Color(0xFF127FD2),
    );

    Get.back();
  }
}
