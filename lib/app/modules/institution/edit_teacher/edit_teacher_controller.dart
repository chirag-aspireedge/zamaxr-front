import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../teachers/teachers_model.dart';

class AssignedClassEditItem {
  final String id;
  final String title;
  final String subject;
  final int studentsCount;
  final RxBool isSelected;

  AssignedClassEditItem({
    required this.id,
    required this.title,
    required this.subject,
    required this.studentsCount,
    bool isSelected = true,
  }) : isSelected = isSelected.obs;
}

class EditTeacherController extends GetxController {
  late final Rx<TeacherItem> teacher;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController skillInputController = TextEditingController();

  final RxList<String> skills = <String>['Mathematics'].obs;
  final RxList<AssignedClassEditItem> assignedClasses =
      <AssignedClassEditItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is TeacherItem) {
      teacher = (Get.arguments as TeacherItem).obs;
    } else {
      teacher = TeacherItem(
        id: '1',
        name: 'Sarah Johnson',
        subjectTitle: 'Mathematics Teacher',
        classCountText: '3 Classes',
        isOnline: true,
        phone: '+91 1234567890',
        email: 'sarah@dummy.com',
        avatarAsset: 'assets/images/teacher_avatar.png',
        teacherIdCode: 'TCH-1024',
        assignedClass: 'Class -8',
        assignedSubject: 'Mathematics',
        studentsCount: 32,
      ).obs;
    }

    nameController.text = teacher.value.name;
    phoneController.text = teacher.value.phone;
    emailController.text = teacher.value.email;

    assignedClasses.assignAll([
      AssignedClassEditItem(
        id: '1',
        title: teacher.value.assignedClass.isNotEmpty
            ? teacher.value.assignedClass
            : 'Class -8',
        subject: teacher.value.assignedSubject.isNotEmpty
            ? teacher.value.assignedSubject
            : 'Mathematics',
        studentsCount: teacher.value.studentsCount > 0
            ? teacher.value.studentsCount
            : 32,
        isSelected: true,
      ),
      AssignedClassEditItem(
        id: '2',
        title: 'Class -A',
        subject: 'Mathematics',
        studentsCount: 32,
        isSelected: true,
      ),
    ]);
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    skillInputController.dispose();
    super.onClose();
  }

  void addSkill(String skill) {
    final trimmed = skill.trim();
    if (trimmed.isNotEmpty && !skills.contains(trimmed)) {
      skills.add(trimmed);
      skillInputController.clear();
    }
  }

  void removeSkill(String skill) {
    skills.remove(skill);
  }

  void toggleClassSelection(AssignedClassEditItem item) {
    item.isSelected.value = !item.isSelected.value;
  }

  void updatePhoto() {
    Get.snackbar(
      'Update Photo',
      'Select a new photo for ${nameController.text}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0E3856),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void saveChanges() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        'Validation Error',
        'Please enter teacher name',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      );
      return;
    }

    // Update teacher item
    teacher.value = TeacherItem(
      id: teacher.value.id,
      name: nameController.text.trim(),
      subjectTitle: teacher.value.subjectTitle,
      classCountText: teacher.value.classCountText,
      isOnline: teacher.value.isOnline,
      avatarAsset: teacher.value.avatarAsset,
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      teacherIdCode: teacher.value.teacherIdCode,
      assignedClass: teacher.value.assignedClass,
      assignedSubject: teacher.value.assignedSubject,
      studentsCount: teacher.value.studentsCount,
    );

    Get.back(result: teacher.value);
    Get.snackbar(
      'Success',
      'Changes saved successfully',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF20E679),
      colorText: const Color(0xFF0E3856),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  void confirmDeleteTeacher() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title: Delete Teacher?
              const Text(
                'Delete Teacher?',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF131313),
                ),
              ),

              const SizedBox(height: 12),

              // Subtitle: Are you sure you want to delete [Name]?
              Text(
                'Are you sure you want to delete\n${nameController.text.trim().isNotEmpty ? nameController.text.trim() : teacher.value.name}?',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF131313),
                  height: 1.4,
                ),
              ),

              const SizedBox(height: 24),

              // Primary Delete Button (Gradient)
              GestureDetector(
                onTap: () {
                  Get.back(); // close dialog
                  Get.back(); // close edit screen
                  Get.back(); // close details screen back to list
                  Get.snackbar(
                    'Deleted',
                    'Teacher has been deleted.',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: const Color(0xFFC90000),
                    colorText: Colors.white,
                    margin: const EdgeInsets.all(16),
                    borderRadius: 12,
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF56B9E3), Color(0xFF1567A2)],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Secondary Cancel Button
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFE3E3E3)),
                  ),
                  child: const Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF131313),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor: const Color(0x66000000),
    );
  }
}
