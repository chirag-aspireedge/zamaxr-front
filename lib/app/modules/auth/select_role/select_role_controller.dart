import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

enum UserRole {
  institution,
  parent,
  individual,
  student,
  teacher,
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
      description:
          "Monitor your child's progress, stay connected with the school, and explore Interactive Quizzes, AR, VR and E-mmerx Professional Courses.",
    ),
    RoleItem(
      role: UserRole.institution,
      title: 'Institution / Private Tutors',
      description: 'Manage your institution, teachers, students and classes.',
    ),
    RoleItem(
      role: UserRole.individual,
      title: 'Individual',
      description:
          'Explore AR, VR, AI Tutor, Math Solver, Interactive Quizzes and E-mmerx Professional training courses at your own pace.',
    ),
  ];

  void selectRole(UserRole role) {
    selectedRole.value = role;
  }

  void continueWithRole() {
    if (selectedRole.value == UserRole.teacher) {
      Get.toNamed(Routes.TEACHER_ONBOARDING);
    } else if (selectedRole.value == UserRole.student) {
      Get.toNamed(Routes.STUDENT_ONBOARDING);
    } else if (selectedRole.value == UserRole.parent) {
      Get.toNamed(Routes.PARENT_ONBOARDING);
    } else if (selectedRole.value == UserRole.individual) {
      Get.toNamed(Routes.INDIVIDUAL_ONBOARDING);
    } else {
      Get.toNamed(Routes.REGISTRATION, arguments: selectedRole.value);
    }
  }
}
