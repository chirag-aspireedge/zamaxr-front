import 'package:get/get.dart';
import 'student_math_solver_controller.dart';

class StudentMathSolverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentMathSolverController>(
      () => StudentMathSolverController(),
    );
  }
}
