import 'package:get/get.dart';
import 'child_detail_controller.dart';

class ChildDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChildDetailController>(() => ChildDetailController());
  }
}
