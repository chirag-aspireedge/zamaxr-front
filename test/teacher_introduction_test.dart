import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/modules/teacher/introduction/teacher_introduction_controller.dart';
import 'package:zama_xr/app/modules/teacher/introduction/teacher_introduction_view.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.lazyPut(() => TeacherIntroductionController());
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TeacherIntroductionView renders headers, 4 feature cards, and button', (WidgetTester tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: TeacherIntroductionView(),
      ),
    );

    // Title and Subtitle
    expect(find.text('Everything you need to teach'), findsOneWidget);
    expect(find.text('Equip yourself with the tools to build the future of learning.'), findsOneWidget);

    // 4 Feature Card Titles
    expect(find.text('Create Lessons'), findsOneWidget);
    expect(find.text('Build Quizzes'), findsOneWidget);
    expect(find.text('Add Learning Content'), findsOneWidget);
    expect(find.text('AR & VR Learning'), findsOneWidget);

    // Action Button
    expect(find.text('Continue'), findsOneWidget);
  });
}
