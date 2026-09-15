import 'package:get/get.dart';
import 'student_subscription_controller.dart';

class StudentSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentSubscriptionController>(
      () => StudentSubscriptionController(),
    );
  }
}
