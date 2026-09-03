import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

enum UserRole {
  student,
  teacher,
  parent,
  institution,
  individual,
}

class RoleItem {
  final UserRole role;
  final String title;
  final String description;

  const RoleItem({
    required this.role,
    required this.title,
    required this.description,
  });
}

class SelectRoleController extends GetxController {
  final Rx<UserRole> selectedRole = UserRole.institution.obs;

  final List<RoleItem> roles = const [
    RoleItem(
      role: UserRole.student,
      title: 'Student',
      description: 'Access courses, join classes, and track your progress.',
    ),
    RoleItem(
      role: UserRole.teacher,
      title: 'Teacher',
      description: 'Manage your classes, grade students, and create content.',
    ),
    RoleItem(
      role: UserRole.parent,
      title: 'Parent',
      description: 'Monitor student progress and stay connected with the school.',
    ),
    RoleItem(
      role: UserRole.institution,
      title: 'Institution',
      description: 'Manage your institution, teachers, students and classes.',
    ),
    RoleItem(
      role: UserRole.individual,
      title: 'Individual',
      description: 'Monitor student progress and stay connected with the school.',
    ),
  ];

  void selectRole(UserRole role) {
    selectedRole.value = role;
  }

  void continueWithRole() {
    if (selectedRole.value == UserRole.teacher) {
      Get.toNamed(Routes.TEACHER_INTRODUCTION);
    } else {
      Get.toNamed(Routes.REGISTRATION, arguments: selectedRole.value);
    }
  }
}
