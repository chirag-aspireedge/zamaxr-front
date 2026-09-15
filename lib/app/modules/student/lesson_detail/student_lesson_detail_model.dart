import 'package:flutter/material.dart';

enum StudentLessonContentType {
  video,
  pdf,
  audio,
}

enum StudentLessonContentStatus {
  completed,
  inProgress,
  locked,
}

class StudentLessonContentItem {
  final String id;
  final StudentLessonContentType type;
  final String title;
  final String subtitle;
  final StudentLessonContentStatus status;
  final Color iconBackgroundColor;
  final Color iconColor;
  final double cardOpacity;

  const StudentLessonContentItem({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.iconBackgroundColor,
    required this.iconColor,
    this.cardOpacity = 1.0,
  });

  bool get isCompleted => status == StudentLessonContentStatus.completed;
  bool get isLocked => status == StudentLessonContentStatus.locked;
  bool get isInProgress => status == StudentLessonContentStatus.inProgress;
}

class StudentLessonDetailModel {
  final String id;
  final String title;
  final String subject;
  final String gradeLevel;
  final String durationText;
  final double progress;
  final String progressPercentageText;
  final String aboutTitle;
  final String aboutDescription;
  final String quizTitle;
  final int quizQuestionsCount;
  final List<StudentLessonContentItem> contentItems;

  const StudentLessonDetailModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.gradeLevel,
    required this.durationText,
    required this.progress,
    required this.progressPercentageText,
    required this.aboutTitle,
    required this.aboutDescription,
    required this.quizTitle,
    required this.quizQuestionsCount,
    required this.contentItems,
  });

  String get metadataLine => '$subject · $gradeLevel';
  String get quizQuestionsText => '$quizQuestionsCount Questions';
}
