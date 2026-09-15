import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:zama_xr/app/modules/student/lesson_detail/student_lesson_detail_controller.dart';
import 'package:zama_xr/app/modules/student/lesson_detail/student_lesson_detail_model.dart';
import 'package:zama_xr/app/modules/student/lesson_detail/student_lesson_detail_view.dart';
import 'package:zama_xr/app/modules/student/search/student_search_controller.dart';
import 'package:zama_xr/app/routes/app_pages.dart';

void main() {
  group('StudentLessonDetailController Unit Tests', () {
    late StudentLessonDetailController controller;

    setUp(() {
      Get.reset();
      controller = Get.put(StudentLessonDetailController());
    });

    tearDown(() {
      Get.reset();
    });

    test('Initializes with default Figma lesson values', () {
      final lesson = controller.lesson.value;
      expect(lesson.title, 'Cell Structure');
      expect(lesson.subject, 'Biology');
      expect(lesson.gradeLevel, 'Class 8');
      expect(lesson.durationText, '12 min');
      expect(lesson.progress, 0.65);
      expect(lesson.progressPercentageText, '65% Complete');
      expect(lesson.metadataLine, 'Biology · Class 8');
      expect(lesson.aboutTitle, 'About This Lesson');
      expect(lesson.quizQuestionsCount, 10);
      expect(lesson.quizQuestionsText, '10 Questions');
    });

    test('Contains exactly 3 content items with correct initial statuses', () {
      final items = controller.lesson.value.contentItems;
      expect(items.length, 3);

      // Item 1: Video (Completed)
      expect(items[0].type, StudentLessonContentType.video);
      expect(items[0].title, 'Cell Structure Explained');
      expect(items[0].subtitle, 'Video · 08:42');
      expect(items[0].isCompleted, isTrue);
      expect(items[0].isLocked, isFalse);

      // Item 2: PDF (In Progress)
      expect(items[1].type, StudentLessonContentType.pdf);
      expect(items[1].title, 'Cell Structure Notes');
      expect(items[1].subtitle, 'PDF Document');
      expect(items[1].isInProgress, isTrue);
      expect(items[1].isLocked, isFalse);

      // Item 3: Audio (Locked)
      expect(items[2].type, StudentLessonContentType.audio);
      expect(items[2].title, 'Cell Structure Summary');
      expect(items[2].subtitle, 'Audio · 03:15');
      expect(items[2].isLocked, isTrue);
      expect(items[2].cardOpacity, 0.7);
    });

    test('Triggers onStartQuiz, onContentItemTap, onExploreAr, onExperienceVr safely', () {
      expect(() => controller.onStartQuiz(), returnsNormally);
      expect(
        () => controller.onContentItemTap(controller.lesson.value.contentItems[0]),
        returnsNormally,
      );
      expect(
        () => controller.onContentItemTap(controller.lesson.value.contentItems[2]),
        returnsNormally,
      );
      expect(() => controller.onExploreAr(), returnsNormally);
      expect(() => controller.onExperienceVr(), returnsNormally);
    });
  });

  group('StudentLessonDetailView Widget Tests', () {
    setUp(() {
      Get.reset();
      Get.put(StudentLessonDetailController());
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('Renders all Figma sections, headings, badges, and cards', (tester) async {
      tester.view.physicalSize = const Size(402, 1306);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentLessonDetailView(),
        ),
      );
      await tester.pumpAndSettle();

      // Top App Bar
      expect(find.text('Lesson Details'), findsOneWidget);

      // 1. Hero Section
      expect(find.text('Biology · Class 8'), findsOneWidget);
      expect(find.text('12 min'), findsOneWidget);
      expect(find.text('Cell Structure'), findsOneWidget);
      expect(find.text('Your Progress'), findsOneWidget);
      expect(find.text('65% Complete'), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);

      // 2. About Section
      expect(find.text('About This Lesson'), findsOneWidget);
      expect(
        find.textContaining('Explore the structure and functions of cells'),
        findsOneWidget,
      );

      // 3. Quiz Section
      expect(find.text('Test Your Knowledge'), findsOneWidget);
      expect(find.text('10 Questions'), findsOneWidget);
      expect(find.text('START QUIZ'), findsOneWidget);

      // 4. Lesson Content Section
      expect(find.text('Lesson Content'), findsOneWidget);
      expect(find.text('Cell Structure Explained'), findsOneWidget);
      expect(find.text('Video · 08:42'), findsOneWidget);
      expect(find.text('Cell Structure Notes'), findsOneWidget);
      expect(find.text('PDF Document'), findsOneWidget);
      expect(find.text('Cell Structure Summary'), findsOneWidget);
      expect(find.text('Audio · 03:15'), findsOneWidget);

      // 5. Interactive Learning Section
      expect(find.text('Interactive Learning'), findsOneWidget);
      expect(find.text('Explore in AR'), findsOneWidget);
      expect(find.text('Experience in VR'), findsOneWidget);
    });

    testWidgets('Tapping action buttons triggers controller handlers', (tester) async {
      tester.view.physicalSize = const Size(402, 1306);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: StudentLessonDetailView(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Start Quiz
      await tester.tap(find.text('START QUIZ'));
      await tester.pump();

      // Tap Video Content Item
      await tester.tap(find.text('Cell Structure Explained'));
      await tester.pump();

      // Tap Locked Audio Content Item
      await tester.tap(find.text('Cell Structure Summary'));
      await tester.pump();

      // Tap Explore in AR
      await tester.ensureVisible(find.text('Explore in AR'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Explore in AR'), warnIfMissed: false);
      await tester.pump();

      // Tap Experience in VR
      await tester.ensureVisible(find.text('Experience in VR'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Experience in VR'), warnIfMissed: false);
      await tester.pump();

      // Settle all snackbar timers
      await tester.pumpAndSettle(const Duration(seconds: 5));
    });

    testWidgets('Renders cleanly on narrow screen (320px) without overflow', (tester) async {
      tester.view.physicalSize = const Size(320, 1306);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const GetMaterialApp(
          home: MediaQuery(
            data: MediaQueryData(
              size: Size(320, 1306),
              textScaler: TextScaler.linear(1.05),
            ),
            child: StudentLessonDetailView(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });

  group('StudentSearch to StudentLessonDetail Navigation Tests', () {
    setUp(() {
      Get.reset();
      Get.put(StudentSearchController());
      Get.put(StudentLessonDetailController());
    });

    tearDown(() {
      Get.reset();
    });

    testWidgets('Tapping Continue Lesson on search result navigates to Lesson Detail', (tester) async {
      final searchController = Get.find<StudentSearchController>();
      searchController.selectPopularSearch('Photosynthesis');

      await tester.pumpWidget(
        GetMaterialApp(
          initialRoute: Routes.STUDENT_SEARCH,
          getPages: AppPages.routes,
        ),
      );
      await tester.pumpAndSettle();

      // Find Continue Lesson CTA button and tap
      final continueButton = find.text('Continue Lesson');
      expect(continueButton, findsOneWidget);
      await tester.tap(continueButton);
      await tester.pumpAndSettle();

      // Should now show Lesson Details screen
      expect(find.text('Lesson Details'), findsOneWidget);
      expect(find.text('About This Lesson'), findsOneWidget);
    });
  });
}
