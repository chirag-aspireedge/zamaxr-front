import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/modules/student/dashboard/student_dashboard_controller.dart';
import 'package:zama_xr/app/modules/student/dashboard/student_dashboard_view.dart';
import 'package:zama_xr/app/modules/student/home/student_home_controller.dart';
import 'package:zama_xr/app/modules/student/my_learning/student_my_learning_controller.dart';
import 'package:zama_xr/app/modules/student/my_learning/student_my_learning_view.dart';
import 'package:zama_xr/app/modules/student/lesson_detail/student_lesson_detail_controller.dart';
import 'package:zama_xr/app/routes/app_pages.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.lazyPut(() => StudentHomeController());
    Get.lazyPut(() => StudentDashboardController());
    Get.lazyPut(() => StudentMyLearningController());
  });

  tearDown(() {
    Get.reset();
  });

  group('StudentMyLearningController Unit Tests', () {
    test('Initializes with 4 Figma enrolled courses', () {
      final controller = Get.find<StudentMyLearningController>();
      expect(controller.courses.length, 4);

      // Card 1: Biology
      final biology = controller.courses[0];
      expect(biology.subject, 'Biology');
      expect(biology.term, 'Term 1');
      expect(biology.continueLesson, 'Continue: Cell Structure');
      expect(biology.lastViewed, 'Last viewed: Lesson 4');
      expect(biology.progress, 0.65);
      expect(biology.hasOfflineBadge, true);
      expect(biology.isOfflineAvailable.value, true);

      // Card 2: Mathematics
      final math = controller.courses[1];
      expect(math.subject, 'Mathematics');
      expect(math.term, 'Term 1');
      expect(math.continueLesson, 'Continue: Quadratic Equations');
      expect(math.lastViewed, 'Last viewed: Lesson 2');
      expect(math.progress, 0.40);
      expect(math.hasOfflineBadge, true);

      // Card 3: English
      final english = controller.courses[2];
      expect(english.subject, 'English');
      expect(english.term, 'Term 1');
      expect(english.continueLesson, 'Continue: Shakespearean Sonnets');
      expect(english.lastViewed, 'Last viewed: Lesson 7');
      expect(english.progress, 0.85);
      expect(english.hasOfflineBadge, false);

      // Card 4: Physics
      final physics = controller.courses[3];
      expect(physics.subject, 'Physics');
      expect(physics.term, 'Term 1');
      expect(physics.continueLesson, 'Continue: Thermodynamics');
      expect(physics.lastViewed, 'Last viewed: Lesson 1');
      expect(physics.progress, 0.15);
      expect(physics.hasOfflineBadge, true);
    });

    test('Filtering works correctly for All, Offline, and Completed', () {
      final controller = Get.find<StudentMyLearningController>();

      controller.setFilter('All');
      expect(controller.filteredCourses.length, 4);

      controller.setFilter('Offline');
      expect(controller.filteredCourses.length, 3); // Biology, Math, Physics

      controller.setFilter('Completed');
      expect(controller.filteredCourses.length, 1); // English (85%)
    });

    test('Toggling offline switches reactive state', () {
      final controller = Get.find<StudentMyLearningController>();
      final biology = controller.courses[0];

      expect(biology.isOfflineAvailable.value, true);
      controller.toggleOffline(biology);
      expect(biology.isOfflineAvailable.value, false);
      controller.toggleOffline(biology);
      expect(biology.isOfflineAvailable.value, true);

      // English has no offline badge, toggle does nothing
      final english = controller.courses[2];
      expect(english.isOfflineAvailable.value, false);
      controller.toggleOffline(english);
      expect(english.isOfflineAvailable.value, false);
    });

    test('Can invoke onContinueCourse safely', () {
      final controller = Get.find<StudentMyLearningController>();
      final biology = controller.courses[0];
      controller.onContinueCourse(biology);
    });
  });

  group('StudentMyLearningView Widget Tests', () {
    testWidgets('Renders all 4 subject cards with exact Figma details', (tester) async {
      tester.view.physicalSize = const Size(402, 1237);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentMyLearningView(),
        ),
      );
      await tester.pumpAndSettle();

      // Top title and enrolled count
      expect(find.text('My Learning'), findsOneWidget);
      expect(find.text('4 Enrolled'), findsOneWidget);
      expect(find.text('All'), findsNothing);
      expect(find.text('Completed'), findsNothing);

      // Subject names
      expect(find.text('Biology'), findsOneWidget);
      expect(find.text('Mathematics'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);
      expect(find.text('Physics'), findsOneWidget);

      // Progress texts
      expect(find.text('Continue: Cell Structure'), findsOneWidget);
      expect(find.text('Last viewed: Lesson 4'), findsOneWidget);
      expect(find.text('65%'), findsOneWidget);

      expect(find.text('Continue: Quadratic Equations'), findsOneWidget);
      expect(find.text('Last viewed: Lesson 2'), findsOneWidget);
      expect(find.text('40%'), findsOneWidget);

      expect(find.text('Continue: Shakespearean Sonnets'), findsOneWidget);
      expect(find.text('Last viewed: Lesson 7'), findsOneWidget);
      expect(find.text('85%'), findsOneWidget);

      expect(find.text('Continue: Thermodynamics'), findsOneWidget);
      expect(find.text('Last viewed: Lesson 1'), findsOneWidget);
      expect(find.text('15%'), findsOneWidget);

      // Continue buttons
      expect(find.text('CONTINUE'), findsNWidgets(4));
    });

    testWidgets('Renders cleanly on narrow screen (320px) without overflow', (tester) async {
      tester.view.physicalSize = const Size(320, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentMyLearningView(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('My Learning'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Switching to Tab 1 in StudentDashboardView displays My Learning tab', (tester) async {
      tester.view.physicalSize = const Size(402, 1237);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentDashboardView(),
        ),
      );
      await tester.pumpAndSettle();

      final dashboardController = Get.find<StudentDashboardController>();
      expect(dashboardController.selectedIndex.value, 0);

      // Switch to tab 1 (My Learning)
      dashboardController.changeTabIndex(1);
      await tester.pumpAndSettle();

      expect(dashboardController.selectedIndex.value, 1);
      expect(find.text('My Learning'), findsOneWidget);
      expect(find.text('Biology'), findsOneWidget);
      expect(find.text('Mathematics'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Tapping CONTINUE button on course card navigates to Student Lesson Detail', (tester) async {
      tester.view.physicalSize = const Size(402, 1237);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      Get.put(StudentLessonDetailController());

      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: Routes.STUDENT_MY_LEARNING,
          getPages: AppPages.routes,
        ),
      );
      await tester.pumpAndSettle();

      // Tap first CONTINUE button (Biology)
      final continueButton = find.text('CONTINUE').first;
      expect(continueButton, findsOneWidget);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      // Verify navigation to StudentLessonDetailView
      expect(find.text('Lesson Details'), findsOneWidget);
      expect(find.text('About This Lesson'), findsOneWidget);
    });
  });
}
