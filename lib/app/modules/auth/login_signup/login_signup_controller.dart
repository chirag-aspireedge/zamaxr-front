import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class LoginSignupController extends GetxController {
  void onLoginPressed() {
    Get.toNamed(Routes.LOGIN);
  }

  void onSignupPressed() {
    Get.toNamed(Routes.SELECT_ROLE);
  }
}
