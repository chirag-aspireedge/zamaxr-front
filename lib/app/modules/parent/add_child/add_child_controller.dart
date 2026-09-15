import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../home/parent_home_controller.dart';

class AddChildController extends GetxController {
  final fullNameController = TextEditingController();
  final ageController = TextEditingController();

  final Rx<String?> selectedClass = Rx<String?>(null);

  final List<String> classOptions = [
    'Kindergarten',
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
    'Class 6',
    'Class 7',
    'Class 8',
    'Class 9',
    'Class 10',
    'Class 11',
    'Class 12',
  ];

  void selectClass(String className) {
    selectedClass.value = className;
  }

  void submitChild() {
    final name = fullNameController.text.trim();
    final ageStr = ageController.text.trim();
    final grade = selectedClass.value;

    if (name.isEmpty) {
      Get.snackbar(
        'Full Name Required',
        'Please enter your child’s full name',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (ageStr.isEmpty) {
      Get.snackbar(
        'Age Required',
        'Please enter your child’s age',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final age = int.tryParse(ageStr);
    if (age == null || age <= 0 || age > 25) {
      Get.snackbar(
        'Valid Age Required',
        'Please enter a valid age (1-25)',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (grade == null || grade.isEmpty) {
      Get.snackbar(
        'Class / Grade Required',
        'Please select a class or grade for your child',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Add child to ParentHomeController if initialized
    if (Get.isRegistered<ParentHomeController>()) {
      final parentHome = Get.find<ParentHomeController>();
      parentHome.children.add(
        ChildProgressModel(
          id: name.toLowerCase().replaceAll(' ', '_'),
          name: name,
          gradeAndSchool: '$grade • Greenview Academy',
          avatar: 'assets/images/user_avatar.png',
          status: 'Active',
          curriculumLessons: '0/15 Lessons (0%)',
          progressPercent: 0.0,
          recentActivity: 'Just enrolled • Ready to explore',
          recentIcon: Icons.star_border_rounded,
        ),
      );
    }

    Get.snackbar(
      'Profile Created!',
      '$name’s profile has been set up successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E5E9B),
      colorText: Colors.white,
    );

    // Return to Parent Home
    Get.offAllNamed(Routes.PARENT_HOME);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    ageController.dispose();
    super.onClose();
  }
}
