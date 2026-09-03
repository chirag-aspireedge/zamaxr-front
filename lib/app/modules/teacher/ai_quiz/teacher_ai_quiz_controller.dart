import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../lesson_detail/teacher_lesson_detail_controller.dart';
import '../lesson_detail/teacher_lesson_detail_model.dart';

class TeacherAiQuizController extends GetxController {
  // Form text controllers
  late final TextEditingController topicController;
  late final TextEditingController instructionsController;

  // Breadcrumb and topic metadata
  final RxString breadcrumbSubject = 'Biology 101'.obs;
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
      'label': 'Include historical context',
      'bgColor': Color(0xFF63787B),
      'textColor': Color(0xFFF6FEFF),
      'icon': Icons.history_edu_outlined,
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

  void onNext() {
    final topic = topicController.text.trim();
    if (topic.isEmpty) {
      _showNotice('Required', 'Please enter a source topic');
      return;
    }

    isGenerating.value = true;

    // Simulate AI generation or pass parameters to quiz preview/manual editor
    Future.delayed(const Duration(milliseconds: 300), () {
      isGenerating.value = false;

      // Update TeacherLessonDetailController if present
      if (Get.isRegistered<TeacherLessonDetailController>()) {
        final detailCtrl = Get.find<TeacherLessonDetailController>();
        if (detailCtrl.lessonData.value != null) {
          final current = detailCtrl.lessonData.value!;
          final newQuiz = TeacherLessonQuizItem(
            title: '$topic AI Assessment',
            subtitle: '${numberOfQuestions.value} Questions • ${difficulty.value}',
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
        'Quiz Generated',
        'Generated ${numberOfQuestions.value} questions on "$topic"!',
        bgColor: const Color(0xFF127FD2),
      );

      // Navigate to Review Quiz screen as specified
      Get.toNamed(
        Routes.TEACHER_REVIEW_QUIZ,
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

typedef AiQuizController = TeacherAiQuizController;
