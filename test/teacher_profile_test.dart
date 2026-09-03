import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/binding/all_controller_bindings.dart';
import 'package:zama_xr/app/modules/teacher/profile/teacher_profile_controller.dart';
import 'package:zama_xr/app/modules/teacher/profile/teacher_profile_view.dart';

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
    'TeacherProfileView renders avatar, header, institution, 4 menu items, and logout button',
    (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: TeacherProfileView(),
        ),
      );
      await tester.pumpAndSettle();

      // Edit avatar button
      expect(find.byIcon(Icons.edit_outlined), findsOneWidget);

      // Header info
      expect(find.text('Sarah Johnson'), findsOneWidget);
      expect(find.text('sarah.johnson@example.com'), findsOneWidget);
      expect(find.text('ABC International Institute'), findsOneWidget);

      // Menu Items
      expect(find.text('Language'), findsOneWidget);
      expect(find.text('English'), findsOneWidget);

      expect(find.text('Notifications'), findsOneWidget);
      expect(find.text('Manage notification preferences'), findsOneWidget);

      expect(find.text('Change Password'), findsOneWidget);
      expect(find.text('Update your account password'), findsOneWidget);

      expect(find.text('Account'), findsOneWidget);
      expect(find.text('Manage account settings'), findsOneWidget);

      // Logout button
      expect(find.text('Logout'), findsOneWidget);

      // Tap Logout button to trigger confirmation dialog
      await tester.tap(find.text('Logout'));
      await tester.pumpAndSettle();

      expect(find.text('Log Out'), findsWidgets);
      expect(find.text('Cancel'), findsOneWidget);

      // Tap cancel to close dialog
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
    },
  );

  testWidgets(
    'TeacherProfileView does not overflow on narrow screen with scaled text',
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
            child: TeacherProfileView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text('Sarah Johnson'), findsOneWidget);
    },
  );

  test('TeacherProfileController handles actions properly', () {
    final controller = Get.find<TeacherProfileController>();
    expect(controller.teacherName.value, 'Sarah Johnson');
    expect(controller.selectedLanguage.value, 'English');

    controller.onEditAvatar();
    controller.onLanguageTap();
    controller.onNotificationsTap();
    controller.onChangePasswordTap();
    controller.onAccountTap();
  });
}
