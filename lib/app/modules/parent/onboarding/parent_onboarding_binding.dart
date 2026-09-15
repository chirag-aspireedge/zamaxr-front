import 'package:get/get.dart';
import 'parent_onboarding_controller.dart';

class ParentOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ParentOnboardingController>(
      () => ParentOnboardingController(),
    );
  }
}
