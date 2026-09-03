class TeacherLessonDocument {
  final String title;
  final String size;
  final String? url;

  const TeacherLessonDocument({
    required this.title,
    required this.size,
    this.url,
  });
}

class TeacherLessonVideo {
  final String title;
  final String subtitle;
  final String duration;
  final String? thumbnailUrl;

  const TeacherLessonVideo({
    required this.title,
    required this.subtitle,
    required this.duration,
    this.thumbnailUrl,
  });
}

class TeacherLessonAudio {
  final String title;
  final String duration;
  final double currentProgress;
  final String currentTime;
  final String remainingTime;

  const TeacherLessonAudio({
    required this.title,
    required this.duration,
    this.currentProgress = 0.35,
    this.currentTime = '02:14',
    this.remainingTime = '-04:21',
  });
}

class TeacherLessonImageItem {
  final String title;
  final String? imageUrl;

  const TeacherLessonImageItem({
    required this.title,
    this.imageUrl,
  });
}

class TeacherLessonQuizItem {
  final String title;
  final String subtitle;
  final bool isAttached;

  const TeacherLessonQuizItem({
    required this.title,
    required this.subtitle,
    this.isAttached = true,
  });
}

class TeacherLessonImmersiveItem {
  final String title;
  final String actionText;
  final bool isVR;

  const TeacherLessonImmersiveItem({
    required this.title,
    required this.actionText,
    this.isVR = false,
  });
}

class TeacherLessonDetailModel {
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
  final List<TeacherLessonDocument> documents;
  final List<TeacherLessonVideo> videos;
  final TeacherLessonAudio? audio;
  final List<TeacherLessonImageItem> images;
  final TeacherLessonQuizItem? quiz;
  final TeacherLessonImmersiveItem? arExperience;
  final TeacherLessonImmersiveItem? vrAsset;

  const TeacherLessonDetailModel({
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
