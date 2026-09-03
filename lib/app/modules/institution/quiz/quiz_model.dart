class QuizOption {
  final String id;
  final String text;
  final bool isCorrect;
  final bool isSelected;

  const QuizOption({
    required this.id,
    required this.text,
    this.isCorrect = false,
    this.isSelected = false,
  });

  QuizOption copyWith({
    String? id,
    String? text,
    bool? isCorrect,
    bool? isSelected,
  }) {
    return QuizOption(
      id: id ?? this.id,
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}

enum QuizQuestionType {
  multipleChoice,
  trueFalse,
}

class QuizQuestion {
  final String id;
  final String numberString;
  final String questionTypeLabel;
  final QuizQuestionType type;
  final String questionText;
  final List<QuizOption> options;
  final int points;

  const QuizQuestion({
    required this.id,
    required this.numberString,
    required this.questionTypeLabel,
    required this.type,
    required this.questionText,
    required this.options,
    this.points = 10,
  });

  QuizQuestion copyWith({
    String? id,
    String? numberString,
    String? questionTypeLabel,
    QuizQuestionType? type,
    String? questionText,
    List<QuizOption>? options,
    int? points,
  }) {
    return QuizQuestion(
      id: id ?? this.id,
      numberString: numberString ?? this.numberString,
      questionTypeLabel: questionTypeLabel ?? this.questionTypeLabel,
      type: type ?? this.type,
      questionText: questionText ?? this.questionText,
      options: options ?? this.options,
      points: points ?? this.points,
    );
  }
}

class QuizModel {
  final String id;
  final String tag;
  final String categorySubtitle;
  final String title;
  final String description;
  final int passingCriteria;
  final int totalQuestions;
  final int totalPoints;
  final List<QuizQuestion> questions;

  const QuizModel({
    required this.id,
    required this.tag,
    required this.categorySubtitle,
    required this.title,
    required this.description,
    required this.passingCriteria,
    required this.totalQuestions,
    required this.totalPoints,
    required this.questions,
  });

  QuizModel copyWith({
    String? id,
    String? tag,
    String? categorySubtitle,
    String? title,
    String? description,
    int? passingCriteria,
    int? totalQuestions,
    int? totalPoints,
    List<QuizQuestion>? questions,
  }) {
    return QuizModel(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      categorySubtitle: categorySubtitle ?? this.categorySubtitle,
      title: title ?? this.title,
      description: description ?? this.description,
      passingCriteria: passingCriteria ?? this.passingCriteria,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      totalPoints: totalPoints ?? this.totalPoints,
      questions: questions ?? this.questions,
    );
  }
}
