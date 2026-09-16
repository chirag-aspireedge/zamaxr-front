import 'package:get/get.dart';
// Auth Controllers
import '../modules/auth/forgot_password/forgot_password_controller.dart';
import '../modules/auth/login/login_controller.dart';
import '../modules/auth/login_signup/login_signup_controller.dart';
import '../modules/auth/onboarding/onboarding_controller.dart';
import '../modules/auth/registration/registration_controller.dart';
import '../modules/auth/select_role/select_role_controller.dart';
import '../modules/auth/splash/splash_controller.dart';

// Common Controllers
import '../modules/common/notifications/notification_controller.dart';
import '../modules/common/profile/profile_controller.dart';

// Institution Controllers
import '../modules/institution/class_detail/class_detail_controller.dart';
import '../modules/institution/classes/classes_controller.dart';
import '../modules/institution/create_class/create_class_controller.dart';
import '../modules/institution/create_teacher/create_teacher_controller.dart';
import '../modules/institution/dashboard/dashboard_controller.dart';
import '../modules/institution/edit_teacher/edit_teacher_controller.dart';
import '../modules/institution/home/home_controller.dart';
import '../modules/institution/subjects/subjects_controller.dart';
import '../modules/institution/subscription/subscription_controller.dart';
import '../modules/institution/teacher_detail/teacher_detail_controller.dart';
import '../modules/institution/teachers/teachers_controller.dart';

// Teacher Controllers
import '../modules/teacher/ai_quiz/teacher_ai_quiz_controller.dart';
import '../modules/teacher/create_lesson/teacher_create_lesson_controller.dart';
import '../modules/teacher/create_quiz/teacher_create_quiz_controller.dart';
import '../modules/teacher/dashboard/teacher_dashboard_controller.dart';
import '../modules/teacher/edit_lesson/teacher_edit_lesson_controller.dart';
import '../modules/teacher/home/teacher_home_controller.dart';
import '../modules/teacher/introduction/teacher_introduction_controller.dart';
import '../modules/teacher/onboarding/teacher_onboarding_controller.dart';
import '../modules/teacher/lesson_detail/teacher_lesson_detail_controller.dart';
import '../modules/teacher/lessons/teacher_lessons_controller.dart';
import '../modules/teacher/manual_quiz/teacher_manual_quiz_controller.dart';
import '../modules/teacher/registration/teacher_registration_controller.dart';
import '../modules/teacher/review_quiz/teacher_review_quiz_controller.dart';
import '../modules/teacher/quiz_loading/teacher_quiz_loading_controller.dart';
import '../modules/teacher/final_quiz/teacher_final_quiz_controller.dart';
import '../modules/teacher/quizzes/teacher_quizzes_controller.dart';
import '../modules/teacher/students/teacher_students_controller.dart';
import '../modules/teacher/student_detail/teacher_student_detail_controller.dart';
import '../modules/teacher/profile/teacher_profile_controller.dart';
import '../modules/teacher/leaderboard/teacher_leaderboard_controller.dart';

// Student Controllers
import '../modules/student/onboarding/student_onboarding_controller.dart';
import '../modules/student/dashboard/student_dashboard_controller.dart';
import '../modules/student/home/student_home_controller.dart';
import '../modules/student/my_learning/student_my_learning_controller.dart';
import '../modules/student/search/student_search_controller.dart';
import '../modules/student/lesson_detail/student_lesson_detail_controller.dart';
import '../modules/student/sub_lesson/student_sub_lesson_controller.dart';
import '../modules/student/quiz/student_quiz_controller.dart';
import '../modules/student/quiz_summary/student_quiz_summary_controller.dart';
import '../modules/student/rewards/student_rewards_controller.dart';
import '../modules/student/profile/student_profile_controller.dart';
import '../modules/student/subscription/student_subscription_controller.dart';
import '../modules/student/math_solver/student_math_solver_controller.dart';
import '../modules/student/self_paced/student_self_paced_controller.dart';

// Parent Controllers
import '../modules/parent/onboarding/parent_onboarding_controller.dart';
import '../modules/parent/registration/parent_registration_controller.dart';
import '../modules/parent/home/parent_home_controller.dart';
import '../modules/parent/children_account/children_account_controller.dart';
import '../modules/parent/add_child/add_child_controller.dart';
import '../modules/parent/child_detail/child_detail_controller.dart';
import '../modules/parent/profile/parent_profile_controller.dart';
import '../modules/parent/subscription/parent_subscription_controller.dart';

// Individual Controllers
import '../modules/individual/home/individual_home_controller.dart';
import '../modules/individual/onboarding/individual_onboarding_controller.dart';

class AllControllerBindings extends Bindings {
  @override
  void dependencies() {
    // Lazy put all controllers centrally as specified in ARCHITECTURE.md
    Get.lazyPut<TeacherLeaderboardController>(() => TeacherLeaderboardController(), fenix: true);
    Get.lazyPut<TeacherDashboardController>(() => TeacherDashboardController(), fenix: true);
    Get.lazyPut<TeacherHomeController>(() => TeacherHomeController(), fenix: true);
    Get.lazyPut<TeacherLessonsController>(() => TeacherLessonsController(), fenix: true);
    Get.lazyPut<TeacherQuizzesController>(() => TeacherQuizzesController(), fenix: true);
    Get.lazyPut<TeacherStudentsController>(() => TeacherStudentsController(), fenix: true);
    Get.lazyPut<TeacherStudentDetailController>(() => TeacherStudentDetailController(), fenix: true);
    Get.lazyPut<TeacherProfileController>(() => TeacherProfileController(), fenix: true);
    Get.lazyPut<TeacherLessonDetailController>(() => TeacherLessonDetailController(), fenix: true);
    Get.lazyPut<TeacherCreateLessonController>(() => TeacherCreateLessonController(), fenix: true);
    Get.lazyPut<EditLessonController>(() => EditLessonController(), fenix: true);
    Get.lazyPut<TeacherCreateQuizController>(() => TeacherCreateQuizController(), fenix: true);
    Get.lazyPut<TeacherManualQuizController>(() => TeacherManualQuizController(), fenix: true);
    Get.lazyPut<TeacherAiQuizController>(() => TeacherAiQuizController(), fenix: true);
    Get.lazyPut<TeacherReviewQuizController>(() => TeacherReviewQuizController(), fenix: true);
    Get.lazyPut<TeacherQuizLoadingController>(() => TeacherQuizLoadingController(), fenix: true);
    Get.lazyPut<TeacherFinalQuizController>(() => TeacherFinalQuizController(), fenix: true);
    Get.lazyPut<TeacherIntroductionController>(() => TeacherIntroductionController(), fenix: true);
    Get.lazyPut<TeacherOnboardingController>(() => TeacherOnboardingController(), fenix: true);
    Get.lazyPut<TeacherRegistrationController>(() => TeacherRegistrationController(), fenix: true);
    Get.lazyPut<StudentOnboardingController>(() => StudentOnboardingController(), fenix: true);
    Get.lazyPut<StudentDashboardController>(() => StudentDashboardController(), fenix: true);
    Get.lazyPut<StudentHomeController>(() => StudentHomeController(), fenix: true);
    Get.lazyPut<StudentMyLearningController>(() => StudentMyLearningController(), fenix: true);
    Get.lazyPut<StudentSearchController>(() => StudentSearchController(), fenix: true);
    Get.lazyPut<StudentLessonDetailController>(() => StudentLessonDetailController(), fenix: true);
    Get.lazyPut<StudentSubLessonController>(() => StudentSubLessonController(), fenix: true);
    Get.lazyPut<StudentQuizController>(() => StudentQuizController(), fenix: true);
    Get.lazyPut<StudentQuizSummaryController>(() => StudentQuizSummaryController(), fenix: true);
    Get.lazyPut<StudentRewardsController>(() => StudentRewardsController(), fenix: true);
    Get.lazyPut<StudentProfileController>(() => StudentProfileController(), fenix: true);
    Get.lazyPut<StudentSubscriptionController>(() => StudentSubscriptionController(), fenix: true);
    Get.lazyPut<StudentMathSolverController>(() => StudentMathSolverController(), fenix: true);
    Get.lazyPut<StudentSelfPacedController>(() => StudentSelfPacedController(), fenix: true);
    Get.lazyPut<ParentOnboardingController>(() => ParentOnboardingController(), fenix: true);
    Get.lazyPut<ParentRegistrationController>(() => ParentRegistrationController(), fenix: true);
    Get.lazyPut<ParentHomeController>(() => ParentHomeController(), fenix: true);
    Get.lazyPut<ChildrenAccountController>(() => ChildrenAccountController(), fenix: true);
    Get.lazyPut<AddChildController>(() => AddChildController(), fenix: true);
    Get.lazyPut<ChildDetailController>(() => ChildDetailController(), fenix: true);
    Get.lazyPut<ParentProfileController>(() => ParentProfileController(), fenix: true);
    Get.lazyPut<ParentSubscriptionController>(() => ParentSubscriptionController(), fenix: true);
    Get.lazyPut<IndividualHomeController>(() => IndividualHomeController(), fenix: true);
    Get.lazyPut<IndividualOnboardingController>(() => IndividualOnboardingController(), fenix: true);
    Get.lazyPut<SplashController>(() => SplashController(), fenix: true);
    Get.lazyPut<OnboardingController>(() => OnboardingController(), fenix: true);
    Get.lazyPut<LoginSignupController>(() => LoginSignupController(), fenix: true);
    Get.lazyPut<LoginController>(() => LoginController(), fenix: true);
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController(), fenix: true);
    Get.lazyPut<SelectRoleController>(() => SelectRoleController(), fenix: true);
    Get.lazyPut<RegistrationController>(() => RegistrationController(), fenix: true);
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<ClassesController>(() => ClassesController(), fenix: true);
    Get.lazyPut<ClassDetailController>(() => ClassDetailController(), fenix: true);
    Get.lazyPut<CreateClassController>(() => CreateClassController(), fenix: true);
    Get.lazyPut<TeachersController>(() => TeachersController(), fenix: true);
    Get.lazyPut<TeacherDetailController>(() => TeacherDetailController(), fenix: true);
    Get.lazyPut<EditTeacherController>(() => EditTeacherController(), fenix: true);
    Get.lazyPut<CreateTeacherController>(() => CreateTeacherController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);
    Get.lazyPut<SubjectsController>(() => SubjectsController(), fenix: true);
    Get.lazyPut<SubscriptionController>(() => SubscriptionController(), fenix: true);
    Get.lazyPut<NotificationController>(() => NotificationController(), fenix: true);
  }
}








