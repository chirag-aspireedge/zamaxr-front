import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';
import '../quizzes/teacher_quiz_model.dart';
import 'teacher_leaderboard_model.dart';

class TeacherLeaderboardController extends GetxController {
  final RxString selectedPeriod = 'This Week'.obs;
  final RxString title = 'Review AI Quiz'.obs;
  final RxString subtitle = 'Grade 8 – A • 32 Students'.obs;

  final RxInt participationPercentage = 78.obs;
  final RxString participationText =
      '25 of 32 students participated this week'.obs;

  // Podium (Top 3)
  final Rx<LeaderboardStudentModel> rank1Student = const LeaderboardStudentModel(
    rank: 1,
    name: 'Michael C.',
    score: '2,450',
    subtitle: 'Top performer',
    avatarAsset: AppAssets.studentAvatarMichael,
    delta: '1',
    trend: LeaderboardTrend.up,
  ).obs;

  final Rx<LeaderboardStudentModel> rank2Student = const LeaderboardStudentModel(
    rank: 2,
    name: 'Sarah J.',
    score: '2,150',
    subtitle: 'Consistent contributor',
    avatarAsset: AppAssets.studentAvatarSarah,
    delta: '1',
    trend: LeaderboardTrend.up,
  ).obs;

  final Rx<LeaderboardStudentModel> rank3Student = const LeaderboardStudentModel(
    rank: 3,
    name: 'Emma P.',
    score: '2,010',
    subtitle: 'Discussion active',
    avatarAsset: AppAssets.studentAvatarOlivia,
    delta: '2',
    trend: LeaderboardTrend.up,
  ).obs;

  // Ranked List (Ranks 4, 5, 6)
  final RxList<LeaderboardStudentModel> rankedList =
      <LeaderboardStudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args is Map) {
      if (args['quiz'] is TeacherQuizModel) {
        final TeacherQuizModel q = args['quiz'];
        title.value = q.title;
        if (q.assignedClass != null && q.assignedClass!.isNotEmpty) {
          subtitle.value = '${q.assignedClass} • 32 Students';
        }
      } else if (args['title'] != null) {
        title.value = args['title'].toString();
      }
    }

    _loadDataForPeriod('This Week');
  }

  void _loadDataForPeriod(String period) {
    selectedPeriod.value = period;

    if (period == 'This Week') {
      rank1Student.value = const LeaderboardStudentModel(
        rank: 1,
        name: 'Michael C.',
        score: '2,450',
        subtitle: 'Top performer',
        avatarAsset: AppAssets.studentAvatarMichael,
        delta: '1',
        trend: LeaderboardTrend.up,
      );

      rank2Student.value = const LeaderboardStudentModel(
        rank: 2,
        name: 'Sarah J.',
        score: '2,150',
        subtitle: 'Consistent contributor',
        avatarAsset: AppAssets.studentAvatarSarah,
        delta: '1',
        trend: LeaderboardTrend.up,
      );

      rank3Student.value = const LeaderboardStudentModel(
        rank: 3,
        name: 'Emma P.',
        score: '2,010',
        subtitle: 'Discussion active',
        avatarAsset: AppAssets.studentAvatarOlivia,
        delta: '2',
        trend: LeaderboardTrend.up,
      );

      participationPercentage.value = 78;
      participationText.value = '25 of 32 students participated this week';

      rankedList.assignAll([
        const LeaderboardStudentModel(
          rank: 4,
          name: 'James Davis',
          score: '1,950',
          subtitle: 'Consistent contributor',
          avatarAsset: AppAssets.userAvatar,
          delta: '2',
          trend: LeaderboardTrend.up,
        ),
        const LeaderboardStudentModel(
          rank: 5,
          name: 'Olivia Wilson',
          score: '1,820',
          subtitle: 'Group project lead',
          avatarAsset: AppAssets.studentAvatarOlivia,
          delta: '-',
          trend: LeaderboardTrend.neutral,
        ),
        const LeaderboardStudentModel(
          rank: 6,
          name: 'Ethan Moore',
          score: '1,790',
          subtitle: 'Discussion active',
          avatarAsset: AppAssets.studentAvatarSarah,
          delta: '1',
          trend: LeaderboardTrend.down,
        ),
      ]);
    } else {
      // This Month
      rank1Student.value = const LeaderboardStudentModel(
        rank: 1,
        name: 'Sarah J.',
        score: '9,850',
        subtitle: 'Monthly Leader',
        avatarAsset: AppAssets.studentAvatarSarah,
        delta: '1',
        trend: LeaderboardTrend.up,
      );

      rank2Student.value = const LeaderboardStudentModel(
        rank: 2,
        name: 'Michael C.',
        score: '9,420',
        subtitle: 'High accuracy',
        avatarAsset: AppAssets.studentAvatarMichael,
        delta: '1',
        trend: LeaderboardTrend.down,
      );

      rank3Student.value = const LeaderboardStudentModel(
        rank: 3,
        name: 'James Davis',
        score: '8,990',
        subtitle: 'Consistent contributor',
        avatarAsset: AppAssets.userAvatar,
        delta: '3',
        trend: LeaderboardTrend.up,
      );

      participationPercentage.value = 94;
      participationText.value = '30 of 32 students participated this month';

      rankedList.assignAll([
        const LeaderboardStudentModel(
          rank: 4,
          name: 'Emma P.',
          score: '8,760',
          subtitle: 'Discussion active',
          avatarAsset: AppAssets.studentAvatarOlivia,
          delta: '1',
          trend: LeaderboardTrend.down,
        ),
        const LeaderboardStudentModel(
          rank: 5,
          name: 'Olivia Wilson',
          score: '8,410',
          subtitle: 'Group project lead',
          avatarAsset: AppAssets.studentAvatarOlivia,
          delta: '-',
          trend: LeaderboardTrend.neutral,
        ),
        const LeaderboardStudentModel(
          rank: 6,
          name: 'Ethan Moore',
          score: '8,120',
          subtitle: 'Rising star',
          avatarAsset: AppAssets.studentAvatarSarah,
          delta: '2',
          trend: LeaderboardTrend.up,
        ),
      ]);
    }
  }

  void onSelectPeriod(String period) {
    if (selectedPeriod.value != period) {
      _loadDataForPeriod(period);
    }
  }

  void onBack() {
    if (Get.testMode || Get.context == null) return;
    Get.back();
  }

  void onStudentTap(LeaderboardStudentModel student) {
    if (Get.testMode || Get.context == null) return;

    Get.toNamed(
      Routes.TEACHER_STUDENT_DETAIL,
      arguments: {
        'name': student.name,
      },
    );
  }

  void onViewAllStudents() {
    if (Get.testMode || Get.context == null) return;

    Get.toNamed(Routes.TEACHER_STUDENTS);
  }
}
