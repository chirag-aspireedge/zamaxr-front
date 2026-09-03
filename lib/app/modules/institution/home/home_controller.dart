import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClassModel {
  final String number;
  final String title;
  final String subtitle;

  const ClassModel({
    required this.number,
    required this.title,
    required this.subtitle,
  });
}

class HomeController extends GetxController {
  final searchController = TextEditingController();

  final List<ClassModel> createdClasses = const [
    ClassModel(
      number: '01',
      title: 'Class 1',
      subtitle: 'Lorem ipsum dummy text',
    ),
    ClassModel(
      number: '02',
      title: 'Class 2',
      subtitle: 'Lorem ipsum dummy text',
    ),
    ClassModel(
      number: '03',
      title: 'Class 3',
      subtitle: 'Lorem ipsum dummy text',
    ),
  ];

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
