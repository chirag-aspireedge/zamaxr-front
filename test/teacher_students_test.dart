import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/students/teacher_students_controller.dart';
import 'package:zama_xr/app/modules/teacher/students/teacher_students_view.dart';

void main() {
  setUp(() {
    Get.reset();
    Get.testMode = true;
    AllControllerBindings().dependencies();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets(
    'TeacherStudentsView renders title, counter, add button, and all student cards',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: TeacherStudentsView(),
        ),
      );
      await tester.pumpAndSettle();

      // App Bar Title
      expect(find.text('Students'), findsOneWidget);

      // Back button should NOT be present
      expect(find.byIcon(Icons.arrow_back), findsNothing);
      expect(find.byIcon(Icons.arrow_back_ios), findsNothing);

      // Subheader
      expect(find.text('30 Student'), findsOneWidget);
      expect(find.text('+ Add Student'), findsOneWidget);

      // Student Cards
      expect(find.text('Sarah Johnson'), findsOneWidget);
      expect(find.text('ID: STU-1024'), findsOneWidget);

      expect(find.text('Michael Chen'), findsOneWidget);
      expect(find.text('ID: STU-1025'), findsOneWidget);

      expect(find.text('Emma Patel'), findsOneWidget);
      expect(find.text('ID: STU-1026'), findsOneWidget);
      expect(find.text('EP'), findsOneWidget);

      expect(find.text('James Davis'), findsOneWidget);
      expect(find.text('ID: STU-1027'), findsOneWidget);
      expect(find.text('JD'), findsOneWidget);

      expect(find.text('Olivia Wilson'), findsOneWidget);
      expect(find.text('ID: STU-1028'), findsOneWidget);
    },
  );

  testWidgets(
    'TeacherStudentsView does not overflow on narrow screen with scaled text',
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
            child: TeacherStudentsView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Students'), findsOneWidget);
    },
  );

  test('TeacherStudentsController triggers actions without error', () {
    final controller = Get.find<TeacherStudentsController>();
    expect(controller.students.length, 5);
    expect(controller.studentsCount.value, 30);

    // Call actions
    controller.onAddStudent();
    controller.onStudentTap(controller.students.first);
  });
}
