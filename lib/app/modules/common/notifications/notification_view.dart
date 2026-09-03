import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import 'notification_controller.dart';
import 'notification_model.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<NotificationController>()) {
      Get.put(NotificationController());
    }

    return Scaffold(
      backgroundColor: AppColor.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            _buildTopAppBar(context),

            // Scrollable Notifications List
            Expanded(
              child: Obx(() {
                final todayItems = controller.todayNotifications;
                final yesterdayItems = controller.yesterdayNotifications;

                return SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 14),

                      // Filter Categories Horizontal Row
                      _buildFilterTabs(),
                      const SizedBox(height: 24),

                      // Today's Notifications List
                      if (todayItems.isNotEmpty) ...[
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: todayItems.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            return _buildNotificationCard(todayItems[index]);
                          },
                        ),
                      ],

                      // Yesterday Section Header & List
                      if (yesterdayItems.isNotEmpty) ...[
                        const SizedBox(height: 24),
                        const Text(
                          'Yesterday',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF131313),
                          ),
                        ),
                        const SizedBox(height: 14),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: yesterdayItems.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 14),
                          itemBuilder: (context, index) {
                            return _buildNotificationCard(yesterdayItems[index]);
                          },
                        ),
                      ],

                      if (todayItems.isEmpty && yesterdayItems.isEmpty) ...[
                        const SizedBox(height: 80),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Remix.notification_off_line,
                                size: 48,
                                color: Color(0xFFC1C6D7),
                              ),
                              SizedBox(height: 14),
                              Text(
                                'No notifications in this category',
                                style: TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 15,
                                  color: Color(0xFF72777A),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 32),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top App Bar: "Notifications" Title & "Mark As Read" Action Button
  // ---------------------------------------------------------------------------
  Widget _buildTopAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Back button + "Notifications" Title
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  if (Navigator.of(context).canPop()) {
                    Get.back();
                  }
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE0F6FF),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 15,
                      color: Color(0xFF127FD2),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Notifications',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0E3856),
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),

          // Right: "Mark As Read" Action
          GestureDetector(
            onTap: controller.onMarkAllAsRead,
            child: const Text(
              'Mark As Read',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xFF0E3856),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Filter Category Pills: All, Classes, Teachers, System
  // ---------------------------------------------------------------------------
  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterPill(
            label: 'All',
            category: NotificationCategory.all,
            width: 50,
          ),
          const SizedBox(width: 10),
          _buildFilterPill(
            label: 'Classes',
            category: NotificationCategory.classes,
            width: 85,
          ),
          const SizedBox(width: 10),
          _buildFilterPill(
            label: 'Teachers',
            category: NotificationCategory.teachers,
            width: 94,
          ),
          const SizedBox(width: 10),
          _buildFilterPill(
            label: 'System',
            category: NotificationCategory.system,
            width: 80,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterPill({
    required String label,
    required NotificationCategory category,
    required double width,
  }) {
    final isSelected = controller.selectedCategory.value == category;

    return GestureDetector(
      onTap: () => controller.onSelectCategory(category),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: width,
        height: 34,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: isSelected
              ? const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF52B3DE),
                    Color(0xFF1364A0),
                  ],
                )
              : null,
          color: isSelected ? null : const Color(0xFFEFEFEF),
          border: isSelected
              ? null
              : Border.all(
                  color: const Color(0xFFF2F2F2),
                  width: 1,
                ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: isSelected ? Colors.white : const Color(0xFF131313),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Single Notification Card (Rectangle 19: 354x86, 6px radius, #E3E3E3 border)
  // ---------------------------------------------------------------------------
  Widget _buildNotificationCard(NotificationItemModel item) {
    return GestureDetector(
      onTap: () => controller.onNotificationTap(item),
      child: Container(
        height: 86,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: const Color(0xFFE3E3E3),
            width: 1,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x05000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left Avatar Circle (#F1FBFF, 45x45)
            Container(
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFF1FBFF),
              ),
              child: const Center(
                child: Icon(
                  Icons.person_add_rounded,
                  size: 22,
                  color: Color(0xFF127FD2),
                ),
              ),
            ),
            const SizedBox(width: 14),

            // Middle Content: Title & Subtitle
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF131313),
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF131313),
                    ),
                  ),
                ],
              ),
            ),

            // Right Unread Dot indicator
            if (!item.isRead)
              Container(
                width: 8,
                height: 8,
                margin: const EdgeInsets.only(left: 8),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF127FD2),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
