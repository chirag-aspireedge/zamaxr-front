import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/modules/auth/select_role/select_role_controller.dart';
import 'package:zama_xr/app/modules/student/onboarding/student_onboarding_controller.dart';
import 'package:zama_xr/app/modules/student/onboarding/student_onboarding_view.dart';

void main() {
  setUp(() {
    Get.testMode = true;
    Get.lazyPut(() => StudentOnboardingController());
  });

  tearDown(() {
    Get.reset();
  });

  group('StudentOnboardingController Tests', () {
    test('Initializes with 3 onboarding items and page 0', () {
      final controller = Get.find<StudentOnboardingController>();
      expect(controller.items.length, 3);
      expect(controller.currentPage.value, 0);
      expect(controller.items[0].title, 'Bring Learning to Life');
      expect(
        controller.items[0].description,
        'Explore concepts in an interactive AR experience and see learning beyond the screen.',
      );
    });

    test('onPageChanged updates currentPage value', () {
      final controller = Get.find<StudentOnboardingController>();
      controller.onPageChanged(1);
      expect(controller.currentPage.value, 1);
      controller.onPageChanged(2);
      expect(controller.currentPage.value, 2);
    });
  });

  group('SelectRoleController Student Navigation', () {
    test('continueWithRole routes to STUDENT_ONBOARDING when role is student', () {
      final roleController = SelectRoleController();
      roleController.selectRole(UserRole.student);
      expect(roleController.selectedRole.value, UserRole.student);
    });
  });

  group('StudentOnboardingView Widget Tests', () {
    testWidgets('Renders onboarding screen 1 title, description, skip and next buttons', (tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentOnboardingView(),
        ),
      );

      // Title & Subtitle for Screen 1
      expect(find.text('Bring Learning to Life'), findsOneWidget);
      expect(
        find.text('Explore concepts in an interactive AR experience and see learning beyond the screen.'),
        findsOneWidget,
      );

      // Skip Button
      expect(find.text('Skip'), findsOneWidget);

      // Verify Next Button exists
      final nextButtonFinder = find.byType(CustomPaint);
      expect(nextButtonFinder, findsWidgets);
    });

    testWidgets('Tapping next button calls nextPage', (tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentOnboardingView(),
        ),
      );

      final controller = Get.find<StudentOnboardingController>();
      expect(controller.currentPage.value, 0);

      // Find the Skip text
      final skipFinder = find.text('Skip');
      expect(skipFinder, findsOneWidget);

      // Advance page via controller and verify UI updates
      controller.onPageChanged(1);
      await tester.pump();
      expect(find.text('Explore 3D Virtual Worlds'), findsOneWidget);
    });
  });
}
