import 'package:get/get.dart';
import 'teacher_onboarding_controller.dart';

class TeacherOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TeacherOnboardingController>(() => TeacherOnboardingController());
  }
}
