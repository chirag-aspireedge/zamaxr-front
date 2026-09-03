import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/student_detail/teacher_student_detail_controller.dart';
import 'package:zama_xr/app/modules/teacher/student_detail/teacher_student_detail_view.dart';

void main() {
  setUp(() {
    Get.reset();
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets(
    'TeacherStudentDetailView renders all header, contact, score card, ranking, and recent quizzes',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: TeacherStudentDetailView(),
        ),
      );
      await tester.pumpAndSettle();

      // App Bar
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.text('Sarah Johnson'), findsOneWidget);

      // Student ID & Chip
      expect(find.text('STU-1024'), findsOneWidget);
      expect(find.text('ACTIVE'), findsOneWidget);

      // Contact Details
      expect(find.text('Contact Details'), findsOneWidget);
      expect(find.text('sarah.j@school.com'), findsOneWidget);
      expect(find.text('Parent: +1 (555) 0192'), findsOneWidget);

      // Total Score Card
      expect(find.text('TOTAL SCORE'), findsOneWidget);
      expect(find.text('2,450'), findsOneWidget);
      expect(find.text('pts'), findsOneWidget);
      expect(find.text('12% from last week'), findsOneWidget);

      // Current Ranking Card
      expect(find.text('Current Ranking'), findsOneWidget);
      expect(find.text('Rank #1 of 32 Students'), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right_rounded), findsOneWidget);

      // View All link
      expect(find.text('View All'), findsOneWidget);

      // Recent Quizzes
      expect(find.text('Recent Quizzes'), findsOneWidget);
      expect(find.text('Cell Structure Quiz'), findsNWidgets(2));
      expect(find.text('Human Body Quiz'), findsNWidgets(2));
      expect(find.text('Completed'), findsNWidgets(4));
    },
  );

  testWidgets(
    'TeacherStudentDetailView does not overflow on narrow screen with scaled text',
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
            child: TeacherStudentDetailView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Sarah Johnson'), findsOneWidget);
    },
  );

  test('TeacherStudentDetailController initializes with arguments and triggers actions', () {
    final controller = Get.find<TeacherStudentDetailController>();
    expect(controller.studentName.value, 'Sarah Johnson');
    expect(controller.recentQuizzes.length, 4);

    controller.onRankingTap();
    controller.onViewAllQuizzes();
    controller.onQuizTap(controller.recentQuizzes.first);
  });
}
