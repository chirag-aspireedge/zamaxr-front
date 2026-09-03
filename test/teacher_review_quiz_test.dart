import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/lesson_detail/teacher_lesson_detail_controller.dart';
import 'package:zama_xr/app/modules/teacher/review_quiz/teacher_review_quiz_controller.dart';
import 'package:zama_xr/app/modules/teacher/review_quiz/teacher_review_quiz_view.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TeacherReviewQuizView renders complete Review AI Quiz screen layout',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: TeacherReviewQuizView(),
      ),
    );

    await tester.pumpAndSettle();

    // 1. Heading and subtitle
    expect(find.text('Review AI Quiz'), findsOneWidget);
    expect(
      find.text('Review and adjust the AI-generated questions before sharing with your students.'),
      findsOneWidget,
    );

    // 2. Stats row
    expect(find.text('QUESTIONS'), findsOneWidget);
    expect(find.text('3'), findsNWidgets(2)); // Stats count "3" and Question card 3 number
    expect(find.text('EST. TIME'), findsOneWidget);
    expect(find.text('1m 45s'), findsOneWidget);

    // 3. Question 1
    expect(find.text('What is the powerhouse of the cell?'), findsOneWidget);
    expect(find.text('Nucleus'), findsOneWidget);
    expect(find.text('Mitochondria'), findsOneWidget);
    expect(find.text('Golgi Apparatus'), findsOneWidget);

    // 4. Question 2
    expect(find.text('Which structure is responsible for protein synthesis?'), findsOneWidget);
    expect(find.text('Endoplasmic Reticulum'), findsOneWidget);
    expect(find.text('Lysosome'), findsOneWidget);
    expect(find.text('Vacuole'), findsOneWidget);

    // 5. Question 3
    expect(find.text('What is the primary function of the cell membrane?'), findsOneWidget);
    expect(find.text('Regulating what enters/exits'), findsOneWidget);
    expect(find.text('Storing DNA'), findsOneWidget);
    expect(find.text('Producing energy'), findsOneWidget);
    expect(find.text('Breaking down waste'), findsOneWidget);

    // 6. Regenerate Question buttons (3 buttons for 3 questions)
    expect(find.text('Regenerate Question'), findsNWidgets(3));

    // 7. Add question button
    expect(find.text('ADD QUESTION'), findsOneWidget);

    // 8. Bottom button
    expect(find.text('Create Quiz'), findsOneWidget);
  });

  testWidgets('TeacherReviewQuizController handles option selection, regenerate, delete, add, and create quiz',
      (WidgetTester tester) async {
    final ctrl = Get.find<TeacherReviewQuizController>();
    final detailCtrl = Get.find<TeacherLessonDetailController>();

    expect(ctrl.questions.length, 3);
    expect(ctrl.estimatedTime, '1m 45s');

    // 1. Option selection
    expect(ctrl.questions[0].correctAnswerIndex, 1);
    ctrl.onSelectOption(0, 0); // select 'Nucleus'
    expect(ctrl.questions[0].correctAnswerIndex, 0);

    // 2. Regenerate Question 1
    final oldQ1 = ctrl.questions[0].question;
    ctrl.onRegenerateQuestion(0);
    expect(ctrl.questions[0].question != oldQ1, true);

    // 3. Add question
    ctrl.onAddQuestion();
    expect(ctrl.questions.length, 4);

    // 4. Delete question
    ctrl.onDeleteQuestion(3);
    expect(ctrl.questions.length, 3);

    // 5. Create quiz
    ctrl.onCreateQuiz();
    expect(detailCtrl.lessonData.value?.quiz != null, true);
    expect(detailCtrl.lessonData.value?.quiz?.isAttached, true);
  });
}
