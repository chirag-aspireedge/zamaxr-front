import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/modules/student/dashboard/student_dashboard_controller.dart';
import 'package:zama_xr/app/modules/student/dashboard/student_dashboard_view.dart';
import 'package:zama_xr/app/modules/student/home/student_home_controller.dart';
import 'package:zama_xr/app/modules/student/home/student_home_view.dart';
import 'package:zama_xr/app/modules/student/my_learning/student_my_learning_controller.dart';

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

  group('StudentHomeController Unit Tests', () {
    test('Initializes with default user greeting and prompt', () {
      final controller = Get.find<StudentHomeController>();
      expect(controller.userName, 'Alex');
      expect(controller.userGreeting, 'Hello, Alex! 👋');
      expect(controller.userPrompt, 'What would you like to explore today?');
      expect(controller.hasUnreadNotifications.value, true);
    });

    test('Features list contains all 6 core tools', () {
      final controller = Get.find<StudentHomeController>();
      expect(controller.features.length, 6);
      expect(controller.features[0].title, 'AI Tutor');
      expect(controller.features[1].title, 'Quizzes');
      expect(controller.features[2].title, 'AR Learning');
      expect(controller.features[3].title, 'VR Learning');
      expect(controller.features[4].title, 'Math Solver');
      expect(controller.features[5].title, 'Rewards');
    });

    test('Curriculum notes list contains sample lessons', () {
      final controller = Get.find<StudentHomeController>();
      expect(controller.notes.length, 2);
      expect(controller.notes[0].title, 'Cell Biology: Organelles & Functions');
      expect(controller.notes[1].title, 'Earth Science: Planetary Systems');
    });

    test('Controller methods can be invoked safely', () {
      final controller = Get.find<StudentHomeController>();
      controller.onExploreVrPressed();
      controller.onFeatureTapped('AI Tutor');
      controller.onStartSelfPacedPressed();
      controller.onResumeLearningPressed();
      controller.onDownloadNotePressed('Biology Notes');
    });
  });

  group('StudentDashboardController Unit Tests', () {
    test('Initializes at tab index 0 and changes index properly', () {
      final controller = Get.find<StudentDashboardController>();
      expect(controller.selectedIndex.value, 0);

      controller.changeTabIndex(2);
      expect(controller.selectedIndex.value, 2);

      controller.changeTabIndex(0);
      expect(controller.selectedIndex.value, 0);
    });
  });

  group('StudentHomeView Widget Tests', () {
    testWidgets('Renders all exact Figma sections, headings, badges, and cards', (tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentHomeView(),
        ),
      );

      // Header: Greeting, prompt & avatar
      expect(find.text('Hello, Alex! 👋'), findsOneWidget);
      expect(find.text('What would you like to explore today?'), findsOneWidget);
      expect(find.text('AL'), findsOneWidget);

      // Section 1: Hero VR World Card
      expect(find.text('IMMERSIVE 360°'), findsOneWidget);
      expect(find.text('VR World'), findsOneWidget);
      expect(find.text('Spatial Audio & Motion Ready'), findsOneWidget);
      expect(find.text('Explore VR'), findsOneWidget);

      // Section 2: Explore Features & 3x2 Grid
      expect(find.text('Explore Features'), findsOneWidget);
      expect(find.text('Quick Access'), findsOneWidget);
      expect(find.text('AI Tutor'), findsOneWidget);
      expect(find.text('Instant Answers'), findsOneWidget);
      expect(find.text('Quizzes'), findsOneWidget);
      expect(find.text('Practice & Win'), findsOneWidget);
      expect(find.text('AR Learning'), findsOneWidget);
      expect(find.text('3D Projection'), findsOneWidget);
      expect(find.text('VR Learning'), findsOneWidget);
      expect(find.text('Virtual Labs'), findsOneWidget);
      expect(find.text('Math Solver'), findsOneWidget);
      expect(find.text('Step-by-Step'), findsOneWidget);
      expect(find.text('Rewards'), findsOneWidget);
      expect(find.text('120 Points'), findsOneWidget);

      // Section 3: Self-Paced Content
      expect(find.text('Self-Paced\nContent'), findsOneWidget);
      expect(find.text('Learn at your own pace.'), findsOneWidget);
      expect(find.text('WebView'), findsOneWidget);
      expect(find.text('Start Learning'), findsOneWidget);

      // Section 4: Continue Learning
      expect(find.text('Continue Learning'), findsOneWidget);
      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Biology: Human Cell Structure'), findsOneWidget);
      expect(find.text('Interactive 3D'), findsOneWidget);
      expect(find.text('65% Completed'), findsOneWidget);
      expect(find.text('Resume'), findsOneWidget);
      expect(find.text('AI Tutor: Practiced Photosynthesis'), findsOneWidget);

      // Section 5: Curriculum Lesson Notes
      expect(find.text('Curriculum Lesson\nNotes'), findsOneWidget);
      expect(find.text('US (NGSS) • Available'), findsOneWidget);
      expect(find.text('Cell Biology: Organelles & Functions'), findsOneWidget);
      expect(find.text('Earth Science: Planetary Systems'), findsOneWidget);

      // Section 6: Affirmation Banner
      expect(
        find.text('Independent learners have full access to all XR modules, AI Tutor, and Self-Paced courses.'),
        findsOneWidget,
      );
    });

    testWidgets(
      'StudentHomeView does not overflow on narrow screen with scaled text',
      (WidgetTester tester) async {
        tester.view.physicalSize = const Size(360, 1620);
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.resetPhysicalSize);

        await tester.pumpWidget(
          const GetMaterialApp(
            home: MediaQuery(
              data: MediaQueryData(
                size: Size(360, 1620),
                textScaler: TextScaler.linear(1.05),
              ),
              child: StudentHomeView(),
            ),
          ),
        );

        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
      },
    );
  });

  group('StudentDashboardView Widget Tests', () {
    testWidgets('Renders floating bottom navbar and switches tabs', (tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentDashboardView(),
        ),
      );

      final dashboardController = Get.find<StudentDashboardController>();
      expect(dashboardController.selectedIndex.value, 0);

      // Initial tab shows Home greeting
      expect(find.text('Hello, Alex! 👋'), findsOneWidget);

      // Switch to Courses tab
      dashboardController.changeTabIndex(1);
      await tester.pumpAndSettle();
      expect(find.text('My Learning'), findsOneWidget);

      // Switch to Rewards tab
      dashboardController.changeTabIndex(2);
      await tester.pumpAndSettle();
      expect(find.text('Rewards & Badges'), findsOneWidget);

      // Switch to Profile tab
      dashboardController.changeTabIndex(3);
      await tester.pumpAndSettle();
      expect(find.text('Student Profile'), findsOneWidget);

      // Switch back to Home
      dashboardController.changeTabIndex(0);
      await tester.pumpAndSettle();
      expect(find.text('Hello, Alex! 👋'), findsOneWidget);
    });
  });
}
