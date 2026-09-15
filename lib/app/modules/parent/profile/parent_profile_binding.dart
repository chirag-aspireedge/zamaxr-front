import 'package:get/get.dart';
import 'parent_profile_controller.dart';

class ParentProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentProfileController>(() => ParentProfileController());
  }
}
