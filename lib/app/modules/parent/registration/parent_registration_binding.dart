import 'package:get/get.dart';
import 'parent_registration_controller.dart';

class ParentRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentRegistrationController>(() => ParentRegistrationController());
  }
}
