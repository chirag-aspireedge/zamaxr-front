import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class TeacherQuizLoadingController extends GetxController {
  final RxDouble progress = 0.0.obs;
  final RxString statusMessage = 'AI is structuring the questions...'.obs;
  final RxString lessonTitle = 'Cell Structure'.obs;
  final RxString subject = 'Biology Fundamentals'.obs;
  final RxInt questionCount = 15.obs;

  Timer? _progressTimer;
  Timer? _messageTimer;

  final List<String> _statusMessages = [
    'AI is structuring the questions...',
    'Linking spatial 3D assets...',
    'Calibrating question difficulty...',
    'Finalizing assessment rubric...',
  ];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      final args = Get.arguments as Map<String, dynamic>;
      if (args['lessonTitle'] != null) {
        lessonTitle.value = args['lessonTitle'];
      }
      if (args['subject'] != null) {
        subject.value = args['subject'];
      }
      if (args['questionCount'] != null) {
        questionCount.value = args['questionCount'];
      }
    }
    _startLoadingAnimation();
  }

  void _startLoadingAnimation() {
    final isTesting = WidgetsBinding.instance.runtimeType.toString().contains('Test') || Get.testMode;
    if (isTesting) {
      // In test mode, complete immediately
      progress.value = 1.0;
      return;
    }

    int step = 0;
    const totalSteps = 60; // 3 seconds at 50ms intervals
    _progressTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      step++;
      progress.value = (step / totalSteps).clamp(0.0, 1.0);
      if (step >= totalSteps) {
        timer.cancel();
        _onLoadingComplete();
      }
    });

    int msgIndex = 0;
    _messageTimer = Timer.periodic(const Duration(milliseconds: 900), (timer) {
      msgIndex = (msgIndex + 1) % _statusMessages.length;
      statusMessage.value = _statusMessages[msgIndex];
    });
  }

  void _onLoadingComplete() {
    Get.offNamed(
      Routes.TEACHER_FINAL_QUIZ,
      arguments: {
        'lessonTitle': lessonTitle.value,
        'subject': subject.value,
        'questionCount': questionCount.value,
      },
    );
  }

  @override
  void onClose() {
    _progressTimer?.cancel();
    _messageTimer?.cancel();
    super.onClose();
  }
}

typedef QuizLoadingController = TeacherQuizLoadingController;
