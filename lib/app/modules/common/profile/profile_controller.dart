import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final RxString instituteName = 'Axcel Top Institute'.obs;
  final RxString selectedLanguage = 'English'.obs;
  final RxString subscriptionStatus = 'Active'.obs;

  // Personal Information Accordion State & Data
  final RxBool isPersonalInfoExpanded = false.obs;

  final RxString infoInstitutionName = 'ABC International School'.obs;
  final RxString infoInstitutionType = 'School'.obs;
  final RxString infoRegistrationNumber = 'INS-10294'.obs;
  final RxString infoOfficialEmail = 'info@abcschool.com'.obs;
  final RxString infoContactNumber = '+1 XXXXX XXXXX'.obs;

  void togglePersonalInfo() {
    isPersonalInfoExpanded.value = !isPersonalInfoExpanded.value;
  }

  void logout() {
    Get.offAllNamed(Routes.LOGIN_SIGNUP);
  }
}

