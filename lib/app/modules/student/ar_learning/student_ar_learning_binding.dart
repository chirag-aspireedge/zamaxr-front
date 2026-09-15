import 'package:get/get.dart';
import 'student_ar_learning_controller.dart';

class StudentArLearningBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentArLearningController>(
      () => StudentArLearningController(),
    );
  }
}
