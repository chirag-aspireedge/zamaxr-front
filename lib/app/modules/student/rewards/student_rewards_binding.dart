import 'package:get/get.dart';
import 'student_rewards_controller.dart';

class StudentRewardsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentRewardsController>(
      () => StudentRewardsController(),
    );
  }
}
