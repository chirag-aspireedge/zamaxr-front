import 'package:get/get.dart';
import 'parent_home_controller.dart';

class ParentHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentHomeController>(
      () => ParentHomeController(),
    );
  }
}
