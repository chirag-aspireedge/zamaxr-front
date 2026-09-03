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

abstract class Routes {
  Routes._();
  static const SPLASH = _Paths.SPLASH;
  static const ONBOARDING = _Paths.ONBOARDING;
  static const LOGIN_SIGNUP = _Paths.LOGIN_SIGNUP;
  static const LOGIN = _Paths.LOGIN;
  static const FORGOT_PASSWORD = _Paths.FORGOT_PASSWORD;
  static const SELECT_ROLE = _Paths.SELECT_ROLE;
  static const REGISTRATION = _Paths.REGISTRATION;
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
  static const TEACHER_PROFILE = '/teacher/profile';
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








