import 'package:get/get.dart';

class TeacherDashboardController extends GetxController {
  final RxInt currentTabIndex = 0.obs;

  void changeTab(int index) {
    currentTabIndex.value = index;
  }
}
