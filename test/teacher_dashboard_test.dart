import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/dashboard/teacher_dashboard_controller.dart';
import 'package:zama_xr/app/modules/teacher/dashboard/teacher_dashboard_view.dart';
import 'package:zama_xr/app/modules/teacher/home/teacher_home_view.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets(
    'TeacherHomeView renders all header, banner, action cards, and lessons',
    (WidgetTester tester) async {
      // Set a large enough surface size so the entire scrollable screen fits without overflow in tests
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const GetMaterialApp(home: TeacherHomeView()));

      // Greeting
      expect(find.text('Good Morning, Sarah'), findsOneWidget);
      expect(
        find.text(
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
        ),
        findsOneWidget,
      );

      // Hero Banner
      expect(find.text('Create New Immersive Lesson'), findsOneWidget);
      expect(
        find.text(
          'Launch the VR canvas and start building interactive modules for your students.',
        ),
        findsOneWidget,
      );

      // Quick Actions
      expect(find.text('Create Lesson'), findsOneWidget);
      expect(find.text('Create Quiz'), findsOneWidget);
      expect(find.text('Upload Content'), findsOneWidget);

      // Recent Lessons
      expect(find.text('Recent Lessons Built'), findsOneWidget);
      expect(find.text('Intro to Quantum Physics'), findsOneWidget);
      expect(find.text('Updated 2h ago'), findsOneWidget);

      // Recent Quizzes Built
      expect(find.text('Recent Quizzes Built'), findsOneWidget);
      expect(find.text('General Science'), findsWidgets);
      expect(find.text('Regenerate Quiz'), findsWidgets);
      expect(find.text('See All'), findsNWidgets(2));
    },
  );

  testWidgets(
    'TeacherDashboardView switches tabs and renders floating bottom nav',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(home: TeacherDashboardView()),
      );

      final controller = Get.find<TeacherDashboardController>();
      expect(controller.currentTabIndex.value, 0);

      // Change tab to 1
      controller.changeTab(1);
      await tester.pumpAndSettle();
      expect(controller.currentTabIndex.value, 1);

      // Change tab to 2 (TeacherQuizzesView)
      controller.changeTab(2);
      await tester.pumpAndSettle();
      expect(controller.currentTabIndex.value, 2);

      // Change tab back to 0
      controller.changeTab(0);
      await tester.pumpAndSettle();
      expect(controller.currentTabIndex.value, 0);
    },
  );

  testWidgets(
    'Tapping See All in TeacherDashboardView switches to 2nd tab (TeacherLessonsView)',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(home: TeacherDashboardView()),
      );

      final controller = Get.find<TeacherDashboardController>();
      expect(controller.currentTabIndex.value, 0);

      // Tap first See All button in Recent Lessons
      await tester.tap(find.text('See All').first);
      await tester.pumpAndSettle();

      // Current tab should now be 1 (2nd tab: TeacherLessonsView)
      expect(controller.currentTabIndex.value, 1);

      // Switch to tab 2 (3rd tab: TeacherStudentsView)
      controller.changeTab(2);
      await tester.pumpAndSettle();
      expect(controller.currentTabIndex.value, 2);
      expect(find.text('Students'), findsOneWidget);
      expect(find.text('30 Student'), findsOneWidget);
    },
  );

  testWidgets(
    'TeacherHomeView does not overflow on narrow screen with scaled text',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: MediaQuery(
            data: MediaQueryData(
              size: Size(360, 1600),
              textScaler: TextScaler.linear(1.05),
            ),
            child: TeacherHomeView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Recent Quizzes Built'), findsOneWidget);
    },
  );
}
