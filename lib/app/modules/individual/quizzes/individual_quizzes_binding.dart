import 'package:get/get.dart';
import 'individual_quizzes_controller.dart';

class IndividualQuizzesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndividualQuizzesController>(
      () => IndividualQuizzesController(),
    );
  }
}
