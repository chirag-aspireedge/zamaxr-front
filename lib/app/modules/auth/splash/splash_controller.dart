import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final RxDouble logoOpacity = 0.0.obs;
  final RxDouble logoScale = 0.85.obs;

  @override
  void onInit() {
    super.onInit();
    _startAnimation();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 150));
    logoOpacity.value = 1.0;
    logoScale.value = 1.0;
    await Future.delayed(const Duration(milliseconds: 2000));
    Get.offNamed(Routes.LOGIN_SIGNUP);
  }
}
