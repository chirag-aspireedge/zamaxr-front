class TeacherItem {
  final String id;
  final String name;
  final String subjectTitle; // e.g. "Mathematics Teacher", "Science Teacher", "English Teacher"
  final String classCountText; // e.g. "3 Classes", "2 Classes", "1 Class"
  final bool isOnline; // true: green (#20E679), false: grey (#E1E3E4)
  final String avatarAsset;
  final String phone;
  final String email;
  final String teacherIdCode;
  final String assignedClass;
  final String assignedSubject;
  final int studentsCount;

  TeacherItem({
    required this.id,
    required this.name,
    required this.subjectTitle,
    required this.classCountText,
    required this.isOnline,
    this.avatarAsset = '',
    this.phone = '+91 98765 43210',
    this.email = 'sarah@example.com',
    this.teacherIdCode = 'TCH-1024',
    this.assignedClass = 'Class -8',
    this.assignedSubject = 'Mathematics',
    this.studentsCount = 32,
  });
}

