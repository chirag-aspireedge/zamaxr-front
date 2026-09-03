class TeacherQuizModel {
  final String id;
  final String title;
  final String chapter;
  final String classSubject;
  final String date;
  final bool isActive;
  final int questionCount;
  final int durationMinutes;
  final String? assignedClass;

  const TeacherQuizModel({
    required this.id,
    required this.title,
    required this.chapter,
    required this.classSubject,
    required this.date,
    required this.isActive,
    required this.questionCount,
    required this.durationMinutes,
    this.assignedClass,
  });

  bool get isAssigned => assignedClass != null && assignedClass!.isNotEmpty;

  TeacherQuizModel copyWith({
    String? id,
    String? title,
    String? chapter,
    String? classSubject,
    String? date,
    bool? isActive,
    int? questionCount,
    int? durationMinutes,
    String? assignedClass,
  }) {
    return TeacherQuizModel(
      id: id ?? this.id,
      title: title ?? this.title,
      chapter: chapter ?? this.chapter,
      classSubject: classSubject ?? this.classSubject,
      date: date ?? this.date,
      isActive: isActive ?? this.isActive,
      questionCount: questionCount ?? this.questionCount,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      assignedClass: assignedClass ?? this.assignedClass,
    );
  }
}
