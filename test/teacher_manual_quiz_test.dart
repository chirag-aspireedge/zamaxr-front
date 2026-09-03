import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/lesson_detail/teacher_lesson_detail_controller.dart';
import 'package:zama_xr/app/modules/teacher/manual_quiz/teacher_manual_quiz_controller.dart';
import 'package:zama_xr/app/modules/teacher/manual_quiz/teacher_manual_quiz_view.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TeacherManualQuizView renders full manual quiz form, questions and actions',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: TeacherManualQuizView(),
      ),
    );

    await tester.pumpAndSettle();

    // Top Header & Subtitle
    expect(find.text('Create Quiz'), findsOneWidget);
    expect(find.text('Cell Structure'), findsOneWidget);

    // Category Header
    expect(find.text('CELL STRUCTURE QUIZ'), findsOneWidget);
    expect(find.text('Biology Fundamentals • Chapter 1'), findsOneWidget);

    // Form Field Labels
    expect(find.text('Quiz Title'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Passing Criteria (%)'), findsOneWidget);

    // Initial pre-filled input values
    expect(find.text('Cell Structure Masterclass'), findsOneWidget);
    expect(find.text('A comprehensive quiz to test knowledge on basic cell'), findsOneWidget);
    expect(find.text('70'), findsOneWidget);

    // Questions header row
    expect(find.text('2 Questions'), findsOneWidget);
    expect(find.text('Total: 20 pts'), findsOneWidget);

    // Question 1 elements
    expect(find.text('01'), findsOneWidget);
    expect(find.text('Multiple Choice'), findsOneWidget);
    expect(find.text('What is the main function of the nucleus?'), findsOneWidget);
    expect(find.text('Controls cell activities'), findsOneWidget);
    expect(find.text('Produces energy'), findsOneWidget);
    expect(find.text('Stores water'), findsOneWidget);

    // Question 2 elements
    expect(find.text('02'), findsOneWidget);
    expect(find.text('True / False'), findsOneWidget);
    expect(
      find.text('Mitochondria are known as the powerhouse of the cell.'),
      findsOneWidget,
    );

    // Buttons
    expect(find.text('+ Add Question'), findsOneWidget);
    expect(find.text('Save Quiz'), findsOneWidget);
  });

  testWidgets('TeacherManualQuizController handles option selection, deletion, add, and save',
      (WidgetTester tester) async {
    final quizCtrl = Get.find<TeacherManualQuizController>();
    final detailCtrl = Get.find<TeacherLessonDetailController>();

    expect(quizCtrl.questions.length, 2);
    expect(quizCtrl.questions[0].selectedCorrectIndex, 0);

    // Select second option for question 1
    quizCtrl.onSelectOption(0, 1);
    expect(quizCtrl.questions[0].selectedCorrectIndex, 1);

    // Add a new question
    quizCtrl.onAddQuestion();
    expect(quizCtrl.questions.length, 3);
    expect(quizCtrl.questions[2].number, '03');
    expect(quizCtrl.totalPoints, 30);

    // Delete question 2
    quizCtrl.onDeleteQuestion(1);
    expect(quizCtrl.questions.length, 2);
    expect(quizCtrl.questions[1].number, '02');

    // Save Quiz
    quizCtrl.titleController.text = 'Biology Advanced Cell Quiz';
    quizCtrl.passingCriteriaController.text = '75';
    quizCtrl.onSaveQuiz();

    expect(detailCtrl.lessonData.value?.quiz != null, true);
    expect(detailCtrl.lessonData.value?.quiz?.title, 'Biology Advanced Cell Quiz');
    expect(detailCtrl.lessonData.value?.quiz?.subtitle.contains('75% Passing'), true);
  });
}
