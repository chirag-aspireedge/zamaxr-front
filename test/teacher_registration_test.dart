import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/modules/teacher/registration/teacher_registration_controller.dart';
import 'package:zama_xr/app/modules/teacher/registration/teacher_registration_view.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.lazyPut(() => TeacherRegistrationController());
  });

  tearDown(() {
    Get.reset();
  });

  testWidgets('TeacherRegistrationView renders all sections and inputs', (WidgetTester tester) async {
    await tester.pumpWidget(
      const GetMaterialApp(
        home: TeacherRegistrationView(),
      ),
    );

    // Title and Subtitle
    expect(find.text('Set Up Your Profile'), findsOneWidget);
    expect(find.text('Tell us about yourself.'), findsOneWidget);

    // Section Titles
    expect(find.text('Personal Details'), findsOneWidget);
    expect(find.text('Contact Details'), findsOneWidget);
    expect(find.text('Institution'), findsOneWidget);

    // Hints
    expect(find.text('Full name'), findsOneWidget);
    expect(find.text('Teacher ID/ Employee ID'), findsOneWidget);
    expect(find.text('+1'), findsOneWidget);
    expect(find.text('Contact Number'), findsOneWidget);
    expect(find.text('Enter Official Email'), findsOneWidget);
    expect(find.text('Search Your Institution'), findsOneWidget);

    // Continue Button
    expect(find.text('Continue'), findsOneWidget);
  });
}
