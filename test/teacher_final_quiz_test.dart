import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/modules/teacher/final_quiz/teacher_final_quiz_controller.dart';
import 'package:zama_xr/app/modules/teacher/final_quiz/teacher_final_quiz_view.dart';
import 'package:zama_xr/app/modules/teacher/lesson_detail/teacher_lesson_detail_controller.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TeacherFinalQuizView renders summary, class button, lesson list and assign button', (WidgetTester tester) async {
    Get.put(TeacherFinalQuizController());
    Get.put(TeacherLessonDetailController());

    await tester.pumpWidget(
      GetMaterialApp(
        home: const TeacherFinalQuizView(),
      ),
    );
    await tester.pump();

    // 1. Check summary card
    expect(find.text('Quiz Ready'), findsOneWidget);
    expect(find.text('Biology Fundamentals'), findsWidgets);
    expect(find.text('Questions'), findsOneWidget);
    expect(find.text('15'), findsOneWidget);
    expect(find.text('Duration'), findsOneWidget);
    expect(find.text('~10m'), findsOneWidget);

    // 2. Check class button
    expect(find.text('Class 8-A'), findsOneWidget);

    // 3. Check lesson options
    expect(find.text('Chapter 1 — Cell Structure'), findsOneWidget);
    expect(find.text('Chapter 2 — Cell Division'), findsOneWidget);
    expect(find.text('Chapter 1 — Motion'), findsOneWidget);

    // 4. Check specific students and assign quiz buttons
    expect(find.text('Select Specific Students'), findsOneWidget);
    expect(find.text('Assign Quiz'), findsOneWidget);
  });

  test('TeacherFinalQuizController handles lesson selection, class change, students selection and assign', () {
    final detailCtrl = Get.put(TeacherLessonDetailController());
    final ctrl = Get.put(TeacherFinalQuizController());

    expect(ctrl.selectedLessonIndex.value, 0);
    ctrl.onSelectLesson(1);
    expect(ctrl.selectedLessonIndex.value, 1);

    ctrl.onSelectClass('Class 9-A');
    expect(ctrl.selectedClass.value, 'Class 9-A');

    ctrl.onSelectSpecificStudents();
    expect(ctrl.specificStudentsSelected.value, true);
    expect(ctrl.selectedStudents.isNotEmpty, true);

    ctrl.onAssignQuiz();
    expect(detailCtrl.lessonData.value?.quiz != null, true);
    expect(detailCtrl.lessonData.value?.quiz?.isAttached, true);
  });

  testWidgets('TeacherFinalQuizView does not overflow on narrow screen with scaled text', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    final ctrl = Get.put(TeacherFinalQuizController());
    ctrl.questionCount.value = 3;
    Get.put(TeacherLessonDetailController());

    await tester.pumpWidget(
      GetMaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(
            size: Size(360, 800),
            textScaler: TextScaler.linear(1.1),
          ),
          child: const TeacherFinalQuizView(),
        ),
      ),
    );
    await tester.pump();

    // Verification: No exception thrown, all widgets render cleanly without overflow
    expect(tester.takeException(), isNull);
    expect(find.text('Questions'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
  });
}
