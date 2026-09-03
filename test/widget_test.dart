import 'package:flutter_test/flutter_test.dart';
import 'package:zama_xr/app/modules/auth/splash/splash_view.dart';
import 'package:zama_xr/main.dart';

void main() {
  testWidgets('Splash screen smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(SplashView), findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 3));
  });
}
