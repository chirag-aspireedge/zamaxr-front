import 'package:flutter/material.dart';

class TeacherStudentModel {
  final String id;
  final String name;
  final bool isOnline;
  final String? imageAsset;
  final String? initials;
  final Color? initialsBgColor;
  final Color? initialsTextColor;

  const TeacherStudentModel({
    required this.id,
    required this.name,
    required this.isOnline,
    this.imageAsset,
    this.initials,
    this.initialsBgColor,
    this.initialsTextColor,
  });
}
