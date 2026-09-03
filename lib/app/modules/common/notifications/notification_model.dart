enum NotificationCategory {
  all,
  classes,
  teachers,
  system,
}

class NotificationItemModel {
  final String id;
  final String title;
  final String subtitle;
  final String time;
  final NotificationCategory category;
  final String iconType;
  final bool isRead;
  final bool isYesterday;

  const NotificationItemModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.category,
    this.iconType = 'person_add',
    this.isRead = false,
    this.isYesterday = false,
  });

  NotificationItemModel copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? time,
    NotificationCategory? category,
    String? iconType,
    bool? isRead,
    bool? isYesterday,
  }) {
    return NotificationItemModel(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      time: time ?? this.time,
      category: category ?? this.category,
      iconType: iconType ?? this.iconType,
      isRead: isRead ?? this.isRead,
      isYesterday: isYesterday ?? this.isYesterday,
    );
  }
}
