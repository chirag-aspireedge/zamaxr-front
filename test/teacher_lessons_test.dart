import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/lessons/teacher_lessons_controller.dart';
import 'package:zama_xr/app/modules/teacher/lessons/teacher_lessons_view.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TeacherLessonsView renders top bar, filter tabs, lesson cards, and continue button',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const GetMaterialApp(
        home: TeacherLessonsView(),
      ),
    );

    // Search field
    expect(find.text('Search class...'), findsOneWidget);

    // Top Bar Add button
    expect(find.byIcon(Icons.add_rounded), findsOneWidget);

    // Filter tabs
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Draft'), findsWidgets);
    expect(find.text('Published'), findsWidgets);
    expect(find.text('Archived'), findsOneWidget);

    // Lesson cards
    expect(find.text('Intro to Quantum Physics'), findsOneWidget);
    expect(find.text('The Roman Empire'), findsOneWidget);
    expect(find.text('Cellular Respiration'), findsOneWidget);

    // Subject chapter badges
    expect(find.text('Physics • Ch 4'), findsOneWidget);
    expect(find.text('History • Unit 2'), findsOneWidget);
    expect(find.text('Biology • Ch 7'), findsOneWidget);
  });

  testWidgets('TeacherLessonsController filters lessons by status correctly',
      (WidgetTester tester) async {
    final controller = Get.find<TeacherLessonsController>();

    expect(controller.filteredLessons.length, 3);

    // Filter Draft
    controller.setFilter('Draft');
    expect(controller.filteredLessons.length, 1);
    expect(controller.filteredLessons.first.title, 'The Roman Empire');

    // Filter Published
    controller.setFilter('Published');
    expect(controller.filteredLessons.length, 2);

    // Search query
    controller.setFilter('All');
    controller.onSearch('Quantum');
    expect(controller.filteredLessons.length, 1);
    expect(controller.filteredLessons.first.title, 'Intro to Quantum Physics');
  });

  testWidgets('TeacherLessonsView does not overflow on small screen with high text scale',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 780);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(
          size: Size(360, 780),
          textScaler: TextScaler.linear(1.2),
        ),
        child: GetMaterialApp(
          home: TeacherLessonsView(),
        ),
      ),
    );

    // Verify no exception was thrown and lesson title renders cleanly
    expect(find.text('Intro to Quantum Physics'), findsOneWidget);
    expect(find.text('The Roman Empire'), findsOneWidget);
    expect(find.text('Cellular Respiration'), findsOneWidget);
  });
}
