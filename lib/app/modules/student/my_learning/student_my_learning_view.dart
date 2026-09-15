import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/themes/app_textstyle.dart';
import 'student_my_learning_controller.dart';

class StudentMyLearningView extends GetView<StudentMyLearningController> {
  const StudentMyLearningView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopAppBar(),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 110),
                  itemCount: controller.courses.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final course = controller.courses[index];
                    return _buildCourseCard(course);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Top Title Bar
  Widget _buildTopAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text(
              'My Learning',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 21,
                fontWeight: FontWeight.w700,
                height: 28 / 21,
                letterSpacing: -0.4,
                color: Color(0xFF191C1D),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Enrolled count tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F6FF),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Obx(
              () => Text(
                '${controller.courses.length} Enrolled',
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0059BB),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Exact Figma Subject Card (Biology, Mathematics, English, Physics)
  Widget _buildCourseCard(StudentCourseModel course) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.04),
            blurRadius: 1,
            offset: Offset(0, 0),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 4px Top Gradient Accent Strip
          Opacity(
            opacity: course.gradientOpacity,
            child: Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: course.accentGradient,
              ),
            ),
          ),

          // Card Body Padding: 24px
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Term + Subject Name (Left) & Offline Badge (Right)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Term & Subject Column
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            course.term,
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              height: 16 / 12,
                              color: course.termColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            course.subject,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              height: 24 / 17,
                              color: Color(0xFF191C1D),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Offline Badge (If present in Figma layout)
                    if (course.hasOfflineBadge)
                      InkWell(
                        onTap: () => controller.toggleOffline(course),
                        borderRadius: BorderRadius.circular(9999),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: course.termColor.withValues(alpha: 0.10),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                PhosphorIcons.cloudCheck(PhosphorIconsStyle.bold),
                                size: 14,
                                color: course.termColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Offline',
                                style: TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 16 / 12,
                                  color: course.termColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 16),

                // Progress Info & Track (Margin block in Figma: 16px top padding)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Continue topic & Percentage row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.continueLesson,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 20 / 14,
                                  letterSpacing: 0.14,
                                  color: Color(0xFF414754),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                course.lastViewed,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  height: 16 / 12,
                                  color: Color(0xFF717786),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${(course.progress * 100).toInt()}%',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            height: 16 / 12,
                            color: course.termColor,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    // Progress Track: Height 6px, Radius 9999px, #E1E3E4 with #127FD2 fill
                    Stack(
                      children: [
                        Container(
                          height: 6,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE1E3E4),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                        ),
                        FractionallySizedBox(
                          widthFactor: course.progress.clamp(0.0, 1.0),
                          child: Container(
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFF127FD2),
                              borderRadius: BorderRadius.circular(9999),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Button: 48px height, rounded 8px
                SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Material(
                    color: course.buttonBgColor,
                    borderRadius: BorderRadius.circular(8),
                    shadowColor: Colors.black.withValues(alpha: 0.05),
                    elevation: course.buttonBgColor == const Color(0xFF127FD2) ? 1 : 0,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => controller.onContinueCourse(course),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'CONTINUE',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              height: 20 / 15,
                              letterSpacing: 0.6,
                              color: course.buttonTextColor,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            PhosphorIcons.arrowRight(PhosphorIconsStyle.bold),
                            size: 14,
                            color: course.buttonTextColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
