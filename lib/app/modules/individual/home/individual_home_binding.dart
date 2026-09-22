import 'package:get/get.dart';
import '../../student/search/student_search_controller.dart';
import 'individual_home_controller.dart';

class IndividualHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IndividualHomeController>(
      () => IndividualHomeController(),
    );
    Get.lazyPut<StudentSearchController>(
      () => StudentSearchController(),
    );
  }
}
