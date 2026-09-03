import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'classes_model.dart';

class ClassesController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  final RxString searchQuery = ''.obs;
  final RxString selectedFilter = 'All'.obs;

  final List<String> filterTabs = const ['All', 'Live', 'Upcoming', 'Completed'];

  final RxList<ClassDetailItem> allClassItems = <ClassDetailItem>[
    ClassDetailItem(
      id: '1',
      classGrade: 'Class -A',
      subject: 'Mathematics',
      teacherName: 'Sarah Johnson',
      studentCount: 32,
      iconType: 'math',
      status: 'Live',
    ),
    ClassDetailItem(
      id: '2',
      classGrade: 'Class -B',
      subject: 'Science',
      teacherName: 'David Smith',
      studentCount: 28,
      iconType: 'science',
      status: 'Upcoming',
    ),
    ClassDetailItem(
      id: '3',
      classGrade: 'Class -B',
      subject: 'Mathematics',
      teacherName: 'David Smith',
      studentCount: 28,
      iconType: 'math',
      status: 'Completed',
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

  void setFilter(String filter) {
    selectedFilter.value = filter;
  }

  List<ClassDetailItem> get filteredClasses {
    return allClassItems.where((item) {
      // Filter by tab
      final matchesFilter = selectedFilter.value == 'All' ||
          item.status.toLowerCase() == selectedFilter.value.toLowerCase();

      // Filter by search query
      final query = searchQuery.value.toLowerCase();
      final matchesSearch = query.isEmpty ||
          item.teacherName.toLowerCase().contains(query) ||
          item.classGrade.toLowerCase().contains(query) ||
          item.subject.toLowerCase().contains(query);

      return matchesFilter && matchesSearch;
    }).toList();
  }
}
