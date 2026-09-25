import 'package:get/get.dart';
import 'individual_registration_controller.dart';

class IndividualRegistrationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndividualRegistrationController>(
      () => IndividualRegistrationController(),
    );
  }
}
