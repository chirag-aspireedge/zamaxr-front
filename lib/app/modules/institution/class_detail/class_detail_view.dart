import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import '../teachers/teachers_model.dart';
import 'class_detail_controller.dart';

class ClassDetailView extends GetView<ClassDetailController> {
  const ClassDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColor.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Stack with Gradient Background and Overlapping Stats Cards
              _buildHeaderWithStats(context),

              // Body Content
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Information
                    _buildSectionHeader('Information'),
                    const SizedBox(height: 12),
                    _buildInformationCard(),

                    const SizedBox(height: 28),

                    // Section 2: Subjects
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => controller.onViewAllSubjects(),
                          child: _buildSectionHeader('Subjects'),
                        ),
                        GestureDetector(
                          onTap: () => controller.onViewAllSubjects(),
                          child: const Text(
                            'View All',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF127FD2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildSubjectsSection(),

                    const SizedBox(height: 28),

                    // Section 3: Learning Content
                    _buildSectionHeader('Learning Content'),
                    const SizedBox(height: 12),
                    _buildLearningContentGrid(),

                    const SizedBox(height: 28),

                    // Section 3: Student Engagement
                    _buildSectionHeader('Student Engagement'),
                    const SizedBox(height: 12),
                    _buildStudentEngagementSection(),

                    const SizedBox(height: 28),

                    // Section 4: Current Assigned Teacher
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSectionHeader('Current Assigned Teacher'),
                        GestureDetector(
                          onTap: () => controller.onAddTeacher(),
                          child: const Text(
                            '+Add',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF127FD2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Obx(() => _buildTeacherCard(
                          controller.classData.value.currentTeacher,
                        )),

                    const SizedBox(height: 28),

                    // Section 5: Past Teachers
                    _buildSectionHeader('Past Teachers'),
                    const SizedBox(height: 12),
                    _buildPastTeachersSection(),

                    const SizedBox(height: 28),

                    // Section 6: Recent Activity
                    _buildSectionHeader('Recent Activity'),
                    const SizedBox(height: 12),
                    _buildRecentActivityCard(),

                    const SizedBox(height: 36),

                    // Bottom Primary Button: Edit Class (318x54 centered)
                    Center(
                      child: _buildEditClassButton(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Header with Linear Gradient (#53B5E0 -> #11629E) and Overlapping Stats Cards
  Widget _buildHeaderWithStats(BuildContext context) {
    const double cardHeight = 110.0;
    const double overlap = 55.0; // Half of the card hangs below the blue container
    final double topPadding = MediaQuery.paddingOf(context).top;
    final double blueHeight = topPadding + 195.0;
    final double totalHeaderHeight = blueHeight + overlap;

    return SizedBox(
      height: totalHeaderHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Gradient Header Box
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: blueHeight,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF53B5E0), Color(0xFF11629E)],
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24.0, 12.0, 24.0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // App Bar Row (Circular Back Button & Screen Title)
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0x332E86BA), // rgba(46, 134, 186, 0.2)
                                border: Border.all(
                                  color: const Color(0x6BFFFFFF), // rgba(255, 255, 255, 0.42)
                                  width: 1,
                                ),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x1A000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Text(
                            'Dashboard',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      // Class Title (e.g. Class 8-A)
                      Obx(() => Text(
                            controller.classData.value.title,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.5,
                              height: 1.15,
                            ),
                          )),

                      const SizedBox(height: 6),

                      // Subtitle Row: Science • Academic Year 2026-27
                      Obx(() => Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.classData.value.subject,
                                style: const TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 4,
                                height: 4,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Academic Year ${controller.classData.value.academicYear}',
                                style: const TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // 3 Overlapping Stats Cards sitting at bottom of Stack (half on blue, half on white)
          Positioned(
            left: 24,
            right: 24,
            bottom: 0,
            height: cardHeight,
            child: Obx(() {
              final data = controller.classData.value;
              return Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      iconAsset: AppAssets.iconClassStudents,
                      count: '${data.studentsCount}',
                      label: 'Students',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      iconAsset: AppAssets.iconClassTeachers,
                      count: '${data.teachersCount}',
                      label: 'Teachers',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      iconAsset: AppAssets.iconClassLessons,
                      count: '${data.lessonsCount}',
                      label: 'Lessons',
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  // Single Top Stat Card (110px height)
  Widget _buildStatCard({
    required String iconAsset,
    required String count,
    required String label,
  }) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000), // Soft, clean elevation
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconAsset,
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 6),
          Text(
            count,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF131313),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF131313),
            ),
          ),
        ],
      ),
    );
  }

  // Section Header Title (16px, FontWeight.w600, #0E3856)
  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: AppTextStyle.fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF0E3856),
      ),
    );
  }

  // Section 1: Information Card
  Widget _buildInformationCard() {
    return Obx(() {
      final data = controller.classData.value;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
        ),
        child: Column(
          children: [
            _buildInfoRow(label: 'Grade', value: data.grade),
            const Divider(color: Color(0xFFE3E3E3), height: 1, thickness: 1),
            _buildInfoRow(label: 'Section', value: data.section),
            const Divider(color: Color(0xFFE3E3E3), height: 1, thickness: 1),
            _buildInfoRow(label: 'Academic Year', value: data.academicYear),
            const Divider(color: Color(0xFFE3E3E3), height: 1, thickness: 1),
            _buildInfoRow(label: 'Class Teacher', value: data.classTeacherName),
          ],
        ),
      );
    });
  }

  Widget _buildInfoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: Color(0xFF131313),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFF131313),
            ),
          ),
        ],
      ),
    );
  }

  // Section 2: Subjects Section
  Widget _buildSubjectsSection() {
    return Obx(() {
      final subjects = controller.classData.value.subjects;
      return Column(
        children: [
          for (int i = 0; i < subjects.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            _buildSubjectCard(subjects[i]),
          ],
        ],
      );
    });
  }

  Widget _buildSubjectCard(String subjectName) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E9EB), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.onSubjectTap(subjectName),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subjectName,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF131313),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE0F6FF),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.iconChevronRightBlue,
                      width: 8,
                      height: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Section 3: Learning Content Grid (Quizzes & VR Assets)
  Widget _buildLearningContentGrid() {
    return Obx(() {
      final data = controller.classData.value;
      return Row(
        children: [
          Expanded(
            child: _buildLearningContentCard(
              count: '${data.quizzesCount}',
              label: 'Quizzes',
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _buildLearningContentCard(
              count: '${data.vrAssetsCount}',
              label: 'VR Assets',
            ),
          ),
        ],
      );
    });
  }

  Widget _buildLearningContentCard({
    required String count,
    required String label,
  }) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            count,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFF131313),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Color(0xFF131313),
            ),
          ),
        ],
      ),
    );
  }

  // Section 3: Student Engagement Section (2 items)
  Widget _buildStudentEngagementSection() {
    return Column(
      children: [
        _buildEngagementItem(
          iconAsset: AppAssets.iconEngagementView,
          title: '28 Students',
          subtitle: 'Mathematics Teacher',
        ),
        const SizedBox(height: 12),
        _buildEngagementItem(
          iconAsset: AppAssets.iconEngagementTablet,
          title: 'Sarah Johnson',
          subtitle: 'Mathematics Teacher',
        ),
      ],
    );
  }

  Widget _buildEngagementItem({
    required String iconAsset,
    required String title,
    required String subtitle,
  }) {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
      ),
      child: Row(
        children: [
          // Circular Icon Container (46x46, #E0F6FF)
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: Color(0xFFE0F6FF),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: SvgPicture.asset(
                iconAsset,
                width: 24,
                height: 24,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF131313),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF131313),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Teacher Card Item (354x84 in Figma)
  Widget _buildTeacherCard(TeacherItem teacher) {
    return GestureDetector(
      onTap: () => controller.onTeacherTap(teacher),
      child: Container(
        height: 84,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
        ),
        child: Row(
          children: [
            // Circular Avatar (60x60)
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFE0F6FF),
              ),
              child: ClipOval(
                child: Image.asset(
                  teacher.avatarAsset.isNotEmpty
                      ? teacher.avatarAsset
                      : AppAssets.teacherAvatar,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(
                      child: SvgPicture.asset(
                        AppAssets.iconTeacher,
                        width: 28,
                        height: 28,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    teacher.name,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF131313),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    teacher.subjectTitle,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF131313),
                    ),
                  ),
                ],
              ),
            ),
            // Forward Chevron Button (26x26 in Figma, #E0F6FF)
            Container(
              width: 26,
              height: 26,
              decoration: const BoxDecoration(
                color: Color(0xFFE0F6FF),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.iconChevronRightBlue,
                  width: 8,
                  height: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section 5: Past Teachers Section
  Widget _buildPastTeachersSection() {
    return Obx(() {
      final list = controller.classData.value.pastTeachers;
      return Column(
        children: list.map((teacher) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: _buildTeacherCard(teacher),
          );
        }).toList(),
      );
    });
  }

  // Section 6: Recent Activity Container Card (354x217 in Figma)
  Widget _buildRecentActivityCard() {
    return Obx(() {
      final activities = controller.classData.value.recentActivities;
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE3E3E3), width: 1),
        ),
        child: Column(
          children: activities.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            final isLast = index == activities.length - 1;

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon Circle (36x36, #E0F6FF)
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE0F6FF),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            item.isScheduleUpdate
                                ? AppAssets.iconActivityScheduled
                                : AppAssets.iconActivityUserAdd,
                            width: 18,
                            height: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 14,
                                fontWeight: item.isScheduleUpdate
                                    ? FontWeight.w500
                                    : FontWeight.w600,
                                color: const Color(0xFF131313),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item.timeText,
                              style: const TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF636363),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isLast)
                  const Divider(color: Color(0xFFE3E3E3), height: 1, thickness: 1),
              ],
            );
          }).toList(),
        ),
      );
    });
  }

  // Primary Bottom "Edit Class" Gradient Button (318x54 in Figma)
  Widget _buildEditClassButton() {
    return GestureDetector(
      onTap: () => controller.onEditClass(),
      child: Container(
        width: 318,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(52),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xFF56B9E3), Color(0xFF0E5E9B)],
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              blurRadius: 4,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Edit Class',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
