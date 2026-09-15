import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class StudentQuizSummaryController extends GetxController {
  final score = 8.obs;
  final totalQuestions = 10.obs;
  final correctCount = 8.obs;
  final wrongCount = 2.obs;
  final unansweredCount = 0.obs;
  final status = 'Completed'.obs;

  int get percentage => ((score.value / totalQuestions.value) * 100).round();
  double get progressRatio => score.value / totalQuestions.value;

  @override
  void onInit() {
    super.onInit();
    // Accept arguments if passed from quiz
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      if (args['score'] != null) score.value = args['score'];
      if (args['total'] != null) totalQuestions.value = args['total'];
      if (args['correct'] != null) correctCount.value = args['correct'];
      if (args['wrong'] != null) wrongCount.value = args['wrong'];
      if (args['unanswered'] != null) unansweredCount.value = args['unanswered'];
    }
  }

  void onContinueLearning() {
    // Navigate back to lesson detail or student dashboard
    if (Get.previousRoute.isNotEmpty) {
      Get.until((route) =>
          route.settings.name == Routes.STUDENT_LESSON_DETAIL ||
          route.settings.name == Routes.STUDENT_DASHBOARD ||
          route.isFirst);
    } else {
      Get.offAllNamed(Routes.STUDENT_DASHBOARD);
    }
  }

  void onBackTap() {
    Get.back();
  }
}
