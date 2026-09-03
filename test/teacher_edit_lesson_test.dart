import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/edit_lesson/teacher_edit_lesson_controller.dart';
import 'package:zama_xr/app/modules/teacher/edit_lesson/teacher_edit_lesson_view.dart';
import 'package:zama_xr/app/modules/teacher/lesson_detail/teacher_lesson_detail_controller.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('EditLessonView renders with prefilled data and save button',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: EditLessonView(),
      ),
    );

    await tester.pumpAndSettle();

    // Top Bar title
    expect(find.text('Edit Lesson'), findsOneWidget);

    // Prefilled title and description
    expect(find.text('Cell Structure'), findsOneWidget);
    expect(find.text('Lesson Information'), findsOneWidget);
    expect(find.text('Class 8-A'), findsOneWidget);
    expect(find.text('Biology'), findsOneWidget);

    // Lesson Notes
    expect(find.text('Lesson Notes'), findsOneWidget);

    // Add Content
    expect(find.text('Add Content'), findsOneWidget);
    expect(find.text('Documents'), findsOneWidget);
    expect(find.text('Images'), findsOneWidget);
    expect(find.text('Audio'), findsOneWidget);
    expect(find.text('Assessments'), findsOneWidget);

    // Video Section
    expect(find.text('Video URL'), findsOneWidget);
    expect(find.text('Uploaded Video'), findsOneWidget);
    expect(find.text('REMOVE'), findsOneWidget);

    // Visibility
    expect(find.text('Visible to Students'), findsOneWidget);

    // Save Changes Button
    expect(find.text('Save Changes'), findsOneWidget);
  });

  testWidgets('EditLessonController updates lesson and toggles video',
      (WidgetTester tester) async {
    final editCtrl = Get.find<EditLessonController>();
    final detailCtrl = Get.find<TeacherLessonDetailController>();

    expect(editCtrl.titleController.text, 'Cell Structure');

    // Edit fields
    editCtrl.titleController.text = 'Cell Biology & Mitosis';
    editCtrl.selectedSubject.value = 'Biology';
    editCtrl.selectedClass.value = 'Class 8-A';

    editCtrl.onSaveLesson();

    expect(detailCtrl.lessonData.value?.title, 'Cell Biology & Mitosis');
  });
}
