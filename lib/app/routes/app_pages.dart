// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
// Auth Views
import '../modules/auth/forgot_password/forgot_password_view.dart';
import '../modules/auth/login/login_view.dart';
import '../modules/auth/login_signup/login_signup_view.dart';
import '../modules/auth/onboarding/onboarding_view.dart';
import '../modules/auth/registration/registration_view.dart';
import '../modules/auth/select_role/select_role_view.dart';
import '../modules/auth/splash/splash_view.dart';

// Common Views
import '../modules/common/notifications/notification_view.dart';
import '../modules/common/profile/profile_view.dart';

// Institution Views
import '../modules/institution/class_detail/class_detail_view.dart';
import '../modules/institution/classes/classes_view.dart';
import '../modules/institution/create_class/create_class_view.dart';
import '../modules/institution/create_teacher/create_teacher_view.dart';
import '../modules/institution/dashboard/dashboard_view.dart';
import '../modules/institution/edit_teacher/edit_teacher_view.dart';
import '../modules/institution/lesson_detail/lesson_detail_view.dart';
import '../modules/institution/lessons/lessons_view.dart';
import '../modules/institution/quiz/quiz_view.dart';
import '../modules/institution/subjects/subjects_view.dart';
import '../modules/institution/subscription/subscription_view.dart';
import '../modules/institution/teacher_detail/teacher_detail_view.dart';
import '../modules/institution/teachers/teachers_view.dart';

// Teacher Views
import '../modules/teacher/ai_quiz/teacher_ai_quiz_view.dart';
import '../modules/teacher/create_lesson/teacher_create_lesson_view.dart';
import '../modules/teacher/create_quiz/teacher_create_quiz_view.dart';
import '../modules/teacher/dashboard/teacher_dashboard_view.dart';
import '../modules/teacher/edit_lesson/teacher_edit_lesson_view.dart';
import '../modules/teacher/home/teacher_home_view.dart';
import '../modules/teacher/introduction/teacher_introduction_view.dart';
import '../modules/teacher/lesson_detail/teacher_lesson_detail_view.dart';
import '../modules/teacher/lessons/teacher_lessons_view.dart';
import '../modules/teacher/manual_quiz/teacher_manual_quiz_view.dart';
import '../modules/teacher/registration/teacher_registration_view.dart';
import '../modules/teacher/review_quiz/teacher_review_quiz_view.dart';
import '../modules/teacher/quiz_loading/teacher_quiz_loading_view.dart';
import '../modules/teacher/final_quiz/teacher_final_quiz_view.dart';
import '../modules/teacher/quizzes/teacher_quizzes_view.dart';
import '../modules/teacher/students/teacher_students_view.dart';
import '../modules/teacher/student_detail/teacher_student_detail_view.dart';
import '../modules/teacher/profile/teacher_profile_view.dart';
import '../modules/teacher/leaderboard/teacher_leaderboard_view.dart';
import '../modules/teacher/onboarding/teacher_onboarding_binding.dart';
import '../modules/teacher/onboarding/teacher_onboarding_view.dart';

// Student Views
import '../modules/student/onboarding/student_onboarding_view.dart';
import '../modules/student/dashboard/student_dashboard_view.dart';
import '../modules/student/home/student_home_view.dart';
import '../modules/student/my_learning/student_my_learning_view.dart';
import '../modules/student/search/student_search_view.dart';
import '../modules/student/lesson_detail/student_lesson_detail_view.dart';
import '../modules/student/sub_lesson/student_sub_lesson_view.dart';
import '../modules/student/quiz/student_quiz_view.dart';
import '../modules/student/quiz_summary/student_quiz_summary_view.dart';
import '../modules/student/ar_learning/student_ar_learning_binding.dart';
import '../modules/student/ar_learning/student_ar_learning_view.dart';
import '../modules/student/vr_videos/student_vr_videos_binding.dart';
import '../modules/student/vr_videos/student_vr_videos_view.dart';
import '../modules/student/ai_tutor/student_ai_tutor_binding.dart';
import '../modules/student/ai_tutor/student_ai_tutor_view.dart';
import '../modules/student/rewards/student_rewards_binding.dart';
import '../modules/student/rewards/student_rewards_view.dart';
import '../modules/student/profile/student_profile_binding.dart';
import '../modules/student/profile/student_profile_view.dart';
import '../modules/student/subscription/student_subscription_binding.dart';
import '../modules/student/subscription/student_subscription_view.dart';
import '../modules/student/math_solver/student_math_solver_binding.dart';
import '../modules/student/math_solver/student_math_solver_view.dart';
import '../modules/student/self_paced/student_self_paced_binding.dart';
import '../modules/student/self_paced/student_self_paced_view.dart';
import '../modules/parent/onboarding/parent_onboarding_binding.dart';
import '../modules/parent/onboarding/parent_onboarding_view.dart';
import '../modules/parent/registration/parent_registration_binding.dart';
import '../modules/parent/registration/parent_registration_view.dart';
import '../modules/parent/home/parent_home_binding.dart';
import '../modules/parent/home/parent_home_view.dart';
import '../modules/parent/children_account/children_account_binding.dart';
import '../modules/parent/children_account/children_account_view.dart';
import '../modules/parent/add_child/add_child_binding.dart';
import '../modules/parent/add_child/add_child_view.dart';
import '../modules/parent/child_detail/child_detail_binding.dart';
import '../modules/parent/child_detail/child_detail_view.dart';
import '../modules/parent/profile/parent_profile_binding.dart';
import '../modules/parent/profile/parent_profile_view.dart';
import '../modules/parent/subscription/parent_subscription_binding.dart';
import '../modules/parent/subscription/parent_subscription_view.dart';
import '../modules/parent/quizzes/parent_quizzes_view.dart';
import '../modules/parent/create_quiz/parent_create_quiz_view.dart';
import '../modules/parent/ai_quiz/parent_ai_quiz_view.dart';
import '../modules/parent/manual_quiz/parent_manual_quiz_view.dart';
import '../modules/parent/review_quiz/parent_review_quiz_view.dart';
import '../modules/parent/quiz_loading/parent_quiz_loading_view.dart';
import '../modules/parent/final_quiz/parent_final_quiz_view.dart';
import '../modules/individual/home/individual_home_binding.dart';
import '../modules/individual/home/individual_home_view.dart';
import '../modules/individual/onboarding/individual_onboarding_binding.dart';
import '../modules/individual/onboarding/individual_onboarding_view.dart';
import '../modules/individual/quizzes/individual_quizzes_binding.dart';
import '../modules/individual/quizzes/individual_quizzes_view.dart';
import '../modules/individual/registration/individual_registration_binding.dart';
import '../modules/individual/registration/individual_registration_view.dart';

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const LOGIN_SIGNUP = _Paths.LOGIN_SIGNUP;
  static const LOGIN = _Paths.LOGIN;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const SELECT_ROLE = _Paths.SELECT_ROLE;
  static const REGISTRATION = _Paths.REGISTRATION;
  static const INDIVIDUAL_ONBOARDING = _Paths.INDIVIDUAL_ONBOARDING;
  static const INDIVIDUAL_REGISTRATION = _Paths.INDIVIDUAL_REGISTRATION;
  static const INDIVIDUAL_HOME = _Paths.INDIVIDUAL_HOME;
  static const INDIVIDUAL_QUIZZES = _Paths.INDIVIDUAL_QUIZZES;
  static const PARENT_ONBOARDING = _Paths.PARENT_ONBOARDING;
  static const PARENT_REGISTRATION = _Paths.PARENT_REGISTRATION;
  static const PARENT_HOME = _Paths.PARENT_HOME;
  static const PARENT_CHILDREN_ACCOUNT = _Paths.PARENT_CHILDREN_ACCOUNT;
  static const PARENT_ADD_CHILD = _Paths.PARENT_ADD_CHILD;
  static const PARENT_CHILD_DETAIL = _Paths.PARENT_CHILD_DETAIL;
  static const PARENT_PROFILE = _Paths.PARENT_PROFILE;
  static const PARENT_SUBSCRIPTION = _Paths.PARENT_SUBSCRIPTION;
  static const PARENT_QUIZZES = _Paths.PARENT_QUIZZES;
  static const PARENT_CREATE_QUIZ = _Paths.PARENT_CREATE_QUIZ;
  static const PARENT_AI_QUIZ = _Paths.PARENT_AI_QUIZ;
  static const PARENT_MANUAL_QUIZ = _Paths.PARENT_MANUAL_QUIZ;
  static const PARENT_REVIEW_QUIZ = _Paths.PARENT_REVIEW_QUIZ;
  static const PARENT_QUIZ_LOADING = _Paths.PARENT_QUIZ_LOADING;
  static const PARENT_FINAL_QUIZ = _Paths.PARENT_FINAL_QUIZ;
  static const STUDENT_ONBOARDING = _Paths.STUDENT_ONBOARDING;
  static const STUDENT_DASHBOARD = _Paths.STUDENT_DASHBOARD;
  static const STUDENT_HOME = _Paths.STUDENT_HOME;
  static const STUDENT_MY_LEARNING = _Paths.STUDENT_MY_LEARNING;
  static const STUDENT_SEARCH = _Paths.STUDENT_SEARCH;
  static const STUDENT_LESSON_DETAIL = _Paths.STUDENT_LESSON_DETAIL;
  static const STUDENT_SUB_LESSON = _Paths.STUDENT_SUB_LESSON;
  static const STUDENT_QUIZ = _Paths.STUDENT_QUIZ;
  static const STUDENT_QUIZ_SUMMARY = _Paths.STUDENT_QUIZ_SUMMARY;
  static const STUDENT_AR_LEARNING = _Paths.STUDENT_AR_LEARNING;
  static const STUDENT_VR_VIDEOS = _Paths.STUDENT_VR_VIDEOS;
  static const STUDENT_AI_TUTOR = _Paths.STUDENT_AI_TUTOR;
  static const STUDENT_REWARDS = _Paths.STUDENT_REWARDS;
  static const STUDENT_PROFILE = _Paths.STUDENT_PROFILE;
  static const STUDENT_SUBSCRIPTION = _Paths.STUDENT_SUBSCRIPTION;
  static const STUDENT_MATH_SOLVER = _Paths.STUDENT_MATH_SOLVER;
  static const STUDENT_SELF_PACED = _Paths.STUDENT_SELF_PACED;
  static const TEACHER_ONBOARDING = _Paths.TEACHER_ONBOARDING;
  static const TEACHER_INTRODUCTION = _Paths.TEACHER_INTRODUCTION;
  static const TEACHER_REGISTRATION = _Paths.TEACHER_REGISTRATION;
  static const TEACHER_DASHBOARD = _Paths.TEACHER_DASHBOARD;
  static const TEACHER_HOME = _Paths.TEACHER_HOME;
  static const TEACHER_LESSONS = _Paths.TEACHER_LESSONS;
  static const TEACHER_LESSON_DETAIL = _Paths.TEACHER_LESSON_DETAIL;
  static const TEACHER_CREATE_LESSON = _Paths.TEACHER_CREATE_LESSON;
  static const TEACHER_EDIT_LESSON = _Paths.TEACHER_EDIT_LESSON;
  static const TEACHER_CREATE_QUIZ = _Paths.TEACHER_CREATE_QUIZ;
  static const CREATE_QUIZ = _Paths.CREATE_QUIZ;
  static const TEACHER_MANUAL_QUIZ = _Paths.TEACHER_MANUAL_QUIZ;
  static const MANUAL_QUIZ = _Paths.MANUAL_QUIZ;
  static const TEACHER_AI_QUIZ = _Paths.TEACHER_AI_QUIZ;
  static const AI_QUIZ = _Paths.AI_QUIZ;
  static const TEACHER_REVIEW_QUIZ = _Paths.TEACHER_REVIEW_QUIZ;
  static const REVIEW_QUIZ = _Paths.REVIEW_QUIZ;
  static const TEACHER_QUIZ_LOADING = _Paths.TEACHER_QUIZ_LOADING;
  static const QUIZ_LOADING = _Paths.QUIZ_LOADING;
  static const TEACHER_FINAL_QUIZ = _Paths.TEACHER_FINAL_QUIZ;
  static const FINAL_QUIZ = _Paths.FINAL_QUIZ;
  static const TEACHER_QUIZZES = _Paths.TEACHER_QUIZZES;
  static const TEACHER_QUIZ_LIST = _Paths.TEACHER_QUIZ_LIST;
  static const TEACHER_STUDENTS = _Paths.TEACHER_STUDENTS;
  static const STUDENTS = _Paths.STUDENTS;
  static const TEACHER_STUDENT_DETAIL = _Paths.TEACHER_STUDENT_DETAIL;
  static const STUDENT_DETAIL = _Paths.STUDENT_DETAIL;
  static const TEACHER_PROFILE = _Paths.TEACHER_PROFILE;
  static const TEACHER_LEADERBOARD = _Paths.TEACHER_LEADERBOARD;
  static const LEADERBOARD = _Paths.LEADERBOARD;
  static const DASHBOARD = _Paths.DASHBOARD;
  static const CLASSES = _Paths.CLASSES;
  static const CLASS_DETAIL = _Paths.CLASS_DETAIL;
  static const CREATE_CLASS = _Paths.CREATE_CLASS;
  static const TEACHERS = _Paths.TEACHERS;
  static const TEACHER_DETAIL = _Paths.TEACHER_DETAIL;
  static const EDIT_TEACHER = _Paths.EDIT_TEACHER;
  static const CREATE_TEACHER = _Paths.CREATE_TEACHER;
  static const PROFILE = _Paths.PROFILE;
  static const SUBJECTS = _Paths.SUBJECTS;
  static const LESSONS = _Paths.LESSONS;
  static const LESSON_DETAIL = _Paths.LESSON_DETAIL;
  static const QUIZ = _Paths.QUIZ;
  static const SUBSCRIPTION = _Paths.SUBSCRIPTION;
  static const NOTIFICATIONS = _Paths.NOTIFICATIONS;
}

abstract class _Paths {
  _Paths._();
  static const SPLASH = '/splash';
  static const ONBOARDING = '/onboarding';
  static const LOGIN_SIGNUP = '/login-signup';
  static const LOGIN = '/login';
  static const FORGOT_PASSWORD = '/forgot-password';
  static const SELECT_ROLE = '/select-role';
  static const REGISTRATION = '/registration';
  static const INDIVIDUAL_ONBOARDING = '/individual/onboarding';
  static const INDIVIDUAL_REGISTRATION = '/individual/registration';
  static const INDIVIDUAL_HOME = '/individual/home';
  static const INDIVIDUAL_QUIZZES = '/individual/quizzes';
  static const PARENT_ONBOARDING = '/parent/onboarding';
  static const PARENT_REGISTRATION = '/parent/registration';
  static const PARENT_HOME = '/parent/home';
  static const PARENT_CHILDREN_ACCOUNT = '/parent/children-account';
  static const PARENT_ADD_CHILD = '/parent/add-child';
  static const PARENT_CHILD_DETAIL = '/parent/child-detail';
  static const PARENT_PROFILE = '/parent/profile';
  static const PARENT_SUBSCRIPTION = '/parent/subscription';
  static const PARENT_QUIZZES = '/parent/quizzes';
  static const PARENT_CREATE_QUIZ = '/parent/create-quiz';
  static const PARENT_AI_QUIZ = '/parent/ai-quiz';
  static const PARENT_MANUAL_QUIZ = '/parent/manual-quiz';
  static const PARENT_REVIEW_QUIZ = '/parent/review-quiz';
  static const PARENT_QUIZ_LOADING = '/parent/quiz-loading';
  static const PARENT_FINAL_QUIZ = '/parent/final-quiz';
  static const STUDENT_ONBOARDING = '/student/onboarding';
  static const STUDENT_DASHBOARD = '/student/dashboard';
  static const STUDENT_HOME = '/student/home';
  static const STUDENT_MY_LEARNING = '/student/my-learning';
  static const STUDENT_SEARCH = '/student/search';
  static const STUDENT_LESSON_DETAIL = '/student/lesson-detail';
  static const STUDENT_SUB_LESSON = '/student/sub-lesson';
  static const STUDENT_QUIZ = '/student/quiz';
  static const STUDENT_QUIZ_SUMMARY = '/student/quiz-summary';
  static const STUDENT_AR_LEARNING = '/student/ar-learning';
  static const STUDENT_VR_VIDEOS = '/student/vr-videos';
  static const STUDENT_AI_TUTOR = '/student/ai-tutor';
  static const STUDENT_REWARDS = '/student/rewards';
  static const STUDENT_PROFILE = '/student/profile';
  static const STUDENT_SUBSCRIPTION = '/student/subscription';
  static const STUDENT_MATH_SOLVER = '/student/math-solver';
  static const STUDENT_SELF_PACED = '/student/self-paced';
  static const TEACHER_ONBOARDING = '/teacher/onboarding';
  static const TEACHER_INTRODUCTION = '/teacher/introduction';
  static const TEACHER_REGISTRATION = '/teacher/registration';
  static const TEACHER_DASHBOARD = '/teacher/dashboard';
  static const TEACHER_HOME = '/teacher/home';
  static const TEACHER_LESSONS = '/teacher/lessons';
  static const TEACHER_LESSON_DETAIL = '/teacher/lesson-detail';
  static const TEACHER_CREATE_LESSON = '/teacher/create-lesson';
  static const TEACHER_EDIT_LESSON = '/teacher/edit-lesson';
  static const TEACHER_CREATE_QUIZ = '/teacher/create-quiz';
  static const CREATE_QUIZ = '/create-quiz';
  static const TEACHER_MANUAL_QUIZ = '/teacher/manual-quiz';
  static const MANUAL_QUIZ = '/manual-quiz';
  static const TEACHER_AI_QUIZ = '/teacher/ai-quiz';
  static const AI_QUIZ = '/ai-quiz';
  static const TEACHER_REVIEW_QUIZ = '/teacher/review-quiz';
  static const REVIEW_QUIZ = '/review-quiz';
  static const TEACHER_QUIZ_LOADING = '/teacher/quiz-loading';
  static const QUIZ_LOADING = '/quiz-loading';
  static const TEACHER_FINAL_QUIZ = '/teacher/final-quiz';
  static const FINAL_QUIZ = '/final-quiz';
  static const TEACHER_QUIZZES = '/teacher/quizzes';
  static const TEACHER_QUIZ_LIST = '/teacher/quiz-list';
  static const TEACHER_STUDENTS = '/teacher/students';
  static const STUDENTS = '/students';
  static const TEACHER_STUDENT_DETAIL = '/teacher/student-detail';
  static const STUDENT_DETAIL = '/student-detail';
  static const TEACHER_PROFILE = '/teacher-profile';
  static const TEACHER_LEADERBOARD = '/teacher-leaderboard';
  static const LEADERBOARD = '/leaderboard';
  static const DASHBOARD = '/dashboard';
  static const CLASSES = '/classes';
  static const CLASS_DETAIL = '/class-detail';
  static const CREATE_CLASS = '/create-class';
  static const TEACHERS = '/teachers';
  static const TEACHER_DETAIL = '/teacher-detail';
  static const EDIT_TEACHER = '/edit-teacher';
  static const CREATE_TEACHER = '/create-teacher';
  static const PROFILE = '/profile';
  static const SUBJECTS = '/subjects';
  static const LESSONS = '/lessons';
  static const LESSON_DETAIL = '/lesson-detail';
  static const QUIZ = '/quiz';
  static const SUBSCRIPTION = '/subscription';
  static const NOTIFICATIONS = '/notifications';
}

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN_SIGNUP,
      page: () => const LoginSignupView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SELECT_ROLE,
      page: () => const SelectRoleView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => const RegistrationView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_ONBOARDING,
      page: () => const ParentOnboardingView(),
      binding: ParentOnboardingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_REGISTRATION,
      page: () => const ParentRegistrationView(),
      binding: ParentRegistrationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_HOME,
      page: () => const ParentHomeView(),
      binding: ParentHomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_CHILDREN_ACCOUNT,
      page: () => const ChildrenAccountView(),
      binding: ChildrenAccountBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_ADD_CHILD,
      page: () => const AddChildView(),
      binding: AddChildBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_CHILD_DETAIL,
      page: () => const ChildDetailView(),
      binding: ChildDetailBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_PROFILE,
      page: () => const ParentProfileView(),
      binding: ParentProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_SUBSCRIPTION,
      page: () => const ParentSubscriptionView(),
      binding: ParentSubscriptionBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_QUIZZES,
      page: () => const ParentQuizzesView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_CREATE_QUIZ,
      page: () => const ParentCreateQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_AI_QUIZ,
      page: () => const ParentAiQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_MANUAL_QUIZ,
      page: () => const ParentManualQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_REVIEW_QUIZ,
      page: () => const ParentReviewQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_QUIZ_LOADING,
      page: () => const ParentQuizLoadingView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PARENT_FINAL_QUIZ,
      page: () => const ParentFinalQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.INDIVIDUAL_ONBOARDING,
      page: () => const IndividualOnboardingView(),
      binding: IndividualOnboardingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.INDIVIDUAL_REGISTRATION,
      page: () => const IndividualRegistrationView(),
      binding: IndividualRegistrationBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.INDIVIDUAL_HOME,
      page: () => const IndividualHomeView(),
      binding: IndividualHomeBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.INDIVIDUAL_QUIZZES,
      page: () => const IndividualQuizzesView(),
      binding: IndividualQuizzesBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_ONBOARDING,
      page: () => const StudentOnboardingView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_DASHBOARD,
      page: () => const StudentDashboardView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_HOME,
      page: () => const StudentHomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_MY_LEARNING,
      page: () => const StudentMyLearningView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_SEARCH,
      page: () => const StudentSearchView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_LESSON_DETAIL,
      page: () => const StudentLessonDetailView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_SUB_LESSON,
      page: () => const StudentSubLessonView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_QUIZ,
      page: () => const StudentQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_QUIZ_SUMMARY,
      page: () => const StudentQuizSummaryView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_AR_LEARNING,
      page: () => const StudentArLearningView(),
      binding: StudentArLearningBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_VR_VIDEOS,
      page: () => const StudentVrVideosView(),
      binding: StudentVrVideosBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_AI_TUTOR,
      page: () => const StudentAiTutorView(),
      binding: StudentAiTutorBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_REWARDS,
      page: () => const StudentRewardsView(),
      binding: StudentRewardsBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_PROFILE,
      page: () => const StudentProfileView(),
      binding: StudentProfileBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_SUBSCRIPTION,
      page: () => const StudentSubscriptionView(),
      binding: StudentSubscriptionBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_MATH_SOLVER,
      page: () => const StudentMathSolverView(),
      binding: StudentMathSolverBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_SELF_PACED,
      page: () => const StudentSelfPacedView(),
      binding: StudentSelfPacedBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_ONBOARDING,
      page: () => const TeacherOnboardingView(),
      binding: TeacherOnboardingBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_INTRODUCTION,
      page: () => const TeacherIntroductionView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_REGISTRATION,
      page: () => const TeacherRegistrationView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_DASHBOARD,
      page: () => const TeacherDashboardView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_HOME,
      page: () => const TeacherHomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_LESSONS,
      page: () => const TeacherLessonsView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_LESSON_DETAIL,
      page: () => const TeacherLessonDetailView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_CREATE_LESSON,
      page: () => const TeacherCreateLessonView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_EDIT_LESSON,
      page: () => const EditLessonView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_CREATE_QUIZ,
      page: () => const TeacherCreateQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CREATE_QUIZ,
      page: () => const TeacherCreateQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_MANUAL_QUIZ,
      page: () => const TeacherManualQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.MANUAL_QUIZ,
      page: () => const TeacherManualQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_AI_QUIZ,
      page: () => const TeacherAiQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.AI_QUIZ,
      page: () => const TeacherAiQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_REVIEW_QUIZ,
      page: () => const TeacherReviewQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.REVIEW_QUIZ,
      page: () => const TeacherReviewQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_QUIZ_LOADING,
      page: () => const TeacherQuizLoadingView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.QUIZ_LOADING,
      page: () => const TeacherQuizLoadingView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_FINAL_QUIZ,
      page: () => const TeacherFinalQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.FINAL_QUIZ,
      page: () => const TeacherFinalQuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_QUIZZES,
      page: () => const TeacherQuizzesView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_QUIZ_LIST,
      page: () => const TeacherQuizzesView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_STUDENTS,
      page: () => const TeacherStudentsView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENTS,
      page: () => const TeacherStudentsView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_STUDENT_DETAIL,
      page: () => const TeacherStudentDetailView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.STUDENT_DETAIL,
      page: () => const TeacherStudentDetailView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_PROFILE,
      page: () => const TeacherProfileView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_LEADERBOARD,
      page: () => const TeacherLeaderboardView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LEADERBOARD,
      page: () => const TeacherLeaderboardView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CLASSES,
      page: () => const ClassesView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CLASS_DETAIL,
      page: () => const ClassDetailView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CREATE_CLASS,
      page: () => const CreateClassView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHERS,
      page: () => const TeachersView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.TEACHER_DETAIL,
      page: () => const TeacherDetailView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.EDIT_TEACHER,
      page: () => const EditTeacherView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.CREATE_TEACHER,
      page: () => const CreateTeacherView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SUBJECTS,
      page: () => const SubjectsView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LESSONS,
      page: () => const LessonsView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.LESSON_DETAIL,
      page: () => const LessonDetailView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.QUIZ,
      page: () => const QuizView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.SUBSCRIPTION,
      page: () => const SubscriptionView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationView(),
      transition: Transition.fadeIn,
    ),
  ];
}








