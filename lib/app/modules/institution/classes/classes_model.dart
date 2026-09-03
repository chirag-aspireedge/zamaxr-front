class ClassDetailItem {
  final String id;
  final String classGrade; // e.g. "Class -A", "Class -B"
  final String subject; // e.g. "Mathematics", "Science"
  final String teacherName; // e.g. "Sarah Johnson", "David Smith"
  final int studentCount; // e.g. 32, 28
  final String iconType; // 'math' or 'science'
  final String status; // 'All', 'Live', 'Upcoming', 'Completed'

  ClassDetailItem({
    required this.id,
    required this.classGrade,
    required this.subject,
    required this.teacherName,
    required this.studentCount,
    required this.iconType,
    required this.status,
  });
}
