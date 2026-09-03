import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/lesson_detail/teacher_lesson_detail_controller.dart';
import 'package:zama_xr/app/modules/teacher/lesson_detail/teacher_lesson_detail_view.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets(
    'TeacherLessonDetailView renders full rich lesson detail with all media sections',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: TeacherLessonDetailView(),
        ),
      );

      await tester.pumpAndSettle();

      // Top Bar
      expect(find.text('Assigned Teacher'), findsOneWidget);

      // Title & Category
      expect(find.text('Cell Structure'), findsWidgets);
      expect(find.text('Biology Fundamentals'), findsOneWidget);
      expect(find.text('Published'), findsOneWidget);
      expect(find.text('Visible to Students'), findsOneWidget);

      // About This Lesson
      expect(find.text('About This Lesson'), findsOneWidget);

      // Documents
      expect(find.text('Documents'), findsOneWidget);
      expect(find.text('Lesson Notes.pdf'), findsOneWidget);

      // Videos
      expect(find.text('Videos'), findsOneWidget);
      expect(find.text('Cell Structure — Introduction'), findsOneWidget);

      // Immersive Content
      expect(find.text('Immersive Content'), findsOneWidget);
      expect(find.text('AR Experience: Cell Model'), findsOneWidget);
      expect(find.text('VR Asset: 3D Exploration'), findsOneWidget);

      // Assessments
      expect(find.text('Assessments'), findsOneWidget);
      expect(find.text('Add New Quiz'), findsOneWidget);

      // Edit Lesson Button
      expect(find.text('Edit Lesson'), findsOneWidget);
    },
  );

  testWidgets('TeacherLessonDetailController toggles audio and triggers actions',
      (WidgetTester tester) async {
    final controller = Get.find<TeacherLessonDetailController>();

    expect(controller.isAudioPlaying.value, false);
    controller.toggleAudioPlay();
    expect(controller.isAudioPlaying.value, true);
    controller.toggleAudioPlay();
    expect(controller.isAudioPlaying.value, false);

    controller.onSeekAudio(0.75);
    expect(controller.audioProgress.value, 0.75);
  });
}
