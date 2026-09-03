import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/ai_quiz/teacher_ai_quiz_controller.dart';
import 'package:zama_xr/app/modules/teacher/ai_quiz/teacher_ai_quiz_view.dart';
import 'package:zama_xr/app/modules/teacher/lesson_detail/teacher_lesson_detail_controller.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TeacherAiQuizView renders full AI Quiz Generator screen layout',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: TeacherAiQuizView(),
      ),
    );

    await tester.pumpAndSettle();

    // Breadcrumbs & Heading
    expect(find.text('Biology 101'), findsOneWidget);
    expect(find.text('New Quiz'), findsOneWidget);
    expect(find.text('AI Quiz Generator'), findsOneWidget);

    // Section 1: SOURCE TOPIC
    expect(find.text('SOURCE TOPIC'), findsOneWidget);
    expect(find.text('Human Cell Structure'), findsOneWidget);

    // Section 2: AI INSTRUCTIONS
    expect(find.text('AI INSTRUCTIONS'), findsOneWidget);

    // Suggestion Chips
    expect(find.text('Focus on concepts'), findsOneWidget);
    expect(find.text('Include historical context'), findsOneWidget);
    expect(find.text('Definition matching'), findsOneWidget);

    // Section 3: Number of Questions
    expect(find.text('Number of Questions'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('10'), findsOneWidget);
    expect(find.text('15'), findsOneWidget);
    expect(find.text('20'), findsOneWidget);

    // Section 4: Question Type
    expect(find.text('Question Type'), findsOneWidget);
    expect(find.text('Multiple Choice'), findsOneWidget);
    expect(find.text('True / False'), findsOneWidget);
    expect(find.text('Mixed'), findsOneWidget);

    // Section 5: Difficulty & Time / Q
    expect(find.text('Difficulty'), findsOneWidget);
    expect(find.text('Medium'), findsOneWidget);
    expect(find.text('Time / Q'), findsOneWidget);
    expect(find.text('30s'), findsOneWidget);

    // Section 6: XR READY banner
    expect(find.text('XR READY'), findsOneWidget);
    expect(find.text('Spatial Assets Linked'), findsOneWidget);

    // Section 7: Next button
    expect(find.text('Next'), findsOneWidget);
  });

  testWidgets('TeacherAiQuizController updates options, chips, and triggers generation',
      (WidgetTester tester) async {
    final ctrl = Get.find<TeacherAiQuizController>();
    final detailCtrl = Get.find<TeacherLessonDetailController>();

    // Test suggestion chips
    expect(ctrl.instructionsController.text, '');
    ctrl.onSelectSuggestion('Focus on concepts');
    expect(ctrl.instructionsController.text, 'Focus on concepts');

    // Test question count selection
    expect(ctrl.numberOfQuestions.value, 10);
    ctrl.onSelectNumberOfQuestions(15);
    expect(ctrl.numberOfQuestions.value, 15);

    // Test question type selection
    expect(ctrl.questionType.value, 'Multiple Choice');
    ctrl.onSelectQuestionType('True / False');
    expect(ctrl.questionType.value, 'True / False');

    // Test difficulty selection
    expect(ctrl.difficulty.value, 'Medium');
    ctrl.onSelectDifficulty('Hard');
    expect(ctrl.difficulty.value, 'Hard');

    // Test time limit selection
    expect(ctrl.timePerQuestion.value, '30s');
    ctrl.onSelectTime('45s');
    expect(ctrl.timePerQuestion.value, '45s');

    // Test Next action
    ctrl.onNext();
    expect(ctrl.isGenerating.value, true);

    await tester.pump(const Duration(milliseconds: 350));
    expect(ctrl.isGenerating.value, false);

    expect(detailCtrl.lessonData.value?.quiz != null, true);
    expect(detailCtrl.lessonData.value?.quiz?.title.contains('Human Cell Structure'), true);
  });
}
