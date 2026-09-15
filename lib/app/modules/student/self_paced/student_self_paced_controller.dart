import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class StudentSelfPacedController extends GetxController {
  void onBackTap() {
    Get.back();
  }

  void onExploreNow() {
    if (Get.context != null) {
      Get.snackbar(
        'Explore Self-Paced Content',
        'Loading interactive courses and XR modules...',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void onImmersiveTap() {
    Get.toNamed(Routes.STUDENT_AR_LEARNING);
  }

  void onFlexibleTap() {
    if (Get.context != null) {
      Get.snackbar(
        '24/7 Access',
        'All self-paced materials and lessons are available anytime.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
