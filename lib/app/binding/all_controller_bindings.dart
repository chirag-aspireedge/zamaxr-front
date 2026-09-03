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

class AllControllerBindings extends Bindings {
  @override
  void dependencies() {
    // Lazy put all controllers centrally as specified in ARCHITECTURE.md
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
    Get.lazyPut<TeacherRegistrationController>(() => TeacherRegistrationController(), fenix: true);
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








