import 'package:get/get.dart';
import 'student_ai_tutor_controller.dart';

class StudentAiTutorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentAiTutorController>(
      () => StudentAiTutorController(),
    );
  }
}
