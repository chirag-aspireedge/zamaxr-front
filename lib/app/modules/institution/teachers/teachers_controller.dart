import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
import 'teachers_model.dart';

class TeachersController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  final RxList<TeacherItem> teachersList = <TeacherItem>[
    TeacherItem(
      id: '1',
      name: 'Sarah Johnson',
      subjectTitle: 'Mathematics Teacher',
      classCountText: '3 Classes',
      isOnline: true,
      avatarAsset: AppAssets.teacherAvatar,
    ),
    TeacherItem(
      id: '2',
      name: 'David Smith',
      subjectTitle: 'Science Teacher',
      classCountText: '2 Classes',
      isOnline: true,
      avatarAsset: AppAssets.teacherAvatar,
    ),
    TeacherItem(
      id: '3',
      name: 'Emily Davis',
      subjectTitle: 'English Teacher',
      classCountText: '1 Class',
      isOnline: false,
      avatarAsset: AppAssets.teacherAvatar,
    ),
    TeacherItem(
      id: '4',
      name: 'David Smith',
      subjectTitle: 'Science Teacher',
      classCountText: '2 Classes',
      isOnline: true,
      avatarAsset: AppAssets.teacherAvatar,
    ),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      searchQuery.value = searchController.text.trim();
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  List<TeacherItem> get filteredTeachers {
    final query = searchQuery.value.toLowerCase();
    if (query.isEmpty) {
      return teachersList;
    }
    return teachersList.where((item) {
      return item.name.toLowerCase().contains(query) ||
          item.subjectTitle.toLowerCase().contains(query) ||
          item.classCountText.toLowerCase().contains(query);
    }).toList();
  }
}
