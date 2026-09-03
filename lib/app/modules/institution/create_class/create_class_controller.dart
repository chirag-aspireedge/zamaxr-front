import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import 'create_class_model.dart';

class CreateClassController extends GetxController {
  // Step indicator: 0 = Class Details, 1 = Assign Teacher, 2 = Review Class
  final RxInt currentStep = 0.obs;

  // Step 1 Controllers
  final TextEditingController classNameController =
      TextEditingController(text: 'Class 1');
  final TextEditingController gradeLevelController =
      TextEditingController(text: 'Grade 5');
  final TextEditingController subjectController =
      TextEditingController(text: 'Mathematics');
  final TextEditingController descriptionController = TextEditingController(
      text: 'Lorem ipsum is simply dummy text of the printing.');

  // Step 2 Search & Selection
  final TextEditingController searchTeacherController = TextEditingController();
  final RxString searchTeacherQuery = ''.obs;
  final RxString selectedTeacherId = '1'.obs;

  // Sample teachers list
  final List<AssignTeacherModel> allTeachers = const [
    AssignTeacherModel(
      id: '1',
      name: 'Sarah Johnson',
      subjectTitle: 'Mathematics Teacher',
      initials: 'SJ',
    ),
    AssignTeacherModel(
      id: '2',
      name: 'David Smith',
      subjectTitle: 'Science Teacher',
      initials: 'DS',
    ),
    AssignTeacherModel(
      id: '3',
      name: 'Emily Davis',
      subjectTitle: 'English Teacher',
      initials: 'ED',
    ),
    AssignTeacherModel(
      id: '4',
      name: 'David Smith',
      subjectTitle: 'Science Teacher',
      initials: 'DS',
    ),
  ];

  List<AssignTeacherModel> get filteredTeachers {
    final query = searchTeacherQuery.value.trim().toLowerCase();
    if (query.isEmpty) return allTeachers;
    return allTeachers
        .where((t) =>
            t.name.toLowerCase().contains(query) ||
            t.subjectTitle.toLowerCase().contains(query))
        .toList();
  }

  AssignTeacherModel get selectedTeacher {
    return allTeachers.firstWhere(
      (t) => t.id == selectedTeacherId.value,
      orElse: () => allTeachers.first,
    );
  }

  @override
  void onInit() {
    super.onInit();
    searchTeacherController.addListener(() {
      searchTeacherQuery.value = searchTeacherController.text;
    });
  }

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    } else {
      Get.back();
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step <= 2) {
      currentStep.value = step;
    }
  }

  void selectTeacher(String id) {
    selectedTeacherId.value = id;
  }

  void createClass() {
    Get.snackbar(
      'Success',
      'Class "${classNameController.text}" created successfully!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 2),
    );
    Future.delayed(const Duration(milliseconds: 600), () {
      Get.offNamedUntil(Routes.DASHBOARD, (route) => false);
    });
  }

  @override
  void onClose() {
    classNameController.dispose();
    gradeLevelController.dispose();
    subjectController.dispose();
    descriptionController.dispose();
    searchTeacherController.dispose();
    super.onClose();
  }
}
