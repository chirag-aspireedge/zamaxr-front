import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/create_quiz/teacher_create_quiz_controller.dart';
import 'package:zama_xr/app/modules/teacher/create_quiz/teacher_create_quiz_view.dart';
import 'package:zama_xr/app/modules/teacher/lesson_detail/teacher_lesson_detail_controller.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TeacherCreateQuizView renders heading, selection cards, and assessment settings',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: TeacherCreateQuizView(),
      ),
    );

    await tester.pumpAndSettle();

    // Top Heading
    expect(find.text('How would you like to\ncreate your quiz?'), findsOneWidget);

    // Two Mode Cards
    expect(find.text('Manual Creation'), findsWidgets);
    expect(find.text('Create and edit questions yourself'), findsOneWidget);
    expect(find.text('Create with AI'), findsOneWidget);
    expect(find.text('Let AI generate quiz questions for you'), findsOneWidget);

    // Initial Question Count Pill
    expect(find.text('0 Questions'), findsOneWidget);

    // Start Building Empty State
    expect(find.text('Start Building'), findsOneWidget);
    expect(
      find.text('Add your first question manually to begin creating this assessment.'),
      findsOneWidget,
    );
    expect(find.text('ADD QUESTION'), findsOneWidget);

    // Assessment Settings
    expect(find.text('ASSESSMENT SETTINGS'), findsOneWidget);
    expect(find.text('30 Minutes'), findsOneWidget);
    expect(find.text('Biology 101 Roster'), findsOneWidget);
    expect(find.text('No 3D Models Linked'), findsOneWidget);

    // Save Draft Button
    expect(find.text('Save Draft'), findsOneWidget);
  });

  testWidgets('TeacherCreateQuizController handles manual add, AI generation, and save draft',
      (WidgetTester tester) async {
    final quizCtrl = Get.find<TeacherCreateQuizController>();
    final detailCtrl = Get.find<TeacherLessonDetailController>();

    expect(quizCtrl.selectedMode.value, QuizCreationMode.manual);
    expect(quizCtrl.questions.isEmpty, true);

    // Switch mode to AI
    quizCtrl.setMode(QuizCreationMode.ai);
    expect(quizCtrl.selectedMode.value, QuizCreationMode.ai);

    // Add manual question
    quizCtrl.onAddQuestion();
    expect(quizCtrl.questions.length, 1);
    expect(quizCtrl.questions.first.question.contains('control center'), true);

    // Test duration update
    quizCtrl.duration.value = '45 Minutes';
    expect(quizCtrl.duration.value, '45 Minutes');

    // Save draft
    quizCtrl.onSaveDraft();
    expect(detailCtrl.lessonData.value?.quiz != null, true);
    expect(detailCtrl.lessonData.value?.quiz?.title, 'Cell Structure Assessment');
    expect(detailCtrl.lessonData.value?.quiz?.subtitle.contains('45 Minutes'), true);
  });
}
