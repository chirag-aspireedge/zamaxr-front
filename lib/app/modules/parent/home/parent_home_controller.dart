import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ChildProgressModel {
  final String id;
  final String name;
  final String gradeAndSchool;
  final String avatar;
  final String status;
  final String curriculumLessons;
  final double progressPercent;
  final String recentActivity;
  final IconData recentIcon;

  const ChildProgressModel({
    required this.id,
    required this.name,
    required this.gradeAndSchool,
    required this.avatar,
    required this.status,
    required this.curriculumLessons,
    required this.progressPercent,
    required this.recentActivity,
    required this.recentIcon,
  });
}

class ExploreModuleModel {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String? route;
  final bool isHighlight;

  const ExploreModuleModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    this.route,
    this.isHighlight = false,
  });
}

class LessonNoteModel {
  final String gradeBadge;
  final Color badgeBgColor;
  final Color badgeTextColor;
  final String pageCount;
  final String title;
  final String subtitle;

  const LessonNoteModel({
    required this.gradeBadge,
    required this.badgeBgColor,
    required this.badgeTextColor,
    required this.pageCount,
    required this.title,
    required this.subtitle,
  });
}

class RecentActivityItemModel {
  final String title;
  final String? score;
  final String timeAgo;
  final String extraInfo;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const RecentActivityItemModel({
    required this.title,
    this.score,
    required this.timeAgo,
    this.extraInfo = '',
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });
}

class ParentHomeController extends GetxController {
  final userName = 'Sarah'.obs;
  final parentFullName = 'Sarah Jenkins'.obs;

  final RxList<ChildProgressModel> children = <ChildProgressModel>[
    const ChildProgressModel(
      id: 'daniel',
      name: 'Daniel Johnson',
      gradeAndSchool: 'Class 8 • Greenview Academy',
      avatar: 'assets/images/student_avatar_michael.jpg',
      status: 'Active',
      curriculumLessons: '14/20 Lessons (70%)',
      progressPercent: 0.70,
      recentActivity: 'Completed Cell Structure Quiz • 9/10',
      recentIcon: Icons.check_circle_outline_rounded,
    ),
    const ChildProgressModel(
      id: 'tony',
      name: 'Tony Johnson',
      gradeAndSchool: 'Class 6 • Greenview Academy',
      avatar: 'assets/images/student/student_profile_alex.jpg',
      status: 'Active',
      curriculumLessons: '8/15 Lessons (53%)',
      progressPercent: 0.53,
      recentActivity: 'Practiced Math Equations',
      recentIcon: Icons.edit_note_rounded,
    ),
  ].obs;

  final List<ExploreModuleModel> exploreModules = [
    const ExploreModuleModel(
      id: 'ai_tutor',
      title: 'AI Tutor',
      subtitle: '24/7 Helper',
      icon: Icons.psychology_rounded,
      iconBgColor: Color(0xFFD8E2FF),
      iconColor: Color(0xFF0059BB),
      route: Routes.STUDENT_AI_TUTOR,
    ),
    const ExploreModuleModel(
      id: 'quizzes',
      title: 'Quizzes',
      subtitle: 'Adaptive',
      icon: Icons.assignment_turned_in_rounded,
      iconBgColor: Color(0xFFD0E7EA),
      iconColor: Color(0xFF364A4D),
      route: Routes.PARENT_QUIZZES,
    ),
    const ExploreModuleModel(
      id: 'ar_learning',
      title: 'AR Learning',
      subtitle: 'Interactive',
      icon: Icons.view_in_ar_rounded,
      iconBgColor: Color(0xFFD4E3FF),
      iconColor: Color(0xFF2F486A),
      route: Routes.STUDENT_AR_LEARNING,
    ),
    const ExploreModuleModel(
      id: 'vr_lessons',
      title: 'VR Lessons',
      subtitle: 'Immersive',
      icon: Icons.vrpano_rounded,
      iconBgColor: Color(0xFFD8E2FF),
      iconColor: Color(0xFF0059BB),
      route: Routes.STUDENT_VR_VIDEOS,
    ),
    const ExploreModuleModel(
      id: 'math_solver',
      title: 'Math Solver',
      subtitle: 'Camera Scan',
      icon: Icons.calculate_rounded,
      iconBgColor: Color(0xFFE7E8E9),
      iconColor: Color(0xFF414754),
      route: Routes.STUDENT_MATH_SOLVER,
    ),
    const ExploreModuleModel(
      id: 'rewards',
      title: 'Rewards',
      subtitle: '120 Pts',
      icon: Icons.stars_rounded,
      iconBgColor: Color(0xFFD0E7EA),
      iconColor: Color(0xFF4B6062),
      route: Routes.STUDENT_REWARDS,
      isHighlight: true,
    ),
  ];

  final List<LessonNoteModel> lessonNotes = [
    const LessonNoteModel(
      gradeBadge: 'Grade 8',
      badgeBgColor: Color(0xFFD8E2FF),
      badgeTextColor: Color(0xFF001A41),
      pageCount: 'PDF • 12 pgs',
      title: 'Biology: Cell Organelles & Functions',
      subtitle: "Daniel's upcoming review",
    ),
    const LessonNoteModel(
      gradeBadge: 'Grade 6',
      badgeBgColor: Color(0xFFD4E3FF),
      badgeTextColor: Color(0xFF001C3A),
      pageCount: 'PDF • 8 pgs',
      title: 'Earth Science: Plate Tectonics',
      subtitle: "Tony's recent chapter",
    ),
  ];

  final List<RecentActivityItemModel> recentActivities = [
    const RecentActivityItemModel(
      title: 'Daniel completed "Cell Structure Quiz"',
      score: 'Score: 9/10',
      timeAgo: '2h ago',
      icon: Icons.check_circle_rounded,
      iconBgColor: Color(0xFFD8E2FF),
      iconColor: Color(0xFF0059BB),
    ),
    const RecentActivityItemModel(
      title: 'Earned 20 Reward Credits for 5-day streak',
      extraInfo: 'Family bonus',
      timeAgo: 'Yesterday',
      icon: Icons.stars_rounded,
      iconBgColor: Color(0xFFD0E7EA),
      iconColor: Color(0xFF364A4D),
    ),
    const RecentActivityItemModel(
      title: 'Tony viewed "Solar System 3D Model" in AR',
      extraInfo: '18 mins duration',
      timeAgo: '2 days ago',
      icon: Icons.view_in_ar_rounded,
      iconBgColor: Color(0xFFD4E3FF),
      iconColor: Color(0xFF001C3A),
    ),
  ];

  void openModule(ExploreModuleModel module) {
    if (module.route != null) {
      Get.toNamed(module.route!);
    } else if (module.id == 'quizzes') {
      _showQuizzesDialog();
    } else if (module.id == 'math_solver') {
      _showMathSolverDialog();
    } else {
      Get.snackbar(
        module.title,
        'Opening ${module.title}...',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _showQuizzesDialog() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD0E7EA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.assignment_turned_in_rounded, color: Color(0xFF364A4D)),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Adaptive Quizzes',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                    Text(
                      'Track or assign practice quizzes for your children',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 12,
                        color: Color(0xFF476083),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFD8E2FF),
                child: Icon(Icons.biotech_rounded, color: Color(0xFF0059BB)),
              ),
              title: const Text('Cell Organelles Quiz (Grade 8)'),
              subtitle: const Text('Daniel scored 9/10 • Completed'),
              trailing: TextButton(
                onPressed: () => Get.back(),
                child: const Text('Review'),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Color(0xFFD0E7EA),
                child: Icon(Icons.calculate_rounded, color: Color(0xFF364A4D)),
              ),
              title: const Text('Algebraic Expressions (Grade 6)'),
              subtitle: const Text('Tony scored 8/10 • Completed'),
              trailing: TextButton(
                onPressed: () => Get.back(),
                child: const Text('Review'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127FD2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () => Get.back(),
                child: const Text('Close', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showMathSolverDialog() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E8E9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.calculate_rounded, color: Color(0xFF414754)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Math Solver',
                        style: TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                      Text(
                        'Step-by-step camera scanner & homework assistant',
                        style: TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 12,
                          color: Color(0xFF476083),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F5),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE1E3E4)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.camera_alt_rounded, color: Color(0xFF127FD2), size: 28),
                  SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'Scan equation from textbook or notebook to see guided interactive solutions.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF414754)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.camera_enhance_rounded, color: Colors.white),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF127FD2),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Get.back();
                  Get.toNamed(Routes.STUDENT_AR_LEARNING);
                },
                label: const Text('Open Scanner in AR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onExploreNow() {
    Get.toNamed(Routes.STUDENT_AR_LEARNING);
  }

  void onAddChild() {
    Get.toNamed(Routes.PARENT_CHILDREN_ACCOUNT);
  }

  void onProfileTap() {
    Get.toNamed(Routes.PARENT_PROFILE);
  }

  void onViewFullProgress(ChildProgressModel? child) {
    Get.toNamed(
      Routes.PARENT_CHILD_DETAIL,
      arguments: child ?? (children.isNotEmpty ? children.first : null),
    );
  }

  void onPreviewLessonNote(LessonNoteModel note) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: note.badgeBgColor,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Text(
                    note.gradeBadge,
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: note.badgeTextColor,
                    ),
                  ),
                ),
                Text(
                  note.pageCount,
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 12,
                    color: Color(0xFF476083),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              note.title,
              style: const TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              note.subtitle,
              style: const TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 13,
                color: Color(0xFF476083),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F5),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Topics Covered in this Chapter:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF191C1D)),
                  ),
                  SizedBox(height: 8),
                  Text('• Nucleus & Genetic Material', style: TextStyle(fontSize: 12, color: Color(0xFF414754))),
                  Text('• Mitochondria (Cellular Respiration)', style: TextStyle(fontSize: 12, color: Color(0xFF414754))),
                  Text('• Endoplasmic Reticulum & Ribosomes', style: TextStyle(fontSize: 12, color: Color(0xFF414754))),
                  Text('• Plant vs Animal Cell Wall and Chloroplasts', style: TextStyle(fontSize: 12, color: Color(0xFF414754))),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: const BorderSide(color: Color(0xFF127FD2)),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.toNamed(Routes.STUDENT_AR_LEARNING);
                    },
                    child: const Text('View 3D Model', style: TextStyle(color: Color(0xFF127FD2), fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF127FD2),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.snackbar(
                        'PDF Download',
                        'Downloading ${note.title} (PDF)...',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: const Text('Download PDF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void onViewAllLessonNotes() {
    Get.snackbar(
      'Lesson Notes',
      'Showing all US (NGSS) aligned curriculum notes.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void onViewAllRecentActivity() {
    Get.snackbar(
      'Activity Log',
      'Viewing comprehensive student activity history.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
