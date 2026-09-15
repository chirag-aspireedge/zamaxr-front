import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'student_home_controller.dart';

class StudentHomeView extends GetView<StudentHomeController> {
  const StudentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 20),
              _buildHeroVrCard(),
              const SizedBox(height: 24),
              _buildFeaturesHeader(),
              const SizedBox(height: 12),
              _buildFeaturesGrid(),
              const SizedBox(height: 24),
              _buildSelfPacedSection(),
              const SizedBox(height: 24),
              _buildContinueLearningHeader(),
              const SizedBox(height: 12),
              _buildContinueLearningCard(),
              const SizedBox(height: 24),
              _buildCurriculumNotesHeader(),
              const SizedBox(height: 12),
              _buildCurriculumNotesList(),
              const SizedBox(height: 16),
              _buildAffirmationBanner(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Welcome & Profile Bar
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Greeting & Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.userGreeting,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  height: 27 / 21,
                  letterSpacing: -0.4,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                controller.userPrompt,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  height: 18 / 13,
                  color: Color(0xFF414754),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Action Buttons: Notifications & Profile
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Notifications Button
            Stack(
              clipBehavior: Clip.none,
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: controller.onNotificationTap,
                    borderRadius: BorderRadius.circular(22),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F5),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        PhosphorIcons.bell(PhosphorIconsStyle.bold),
                        size: 18,
                        color: const Color(0xFF414754),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => controller.hasUnreadNotifications.value
                      ? Positioned(
                          top: 10,
                          right: 10,
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF127FD2),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
            const SizedBox(width: 8),
            // Profile Avatar Button
            GestureDetector(
              onTap: controller.onProfileTap,
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFFE0F6FF),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      spreadRadius: 2,
                    ),
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text(
                  'AL',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.14,
                    color: Color(0xFF445D80),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Search Field (Rectangle 33)
  Widget _buildSearchBar() {
    return GestureDetector(
      onTap: controller.onSearchTap,
      child: Container(
        height: 44,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: const Color(0xFFE0F6FF),
            width: 1.5,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.06),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Icon(
              PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.regular),
              size: 18,
              color: const Color(0xFF1567A2),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Search subject...',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF717786),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Section 1: Featured Interactive Learning (Hero)
  Widget _buildHeroVrCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: -1,
          ),
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top VR World Preview Banner
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: SizedBox(
              height: 220,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    AppAssets.studentVrHero,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFF0C1B2A),
                        alignment: Alignment.center,
                        child: Icon(
                          PhosphorIcons.virtualReality(PhosphorIconsStyle.bold),
                          size: 48,
                          color: const Color(0xFF4CACD9),
                        ),
                      );
                    },
                  ),
                  // Soft Gradient Overlay
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Color.fromRGBO(25, 28, 29, 0.92),
                          Color.fromRGBO(25, 28, 29, 0.35),
                          Color.fromRGBO(25, 28, 29, 0.0),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                  // Glassmorphic Immersive 360° Badge
                  Positioned(
                    top: 12,
                    left: 12,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(9999),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(248, 249, 250, 0.85),
                            borderRadius: BorderRadius.circular(9999),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(0, 0, 0, 0.05),
                                blurRadius: 2,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0059BB),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'IMMERSIVE 360°',
                                style: TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                  color: Color(0xFF0059BB),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Content Overlay at Bottom
                  Positioned(
                    left: 12,
                    right: 12,
                    bottom: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              PhosphorIcons.cube(PhosphorIconsStyle.bold),
                              size: 18,
                              color: const Color(0xFFD8E2FF),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'VR World',
                              style: TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                height: 24 / 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Step inside 3D simulations, space exploration & human anatomy in real-time.',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            height: 18 / 13,
                            letterSpacing: 0.1,
                            color: Color(0xFFE7E8E9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Bar (White with Audio ready and Explore VR button)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.speakerSimpleHigh(PhosphorIconsStyle.bold),
                        size: 15,
                        color: const Color(0xFF0059BB),
                      ),
                      const SizedBox(width: 6),
                      const Expanded(
                        child: Text(
                          'Spatial Audio & Motion Ready',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF414754),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: controller.onExploreVrPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0059BB),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Explore VR',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        PhosphorIcons.arrowRight(PhosphorIconsStyle.bold),
                        size: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Section 2: Explore Features Header
  Widget _buildFeaturesHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Explore Features',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191C1D),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          'Quick Access',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0059BB),
          ),
        ),
      ],
    );
  }

  // 6-Item Grid: 3 columns x 2 rows
  Widget _buildFeaturesGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: controller.features.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 110 / 106,
      ),
      itemBuilder: (context, index) {
        final item = controller.features[index];
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => controller.onFeatureTapped(item.title),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: item.backgroundColor,
                      shape: BoxShape.circle,
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.05),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Icon(
                      item.icon,
                      size: 18,
                      color: item.iconColor,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    item.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF414754),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Section 3: Self-Paced Content
  Widget _buildSelfPacedSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon container
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFD0E7EA),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  PhosphorIcons.bookOpen(PhosphorIconsStyle.bold),
                  size: 19,
                  color: const Color(0xFF63787B),
                ),
              ),
              const SizedBox(width: 12),
              // Heading and description
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Self-Paced\nContent',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 24 / 18,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Learn at your own pace.',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF414754),
                      ),
                    ),
                  ],
                ),
              ),
              // WebView Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7E8E9),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Text(
                  'WebView',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF414754),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Powered by EmmerXedu & Start Learning Banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        PhosphorIcons.shieldCheck(PhosphorIconsStyle.bold),
                        size: 14,
                        color: const Color(0xFF4B6062),
                      ),
                      const SizedBox(width: 6),
                      const Expanded(
                        child: Text(
                          'Powered by E-mmerXedu',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF414754),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: controller.onStartSelfPacedPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0059BB),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    visualDensity: VisualDensity.compact,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Start Learning',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        PhosphorIcons.arrowSquareOut(PhosphorIconsStyle.bold),
                        size: 11,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Section 4: Continue Learning Header
  Widget _buildContinueLearningHeader() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Continue Learning',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191C1D),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          'Active',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF414754),
          ),
        ),
      ],
    );
  }

  // Continue Learning Card
  Widget _buildContinueLearningCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFD8E2FF),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  PhosphorIcons.flask(PhosphorIconsStyle.bold),
                  size: 19,
                  color: const Color(0xFF0059BB),
                ),
              ),
              const SizedBox(width: 12),
              // Subject Title and Tag/Progress
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.activeCourseTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      runSpacing: 4,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 7,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD0E7EA),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: Text(
                            controller.activeCourseBadge,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF364A4D),
                            ),
                          ),
                        ),
                        Text(
                          controller.activeCourseProgressText,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF414754),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Resume Button
              ElevatedButton(
                onPressed: controller.onResumeLearningPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0059BB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  minimumSize: const Size(64, 28),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Resume',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Progress Bar Indicator
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: controller.activeCourseProgress,
              minHeight: 6,
              backgroundColor: const Color(0xFFE7E8E9),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0059BB)),
            ),
          ),
          const SizedBox(height: 14),
          // Secondary Mini Activity Item
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  PhosphorIcons.sparkle(PhosphorIconsStyle.bold),
                  size: 14,
                  color: const Color(0xFF476083),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    controller.secondaryActivityText,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF414754),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  controller.secondaryActivityTime,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF717786),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Section 5: Curriculum Lesson Notes Header
  Widget _buildCurriculumNotesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(
          child: Text(
            'Curriculum Lesson\nNotes',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              height: 22 / 17,
              color: Color(0xFF191C1D),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFE7E8E9),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: const Text(
            'US (NGSS) • Available',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF414754),
            ),
          ),
        ),
      ],
    );
  }

  // Curriculum Notes List
  Widget _buildCurriculumNotesList() {
    return Column(
      children: controller.notes.map((note) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.05),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFDAD6),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Icon(
                  PhosphorIcons.filePdf(PhosphorIconsStyle.bold),
                  size: 18,
                  color: const Color(0xFF93000A),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.1,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      note.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF414754),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => controller.onDownloadNotePressed(note.title),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F4F5),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    PhosphorIcons.downloadSimple(PhosphorIconsStyle.bold),
                    size: 14,
                    color: const Color(0xFF414754),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // Section 6: Independent Learner Affirmation Banner
  Widget _buildAffirmationBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            PhosphorIcons.info(PhosphorIconsStyle.bold),
            size: 15,
            color: const Color(0xFF0059BB),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Independent learners have full access to all XR modules, AI Tutor, and Self-Paced courses.',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 17 / 12,
                color: Color(0xFF414754),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
