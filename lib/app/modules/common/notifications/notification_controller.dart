import 'package:get/get.dart';
import 'notification_model.dart';

class NotificationController extends GetxController {
  // Selected category filter
  final Rx<NotificationCategory> selectedCategory =
      NotificationCategory.all.obs;

  // Notification items list
  final RxList<NotificationItemModel> notifications =
      <NotificationItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialNotifications();
  }

  void _loadInitialNotifications() {
    notifications.assignAll([
      // Today Notifications
      const NotificationItemModel(
        id: '1',
        title: 'Lorem Ipsum is simply dummy text',
        subtitle: 'Lorem Ipsum',
        time: '10 mins ago',
        category: NotificationCategory.teachers,
        iconType: 'person_add',
        isRead: false,
        isYesterday: false,
      ),
      const NotificationItemModel(
        id: '2',
        title: 'Lorem Ipsum is simply dummy text',
        subtitle: 'Lorem Ipsum',
        time: '45 mins ago',
        category: NotificationCategory.classes,
        iconType: 'person_add',
        isRead: false,
        isYesterday: false,
      ),
      const NotificationItemModel(
        id: '3',
        title: 'Lorem Ipsum is simply dummy text',
        subtitle: 'Lorem Ipsum',
        time: '2 hours ago',
        category: NotificationCategory.system,
        iconType: 'person_add',
        isRead: true,
        isYesterday: false,
      ),

      // Yesterday Notifications
      const NotificationItemModel(
        id: '4',
        title: 'Lorem Ipsum is simply dummy text',
        subtitle: 'Lorem Ipsum',
        time: 'Yesterday, 4:30 PM',
        category: NotificationCategory.teachers,
        iconType: 'person_add',
        isRead: true,
        isYesterday: true,
      ),
      const NotificationItemModel(
        id: '5',
        title: 'Lorem Ipsum is simply dummy text',
        subtitle: 'Lorem Ipsum',
        time: 'Yesterday, 11:15 AM',
        category: NotificationCategory.classes,
        iconType: 'person_add',
        isRead: true,
        isYesterday: true,
      ),
    ]);
  }

  void onSelectCategory(NotificationCategory category) {
    selectedCategory.value = category;
  }

  void onMarkAllAsRead() {
    notifications.assignAll(
      notifications.map((n) => n.copyWith(isRead: true)).toList(),
    );
    Get.snackbar(
      'Notifications',
      'All notifications marked as read',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  void onNotificationTap(NotificationItemModel item) {
    // Mark specific notification as read
    final index = notifications.indexWhere((n) => n.id == item.id);
    if (index != -1) {
      notifications[index] = notifications[index].copyWith(isRead: true);
    }
  }

  List<NotificationItemModel> get todayNotifications {
    return notifications.where((n) {
      final matchesCategory = selectedCategory.value ==
              NotificationCategory.all ||
          n.category == selectedCategory.value;
      return !n.isYesterday && matchesCategory;
    }).toList();
  }

  List<NotificationItemModel> get yesterdayNotifications {
    return notifications.where((n) {
      final matchesCategory = selectedCategory.value ==
              NotificationCategory.all ||
          n.category == selectedCategory.value;
      return n.isYesterday && matchesCategory;
    }).toList();
  }
}
