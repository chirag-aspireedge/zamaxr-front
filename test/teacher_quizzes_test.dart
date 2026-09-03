import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/modules/teacher/quizzes/teacher_quizzes_controller.dart';
import 'package:zama_xr/app/modules/teacher/quizzes/teacher_quizzes_view.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TeacherQuizzesView renders search, tabs, cards, and action buttons', (WidgetTester tester) async {
    Get.put(TeacherQuizzesController());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: TeacherQuizzesView(),
      ),
    );
    await tester.pump();

    // 1. Search Bar
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Search teacher'), findsOneWidget);

    // 2. Filter tabs
    expect(find.text('All'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Inactive'), findsOneWidget);

    // 3. Quiz cards
    expect(find.text('General Science'), findsWidgets);
    expect(find.text('Physics'), findsOneWidget);
    expect(find.text('Chapter 1'), findsWidgets);
    expect(find.text('Motion'), findsOneWidget);
    expect(find.text('Class 10 • Science'), findsWidgets);
    expect(find.text('Class 9 • Physics'), findsOneWidget);

    // 4. Badges & assignment
    expect(find.text('ACTIVE'), findsWidgets);
    expect(find.text('INACTIVE'), findsOneWidget);
    expect(find.text('Assigned to Class 10-A'), findsWidgets);
    expect(find.text('Not assigned yet'), findsOneWidget);

    // 5. Regenerate Quiz buttons
    expect(find.text('Regenerate Quiz'), findsWidgets);
  });

  testWidgets('TeacherQuizzesView filters by Active and Inactive tabs', (WidgetTester tester) async {
    Get.put(TeacherQuizzesController());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: TeacherQuizzesView(),
      ),
    );
    await tester.pump();

    // Tap Active tab
    await tester.tap(find.text('Active'));
    await tester.pumpAndSettle();

    expect(find.text('General Science'), findsWidgets);
    expect(find.text('Physics'), findsNothing);

    // Tap Inactive tab
    await tester.tap(find.text('Inactive'));
    await tester.pumpAndSettle();

    expect(find.text('General Science'), findsNothing);
    expect(find.text('Physics'), findsOneWidget);

    // Tap All tab
    await tester.tap(find.text('All'));
    await tester.pumpAndSettle();

    expect(find.text('General Science'), findsWidgets);
    expect(find.text('Physics'), findsOneWidget);
  });

  testWidgets('TeacherQuizzesView filters by search input', (WidgetTester tester) async {
    Get.put(TeacherQuizzesController());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: TeacherQuizzesView(),
      ),
    );
    await tester.pump();

    // Type 'Physics' into search
    await tester.enterText(find.byType(TextField), 'Physics');
    await tester.pumpAndSettle();

    expect(find.text('Motion'), findsOneWidget);
    expect(find.text('General Science'), findsNothing);

    // Clear search
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    expect(find.text('General Science'), findsWidgets);
    expect(find.text('Motion'), findsOneWidget);
  });

  testWidgets('TeacherQuizzesView does not overflow on narrow screen with scaled text', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    Get.put(TeacherQuizzesController());

    await tester.pumpWidget(
      const GetMaterialApp(
        home: MediaQuery(
          data: MediaQueryData(
            size: Size(360, 800),
            textScaler: TextScaler.linear(1.1),
          ),
          child: TeacherQuizzesView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('All'), findsOneWidget);
  });

  test('TeacherQuizzesController handles tab, search and options', () {
    final ctrl = Get.put(TeacherQuizzesController());

    expect(ctrl.filteredQuizzes.length, 3);

    ctrl.onSelectTab(1);
    expect(ctrl.filteredQuizzes.length, 2);

    ctrl.onSelectTab(2);
    expect(ctrl.filteredQuizzes.length, 1);
    expect(ctrl.filteredQuizzes.first.title, 'Physics');

    ctrl.onSelectTab(0);
    ctrl.onSearchChanged('Motion');
    expect(ctrl.filteredQuizzes.length, 1);
    expect(ctrl.filteredQuizzes.first.chapter, 'Motion');

    ctrl.onClearSearch();
    expect(ctrl.filteredQuizzes.length, 3);
  });
}
