import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/leaderboard/teacher_leaderboard_controller.dart';
import 'package:zama_xr/app/modules/teacher/leaderboard/teacher_leaderboard_view.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets(
    'TeacherLeaderboardView renders header, switcher, podium, active card, list, and CTA',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: TeacherLeaderboardView(),
        ),
      );
      await tester.pumpAndSettle();

      // 1. Header
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.text('Review AI Quiz'), findsOneWidget);
      expect(find.text('Grade 8 – A • 32 Students'), findsOneWidget);

      // 2. Filter Switcher
      expect(find.text('This Week'), findsOneWidget);
      expect(find.text('This Month'), findsOneWidget);

      // 3. Top 3 Podium
      expect(find.text('Michael C.'), findsOneWidget);
      expect(find.text('Sarah J.'), findsOneWidget);
      expect(find.text('Emma P.'), findsOneWidget);
      expect(find.text('1'), findsWidgets);
      expect(find.text('2'), findsWidgets);
      expect(find.text('3'), findsOneWidget);

      // 4. Active Students Card
      expect(find.text('78%'), findsOneWidget);
      expect(find.text('Active Students'), findsOneWidget);
      expect(find.text('25 of 32 students participated this week'), findsOneWidget);

      // 5. Information Header
      expect(find.text('Information'), findsOneWidget);

      // 6. Ranked List (Ranks 4, 5, 6)
      expect(find.text('James Davis'), findsOneWidget);
      expect(find.text('Consistent contributor'), findsOneWidget);
      expect(find.text('1,950'), findsOneWidget);

      expect(find.text('Olivia Wilson'), findsOneWidget);
      expect(find.text('Group project lead'), findsOneWidget);
      expect(find.text('1,820'), findsOneWidget);

      expect(find.text('Ethan Moore'), findsOneWidget);
      expect(find.text('Discussion active'), findsOneWidget);
      expect(find.text('1,790'), findsOneWidget);

      // 7. View All Students CTA
      expect(find.text('View All Students'), findsOneWidget);
    },
  );

  testWidgets(
    'TeacherLeaderboardView switches between This Week and This Month',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: TeacherLeaderboardView(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('78%'), findsOneWidget);

      // Tap This Month
      await tester.tap(find.text('This Month'));
      await tester.pumpAndSettle();

      expect(find.text('94%'), findsOneWidget);
      expect(find.text('30 of 32 students participated this month'), findsOneWidget);
    },
  );

  testWidgets(
    'TeacherLeaderboardView does not overflow on narrow screen with scaled text',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360, 1600);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: MediaQuery(
            data: MediaQueryData(
              size: Size(360, 1600),
              textScaler: TextScaler.linear(1.1),
            ),
            child: TeacherLeaderboardView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Review AI Quiz'), findsOneWidget);
    },
  );

  test('TeacherLeaderboardController initializes and triggers actions', () {
    final controller = Get.find<TeacherLeaderboardController>();
    expect(controller.title.value, 'Review AI Quiz');
    expect(controller.rankedList.length, 3);

    controller.onSelectPeriod('This Month');
    expect(controller.selectedPeriod.value, 'This Month');
    expect(controller.participationPercentage.value, 94);

    controller.onBack();
    controller.onStudentTap(controller.rankedList.first);
    controller.onViewAllStudents();
  });
}
