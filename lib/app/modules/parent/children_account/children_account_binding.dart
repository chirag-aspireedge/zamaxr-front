import 'package:get/get.dart';
import 'children_account_controller.dart';

class ChildrenAccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChildrenAccountController>(
      () => ChildrenAccountController(),
    );
  }
}
