import 'package:get/get.dart';
import 'parent_subscription_controller.dart';

class ParentSubscriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentSubscriptionController>(() => ParentSubscriptionController());
  }
}
