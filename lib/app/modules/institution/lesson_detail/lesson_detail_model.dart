class LessonDocument {
  final String title;
  final String size;
  final String? url;

  const LessonDocument({
    required this.title,
    required this.size,
    this.url,
  });
}

class LessonVideo {
  final String title;
  final String subtitle;
  final String duration;
  final String? thumbnailUrl;

  const LessonVideo({
    required this.title,
    required this.subtitle,
    required this.duration,
    this.thumbnailUrl,
  });
}

class LessonAudio {
  final String title;
  final String duration;
  final double currentProgress;
  final String currentTime;
  final String remainingTime;

  const LessonAudio({
    required this.title,
    required this.duration,
    this.currentProgress = 0.35,
    this.currentTime = '02:14',
    this.remainingTime = '-04:21',
  });
}

class LessonImageItem {
  final String title;
  final String? imageUrl;

  const LessonImageItem({
    required this.title,
    this.imageUrl,
  });
}

class LessonQuizItem {
  final String title;
  final String subtitle;
  final bool isAttached;

  const LessonQuizItem({
    required this.title,
    required this.subtitle,
    this.isAttached = true,
  });
}

class LessonImmersiveItem {
  final String title;
  final String actionText;
  final bool isVR;

  const LessonImmersiveItem({
    required this.title,
    required this.actionText,
    this.isVR = false,
  });
}

class LessonDetailModel {
  final String id;
  final String title;
  final String subject;
  final String grade;
  final String category;
  final String status;
  final bool isVisibleToStudents;
  final String teacherName;
  final String teacherAvatar;
  final String description;
  final List<LessonDocument> documents;
  final List<LessonVideo> videos;
  final LessonAudio? audio;
  final List<LessonImageItem> images;
  final LessonQuizItem? quiz;
  final LessonImmersiveItem? arExperience;
  final LessonImmersiveItem? vrAsset;

  const LessonDetailModel({
    required this.id,
    required this.title,
    required this.subject,
    required this.grade,
    required this.category,
    required this.status,
    this.isVisibleToStudents = true,
    required this.teacherName,
    required this.teacherAvatar,
    required this.description,
    this.documents = const [],
    this.videos = const [],
    this.audio,
    this.images = const [],
    this.quiz,
    this.arExperience,
    this.vrAsset,
  });
}
