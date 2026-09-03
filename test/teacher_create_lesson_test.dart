import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/create_lesson/teacher_create_lesson_controller.dart';
import 'package:zama_xr/app/modules/teacher/create_lesson/teacher_create_lesson_view.dart';
import 'package:zama_xr/app/modules/teacher/lessons/teacher_lessons_controller.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TeacherCreateLessonView renders all headers, inputs, 2x2 grid, and toggle',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: TeacherCreateLessonView(),
      ),
    );

    await tester.pumpAndSettle();

    // Top Bar
    expect(find.text('Create Lesson'), findsWidgets);

    // Section 1: Lesson Information
    expect(find.text('Lesson Information'), findsOneWidget);
    expect(find.text('Lesson Title'), findsOneWidget);
    expect(find.text('Enter lesson title'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Add a short description about this lesson'), findsOneWidget);
    expect(find.text('Class'), findsOneWidget);
    expect(find.text('Class 8-A'), findsOneWidget);
    expect(find.text('Subject'), findsOneWidget);
    expect(find.text('Biology'), findsOneWidget);

    // Section 2: Lesson Notes
    expect(find.text('Lesson Notes'), findsOneWidget);
    expect(find.text('|Write lesson notes...'), findsOneWidget);

    // Section 3: Add Content
    expect(find.text('Add Content'), findsOneWidget);
    expect(find.text('Documents'), findsOneWidget);
    expect(find.text('Images'), findsOneWidget);
    expect(find.text('Audio'), findsOneWidget);
    expect(find.text('Assessments'), findsOneWidget);

    // Video Section
    expect(find.text('Video URL'), findsOneWidget);
    expect(find.text('Paste video URL'), findsOneWidget);
    expect(find.text('Add a link to the video you want to include in this lesson.'), findsOneWidget);
    expect(find.text('ADD VIDEO'), findsOneWidget);
    expect(find.text('Uploaded Video'), findsOneWidget);
    expect(find.text('REMOVE'), findsOneWidget);

    // Section 4: Visibility
    expect(find.text('Visible to Students'), findsOneWidget);
    expect(find.text('Allow students to see this lesson'), findsOneWidget);

    // Section 5: Bottom button
    expect(find.text('Create Lesson'), findsWidgets);
  });

  testWidgets('TeacherCreateLessonController adds lesson to list and handles video toggle',
      (WidgetTester tester) async {
    final createCtrl = Get.find<TeacherCreateLessonController>();
    final lessonsCtrl = Get.find<TeacherLessonsController>();

    final initialCount = lessonsCtrl.allLessons.length;

    // Toggle video removal
    expect(createCtrl.hasUploadedVideo.value, true);
    createCtrl.onRemoveVideo();
    expect(createCtrl.hasUploadedVideo.value, false);

    // Add video back
    createCtrl.videoUrlController.text = 'https://youtube.com/watch?v=sample';
    createCtrl.onAddVideo();
    expect(createCtrl.hasUploadedVideo.value, true);

    // Toggle visibility
    expect(createCtrl.isVisibleToStudents.value, true);
    createCtrl.toggleVisibility(false);
    expect(createCtrl.isVisibleToStudents.value, false);

    // Create lesson validation
    createCtrl.titleController.text = '';
    createCtrl.onCreateLesson();
    expect(lessonsCtrl.allLessons.length, initialCount); // No addition if title empty

    createCtrl.titleController.text = 'New Physics Exploration';
    createCtrl.onCreateLesson();
    expect(lessonsCtrl.allLessons.length, initialCount + 1);
    expect(lessonsCtrl.allLessons.first.title, 'New Physics Exploration');
  });
}
