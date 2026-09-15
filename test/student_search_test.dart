import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:zama_xr/app/modules/student/home/student_home_controller.dart';
import 'package:zama_xr/app/modules/student/home/student_home_view.dart';
import 'package:zama_xr/app/modules/student/search/student_search_controller.dart';
import 'package:zama_xr/app/modules/student/search/student_search_view.dart';
import 'package:zama_xr/app/routes/app_pages.dart';

void main() {
  group('StudentSearchController Unit Tests', () {
    late StudentSearchController controller;

    setUp(() {
      Get.testMode = true;
      Get.reset();
      controller = StudentSearchController();
      Get.put(controller);
    });

    tearDown(() {
      Get.reset();
    });

    test('Initializes with empty query and default popular searches', () {
      expect(controller.query.value, isEmpty);
      expect(controller.isSearching, isFalse);
      expect(controller.selectedCategory.value, 'All');
      expect(controller.popularSearches, contains('Biology'));
      expect(controller.popularSearches, contains('Mathematics'));
      expect(controller.popularSearches, contains('Social science'));
      expect(controller.categories.length, 4);
    });

    test('onSearchChanged updates query and activates search state', () {
      controller.onSearchChanged('Photo');
      expect(controller.query.value, 'Photo');
      expect(controller.isSearching, isTrue);
    });

    test('selectPopularSearch sets text and query', () {
      controller.selectPopularSearch('Biology');
      expect(controller.searchTextController.text, 'Biology');
      expect(controller.query.value, 'Biology');
      expect(controller.isSearching, isTrue);
    });

    test('clearSearch resets query and text', () {
      controller.selectPopularSearch('Biology');
      expect(controller.isSearching, isTrue);

      controller.clearSearch();
      expect(controller.searchTextController.text, isEmpty);
      expect(controller.query.value, isEmpty);
      expect(controller.isSearching, isFalse);
    });

    test('selectCategory updates selectedCategory reactive state', () {
      controller.selectCategory('AR Experiences');
      expect(controller.selectedCategory.value, 'AR Experiences');
    });

    test('searchResults filters correctly by query and category', () {
      controller.selectPopularSearch('Photosynthesis');
      expect(controller.searchResults.length, 2);

      controller.selectCategory('AR Experiences');
      expect(controller.searchResults.length, 1);
      expect(controller.searchResults.first.title, 'Photosynthesis');

      controller.selectCategory('All');
      expect(controller.searchResults.length, 2);
    });

    test('onResultAction and onNotificationTap can be safely triggered', () {
      expect(() => controller.onNotificationTap(), returnsNormally);
      expect(controller.hasUnreadNotifications.value, isFalse);

      final result = controller.initialResults.first;
      expect(() => controller.onResultAction(result), returnsNormally);
    });
  });

  group('StudentSearchView Widget Tests', () {
    late StudentSearchController controller;

    setUp(() {
      Get.testMode = true;
      Get.reset();
      controller = StudentSearchController();
      Get.put(controller);
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('Renders State 1 (Popular Searches) when query is empty', (tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentSearchView(),
        ),
      );
      await tester.pumpAndSettle();

      // Top bar elements
      expect(find.byIcon(PhosphorIcons.arrowLeft(PhosphorIconsStyle.bold)), findsOneWidget);
      expect(find.text('Search subject...'), findsOneWidget);
      expect(find.byIcon(PhosphorIcons.bell(PhosphorIconsStyle.bold)), findsOneWidget);

      // Popular searches section
      expect(find.text('Popular Searches'), findsOneWidget);
      expect(find.text('Biology'), findsOneWidget);
      expect(find.text('Mathematics'), findsOneWidget);
      expect(find.text('Social science'), findsOneWidget);
      expect(find.byIcon(PhosphorIcons.clockCounterClockwise(PhosphorIconsStyle.regular)), findsNWidgets(3));
    });

    testWidgets('Tapping popular search switches to State 2 (Search Results)', (tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentSearchView(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap 'Biology' popular search item
      await tester.tap(find.text('Biology'));
      await tester.pumpAndSettle();

      // Header switches to Search Results
      expect(find.text('Search Results'), findsOneWidget);
      expect(find.textContaining('results found for "Biology"'), findsOneWidget);

      // Filter chips
      expect(find.text('All'), findsOneWidget);
      expect(find.text('Lessons'), findsOneWidget);
      expect(find.text('Subjects'), findsOneWidget);
      expect(find.text('AR Experiences'), findsOneWidget);

      // Cards rendered
      expect(find.text('Photosynthesis'), findsOneWidget);
      expect(find.text('BIOLOGY'), findsOneWidget);
      expect(find.text('Continue Lesson'), findsOneWidget);
      expect(find.text('65% complete'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('Renders both exact Figma cards when searching "Photosynthesis"', (tester) async {
      controller.selectPopularSearch('Photosynthesis');

      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentSearchView(),
        ),
      );
      await tester.pumpAndSettle();

      // Card 1: Biology / Photosynthesis (appears in Search Bar and Card Title)
      expect(find.text('BIOLOGY'), findsOneWidget);
      expect(find.text('Photosynthesis'), findsNWidgets(2));
      expect(find.text('Biology'), findsOneWidget);
      expect(find.text('Continue Lesson'), findsOneWidget);

      // Card 2: Chemistry / Photosynthesis & Plant Energy
      expect(find.text('CHEMISTRY'), findsOneWidget);
      expect(find.text('Photosynthesis & Plant Energy'), findsOneWidget);
      expect(find.text('Chemistry'), findsOneWidget);
      expect(find.text('Start Lesson'), findsOneWidget);

      // Both cards are Class 8
      expect(find.text('Class 8'), findsNWidgets(2));
    });

    testWidgets('Renders cleanly on narrow screen (320px) without overflow', (tester) async {
      tester.view.physicalSize = const Size(320, 1092);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      controller.selectPopularSearch('Photosynthesis');

      await tester.pumpWidget(
        const GetMaterialApp(
          home: MediaQuery(
            data: MediaQueryData(
              size: Size(320, 1092),
              textScaler: TextScaler.linear(1.05),
            ),
            child: StudentSearchView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('Clear button tap clears search back to popular searches', (tester) async {
      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentSearchView(),
        ),
      );
      await tester.pumpAndSettle();

      // Type in search
      await tester.enterText(find.byType(TextField), 'Plant');
      await tester.pumpAndSettle();

      expect(find.text('Search Results'), findsOneWidget);
      expect(find.byIcon(PhosphorIcons.xCircle(PhosphorIconsStyle.fill)), findsOneWidget);

      // Tap clear icon
      await tester.tap(find.byIcon(PhosphorIcons.xCircle(PhosphorIconsStyle.fill)));
      await tester.pumpAndSettle();

      expect(find.text('Popular Searches'), findsOneWidget);
    });
  });

  group('StudentHomeView Search Integration Widget Tests', () {
    late StudentHomeController homeController;

    setUp(() {
      Get.testMode = true;
      Get.reset();
      homeController = StudentHomeController();
      Get.put(homeController);
      Get.lazyPut(() => StudentSearchController());
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('Renders search bar on StudentHomeView and allows tapping', (tester) async {
      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: Routes.STUDENT_HOME,
          getPages: [
            GetPage(name: Routes.STUDENT_HOME, page: () => const StudentHomeView()),
            GetPage(name: Routes.STUDENT_SEARCH, page: () => const StudentSearchView()),
          ],
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Search subject...'), findsOneWidget);

      // Tap search bar on home view
      await tester.tap(find.text('Search subject...'));
      await tester.pumpAndSettle();

      // Successfully navigates to StudentSearchView
      expect(find.text('Popular Searches'), findsOneWidget);
    });
  });
}
