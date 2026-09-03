class SubjectItem {
  final String id;
  final String title;
  final String subtitle;
  final String status; // 'Active' | 'Draft'
  final String iconType; // 'science' | 'math' | 'social_science'
  final String teacherName;
  final List<String> teacherAvatars;
  final int teacherCount;
  final bool isUnassigned;
  final int lessonsCount;
  final int studentsCount;
  final double progress; // 0.0 to 1.0

  const SubjectItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.iconType,
    required this.teacherName,
    this.teacherAvatars = const [],
    this.teacherCount = 1,
    this.isUnassigned = false,
    required this.lessonsCount,
    required this.studentsCount,
    required this.progress,
  });
}
