enum LessonMediaType {
  pdf,
  video,
  audio,
  cube3d,
  quiz,
}

class LessonItem {
  final String id;
  final String lessonNumber;
  final String title;
  final String chapter;
  final String duration;
  final String status;
  final List<LessonMediaType> mediaTypes;

  const LessonItem({
    required this.id,
    required this.lessonNumber,
    required this.title,
    required this.chapter,
    required this.duration,
    required this.status,
    required this.mediaTypes,
  });

  bool get isPublished => status.toUpperCase() == 'PUBLISHED';
  String get chapterDurationText => '$chapter • $duration';
}
