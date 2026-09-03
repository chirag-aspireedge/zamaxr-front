import '../teachers/teachers_model.dart';

class ClassActivityItem {
  final String id;
  final String title;
  final String timeText;
  final bool isScheduleUpdate;

  ClassActivityItem({
    required this.id,
    required this.title,
    required this.timeText,
    this.isScheduleUpdate = false,
  });
}

class ClassDetailModel {
  final String id;
  final String title;
  final String grade;
  final String section;
  final String subject;
  final String academicYear;
  final String classTeacherName;
  final int studentsCount;
  final int teachersCount;
  final int lessonsCount;
  final int quizzesCount;
  final int vrAssetsCount;
  final List<String> subjects;
  final TeacherItem currentTeacher;
  final List<TeacherItem> pastTeachers;
  final List<ClassActivityItem> recentActivities;

  ClassDetailModel({
    required this.id,
    required this.title,
    required this.grade,
    required this.section,
    required this.subject,
    required this.academicYear,
    required this.classTeacherName,
    required this.studentsCount,
    required this.teachersCount,
    required this.lessonsCount,
    required this.quizzesCount,
    required this.vrAssetsCount,
    this.subjects = const ['Mathematics', 'Science', 'Social Science'],
    required this.currentTeacher,
    required this.pastTeachers,
    required this.recentActivities,
  });
}
