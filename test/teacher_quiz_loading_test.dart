import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/modules/teacher/quiz_loading/teacher_quiz_loading_controller.dart';
import 'package:zama_xr/app/modules/teacher/quiz_loading/teacher_quiz_loading_view.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.reset();
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TeacherQuizLoadingView renders animation, headings, and tag', (WidgetTester tester) async {
    final controller = Get.put(TeacherQuizLoadingController());

    await tester.pumpWidget(
      GetMaterialApp(
        home: const TeacherQuizLoadingView(),
      ),
    );
    await tester.pump();

    // Check headings and UI elements
    expect(find.text('Synthesizing Lesson'), findsOneWidget);
    expect(find.text('XR MODULE GENERATION'), findsOneWidget);
    expect(find.byIcon(Icons.auto_awesome), findsOneWidget);
    expect(find.text(controller.statusMessage.value), findsOneWidget);

    // Check progress is initialized
    expect(controller.progress.value >= 0.0, true);
  });
}
