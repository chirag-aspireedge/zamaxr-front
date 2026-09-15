import 'package:get/get.dart';
import 'student_vr_videos_controller.dart';

class StudentVrVideosBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentVrVideosController>(
      () => StudentVrVideosController(),
    );
  }
}
