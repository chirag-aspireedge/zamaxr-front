import 'package:get/get.dart';
import 'individual_home_controller.dart';

class IndividualHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndividualHomeController>(
      () => IndividualHomeController(),
    );
  }
}
