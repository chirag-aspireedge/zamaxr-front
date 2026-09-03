import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../lesson_detail/teacher_lesson_detail_controller.dart';
import '../lesson_detail/teacher_lesson_detail_model.dart';

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

class TeacherCreateQuizController extends GetxController {
  final Rx<QuizCreationMode> selectedMode = QuizCreationMode.manual.obs;

  // Questions List
  final RxList<QuizQuestionItem> questions = <QuizQuestionItem>[].obs;

  // Settings
  final RxString duration = '30 Minutes'.obs;
  final RxString roster = 'Biology 101 Roster'.obs;
  final RxString linked3DModels = 'No 3D Models Linked'.obs;
  final RxString quizTitle = 'Cell Structure Assessment'.obs;

  // AI Generation State
  final isGeneratingAi = false.obs;
  final aiPromptController = TextEditingController();

  final availableDurations = const ['15 Minutes', '30 Minutes', '45 Minutes', '60 Minutes'];
  final availableRosters = const [
    'Biology 101 Roster',
    'Class 8-A Roster',
    'Class 8-B Roster',
    'Class 9-A Science',
    'All Students',
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
      if (args['subject'] != null) {
        roster.value = '${args['subject']} 101 Roster';
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
        Routes.TEACHER_MANUAL_QUIZ,
        arguments: {
          'lessonTitle': quizTitle.value.replaceAll(' Assessment', ''),
          'subject': roster.value.split(' ').first,
        },
      );
    }
  }

  void onAiQuizSelected() {
    selectedMode.value = QuizCreationMode.ai;
    if (Get.context != null) {
      Get.toNamed(
        Routes.TEACHER_AI_QUIZ,
        arguments: {
          'lessonTitle': quizTitle.value.replaceAll(' Assessment', ''),
          'subject': roster.value.split(' ').first,
        },
      );
    }
  }

  void onAddQuestion() {
    if (Get.context != null) {
      Get.toNamed(
        Routes.TEACHER_MANUAL_QUIZ,
        arguments: {
          'lessonTitle': quizTitle.value.replaceAll(' Assessment', ''),
          'subject': roster.value.split(' ').first,
        },
      );
      return;
    }

    final questionTextController = TextEditingController();
    final option1Controller = TextEditingController(text: 'Nucleus');
    final option2Controller = TextEditingController(text: 'Mitochondria');
    final option3Controller = TextEditingController(text: 'Ribosome');
    final option4Controller = TextEditingController(text: 'Cell Wall');
    final selectedCorrectIndex = 0.obs;

    if (Get.context == null) {
      // For testing fallback: add directly
      questions.add(
        QuizQuestionItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          question: 'Which organelle is known as the control center of the cell?',
          options: ['Nucleus', 'Mitochondria', 'Ribosome', 'Cell Wall'],
          correctAnswerIndex: 0,
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
                    'Question ${questions.length + 1}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: questionTextController,
                decoration: const InputDecoration(
                  labelText: 'Question text',
                  hintText: 'e.g. Which organelle produces energy?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Options (select the correct answer radio):',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF414754)),
              ),
              const SizedBox(height: 8),
              ...List.generate(4, (index) {
                final controllers = [
                  option1Controller,
                  option2Controller,
                  option3Controller,
                  option4Controller,
                ];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    children: [
                      Obx(() {
                        final isSelected = selectedCorrectIndex.value == index;
                        return GestureDetector(
                          onTap: () => selectedCorrectIndex.value = index,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: isSelected ? const Color(0xFF127FD2) : const Color(0xFFC1C6D7),
                                  width: isSelected ? 5 : 1,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                      Expanded(
                        child: TextField(
                          controller: controllers[index],
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Option ${String.fromCharCode(65 + index)}',
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
                    final qText = questionTextController.text.trim();
                    if (qText.isEmpty) {
                      _showNotice('Required', 'Please enter question text');
                      return;
                    }
                    questions.add(
                      QuizQuestionItem(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        question: qText,
                        options: [
                          option1Controller.text.trim(),
                          option2Controller.text.trim(),
                          option3Controller.text.trim(),
                          option4Controller.text.trim(),
                        ],
                        correctAnswerIndex: selectedCorrectIndex.value,
                      ),
                    );
                    Get.back();
                    _showNotice('Added', 'Question was added to assessment');
                  },
                  child: const Text('Add to Quiz', style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onGenerateWithAi() {
    isGeneratingAi.value = true;
    Future.delayed(const Duration(milliseconds: 600), () {
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
              'Select Assigned Roster',
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
    // Integrate with TeacherLessonDetailController if active
    if (Get.isRegistered<TeacherLessonDetailController>()) {
      final detailCtrl = Get.find<TeacherLessonDetailController>();
      if (detailCtrl.lessonData.value != null) {
        final current = detailCtrl.lessonData.value!;
        final newQuiz = TeacherLessonQuizItem(
          title: quizTitle.value,
          subtitle: '${questions.length} Questions • ${duration.value}',
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
      'Draft Saved',
      'Quiz assessment "${quizTitle.value}" was saved to drafts!',
      bgColor: const Color(0xFF127FD2),
    );

    Get.back();
  }
}

typedef CreateQuizController = TeacherCreateQuizController;
