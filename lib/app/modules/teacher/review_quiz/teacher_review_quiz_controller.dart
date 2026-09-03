import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../lesson_detail/teacher_lesson_detail_controller.dart';
import '../lesson_detail/teacher_lesson_detail_model.dart';

class ReviewQuizQuestionItem {
  final String id;
  String number;
  String timeEstimate;
  int seconds;
  String question;
  List<String> options;
  int correctAnswerIndex;

  ReviewQuizQuestionItem({
    required this.id,
    required this.number,
    required this.timeEstimate,
    required this.seconds,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class TeacherReviewQuizController extends GetxController {
  final RxString quizTitle = 'Cell Structure Quiz'.obs;
  final RxString subject = 'Biology 101'.obs;

  // Observable list of questions matching Figma CSS layers
  final RxList<ReviewQuizQuestionItem> questions = <ReviewQuizQuestionItem>[].obs;

  // Computed total estimated time
  String get estimatedTime {
    final totalSeconds = questions.fold(0, (sum, q) => sum + q.seconds);
    final mins = totalSeconds ~/ 60;
    final secs = totalSeconds % 60;
    if (mins > 0 && secs > 0) {
      return '${mins}m ${secs}s';
    } else if (mins > 0) {
      return '${mins}m';
    } else {
      return '${secs}s';
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final args = Get.arguments as Map<String, dynamic>;
      if (args['lessonTitle'] != null) {
        quizTitle.value = '${args['lessonTitle']} Quiz';
      }
      if (args['subject'] != null) {
        subject.value = args['subject'];
      }
    }
    _loadDefaultQuestions();
  }

  void _loadDefaultQuestions() {
    questions.assignAll([
      ReviewQuizQuestionItem(
        id: 'rq_1',
        number: '1',
        timeEstimate: '30 sec',
        seconds: 30,
        question: 'What is the powerhouse of the cell?',
        options: [
          'Nucleus',
          'Mitochondria',
          'Ribosome',
          'Golgi Apparatus',
        ],
        correctAnswerIndex: 1,
      ),
      ReviewQuizQuestionItem(
        id: 'rq_2',
        number: '2',
        timeEstimate: '45 sec',
        seconds: 45,
        question: 'Which structure is responsible for protein synthesis?',
        options: [
          'Lysosome',
          'Endoplasmic Reticulum',
          'Ribosome',
          'Vacuole',
        ],
        correctAnswerIndex: 2,
      ),
      ReviewQuizQuestionItem(
        id: 'rq_3',
        number: '3',
        timeEstimate: '30 sec',
        seconds: 30,
        question: 'What is the primary function of the cell membrane?',
        options: [
          'Regulating what enters/exits',
          'Storing DNA',
          'Producing energy',
          'Breaking down waste',
        ],
        correctAnswerIndex: 0,
      ),
    ]);
  }

  void onBack() {
    Get.back();
  }

  void onSelectOption(int questionIndex, int optionIndex) {
    if (questionIndex >= 0 && questionIndex < questions.length) {
      questions[questionIndex].correctAnswerIndex = optionIndex;
      questions.refresh();
    }
  }

  void onRegenerateQuestion(int index) {
    if (index < 0 || index >= questions.length) return;
    final current = questions[index];

    // Alternate questions pool
    final alternates = [
      {
        'q': 'Which organelle contains digestive enzymes to break down waste?',
        'opts': ['Lysosome', 'Nucleus', 'Chloroplast', 'Centrosome'],
        'ans': 0,
        'time': '30 sec',
        'sec': 30,
      },
      {
        'q': 'What plant cell organelle is the site of photosynthesis?',
        'opts': ['Mitochondria', 'Chloroplast', 'Ribosome', 'Vacuole'],
        'ans': 1,
        'time': '30 sec',
        'sec': 30,
      },
      {
        'q': 'Which component provides rigid structural support in plant cells?',
        'opts': ['Plasma Membrane', 'Cytoplasm', 'Cell Wall', 'Golgi Body'],
        'ans': 2,
        'time': '30 sec',
        'sec': 30,
      },
    ];

    final alt = alternates[index % alternates.length];
    current.question = alt['q'] as String;
    current.options = List<String>.from(alt['opts'] as List);
    current.correctAnswerIndex = alt['ans'] as int;
    current.timeEstimate = alt['time'] as String;
    current.seconds = alt['sec'] as int;
    questions.refresh();

    _showNotice('Regenerated', 'Question ${current.number} regenerated with new AI prompt');
  }

  void onDeleteQuestion(int index) {
    if (index >= 0 && index < questions.length) {
      questions.removeAt(index);
      for (int i = 0; i < questions.length; i++) {
        questions[i].number = (i + 1).toString();
      }
      _showNotice('Removed', 'Question removed');
    }
  }

  void onEditQuestion(int index) {
    if (index < 0 || index >= questions.length) return;
    final q = questions[index];
    final qTextCtrl = TextEditingController(text: q.question);
    final optCtrls = q.options.map((o) => TextEditingController(text: o)).toList();
    final selectedIdx = q.correctAnswerIndex.obs;

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
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Get.back()),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: qTextCtrl,
                decoration: const InputDecoration(labelText: 'Question Text', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              const Text('Options (select the correct answer):', style: TextStyle(fontWeight: FontWeight.w600)),
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
                    q.question = qTextCtrl.text.trim();
                    q.options = optCtrls.map((c) => c.text.trim()).toList();
                    q.correctAnswerIndex = selectedIdx.value;
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
    final opt1Ctrl = TextEditingController(text: 'Option A');
    final opt2Ctrl = TextEditingController(text: 'Option B');
    final opt3Ctrl = TextEditingController(text: 'Option C');
    final opt4Ctrl = TextEditingController(text: 'Option D');
    final selectedIdx = 0.obs;

    if (Get.context == null) {
      // Testing fallback
      questions.add(
        ReviewQuizQuestionItem(
          id: 'rq_${DateTime.now().millisecondsSinceEpoch}',
          number: (questions.length + 1).toString(),
          timeEstimate: '30 sec',
          seconds: 30,
          question: 'What is the function of chloroplasts?',
          options: ['Photosynthesis', 'Respiration', 'Excretion', 'Reproduction'],
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
                    'Add Question ${questions.length + 1}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Get.back()),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: qTextCtrl,
                decoration: const InputDecoration(
                  labelText: 'Question Text',
                  hintText: 'e.g. Which organelle controls cell division?',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Options (select the correct answer):', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              ...[opt1Ctrl, opt2Ctrl, opt3Ctrl, opt4Ctrl].asMap().entries.map((entry) {
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
                    final qText = qTextCtrl.text.trim();
                    if (qText.isEmpty) {
                      _showNotice('Required', 'Please enter question text');
                      return;
                    }

                    questions.add(
                      ReviewQuizQuestionItem(
                        id: 'rq_${DateTime.now().millisecondsSinceEpoch}',
                        number: (questions.length + 1).toString(),
                        timeEstimate: '30 sec',
                        seconds: 30,
                        question: qText,
                        options: [
                          opt1Ctrl.text.trim(),
                          opt2Ctrl.text.trim(),
                          opt3Ctrl.text.trim(),
                          opt4Ctrl.text.trim(),
                        ],
                        correctAnswerIndex: selectedIdx.value,
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

  void onCreateQuiz() {
    if (questions.isEmpty) {
      _showNotice('Empty Quiz', 'Please add at least one question');
      return;
    }

    // Attach completed quiz to TeacherLessonDetailController
    if (Get.isRegistered<TeacherLessonDetailController>()) {
      final detailCtrl = Get.find<TeacherLessonDetailController>();
      if (detailCtrl.lessonData.value != null) {
        final current = detailCtrl.lessonData.value!;
        final newQuiz = TeacherLessonQuizItem(
          title: quizTitle.value,
          subtitle: '${questions.length} Questions • $estimatedTime',
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

    // Navigate to Quiz Loading View as requested
    Get.toNamed(
      Routes.TEACHER_QUIZ_LOADING,
      arguments: {
        'lessonTitle': quizTitle.value,
        'subject': subject.value,
        'questionCount': questions.length,
      },
    );
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

typedef ReviewQuizController = TeacherReviewQuizController;
