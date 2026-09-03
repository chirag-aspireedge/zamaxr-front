import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:remixicon/remixicon.dart';
import '../../../routes/app_pages.dart';

class TeacherIntroFeatureItem {
  final String title;
  final String description;
  final IconData icon;

  const TeacherIntroFeatureItem({
    required this.title,
    required this.description,
    required this.icon,
  });
}

class TeacherIntroductionController extends GetxController {
  final List<TeacherIntroFeatureItem> features = [
    TeacherIntroFeatureItem(
      title: 'Create Lessons',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      icon: PhosphorIcons.chalkboardTeacher(PhosphorIconsStyle.regular),
    ),
    const TeacherIntroFeatureItem(
      title: 'Build Quizzes',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      icon: Remix.parent_line,
    ),
    const TeacherIntroFeatureItem(
      title: 'Add Learning Content',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      icon: Remix.bank_line,
    ),
    const TeacherIntroFeatureItem(
      title: 'AR & VR Learning',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      icon: Remix.admin_line,
    ),
  ];

  void onContinue() {
    Get.toNamed(Routes.TEACHER_REGISTRATION);
  }
}
