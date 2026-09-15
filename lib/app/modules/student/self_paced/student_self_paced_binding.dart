import 'package:get/get.dart';
import 'student_self_paced_controller.dart';

class StudentSelfPacedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentSelfPacedController>(
      () => StudentSelfPacedController(),
    );
  }
}
