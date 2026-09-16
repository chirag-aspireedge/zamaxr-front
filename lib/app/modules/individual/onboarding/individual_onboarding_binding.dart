import 'package:get/get.dart';
import 'individual_onboarding_controller.dart';

class IndividualOnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndividualOnboardingController>(
      () => IndividualOnboardingController(),
    );
  }
}
