import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import '../../student/search/student_search_view.dart';
import '../../student/profile/student_profile_view.dart';
import '../../student/rewards/student_rewards_view.dart';
import 'individual_home_controller.dart';

class IndividualHomeView extends GetView<IndividualHomeController> {
  const IndividualHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              // Main Tab Content via IndexedStack preserving state
              Obx(
                () => IndexedStack(
                  index: controller.currentNavIndex.value,
                  children: [
                    _buildHomeContent(context),
                    const StudentSearchView(),
                    const StudentRewardsView(showBottomNav: false),
                    const StudentProfileView(showBottomNav: false),
                  ],
                ),
              ),

              // Floating Bottom Pill Navigation Bar
              Positioned(
                left: 20,
                right: 20,
                bottom: 24,
                child: _buildFloatingBottomNav(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 110),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Compact Header (Greeting & Actions)
          _buildHeader(context),
          const SizedBox(height: 14),

          // 2. PRIMARY FEATURE: AR/VR Learning Hero Card
          _buildHeroCard(),
          const SizedBox(height: 24),

          // 3. EXPLORE FEATURES (Feature Entry Points replacing lesson cards)
          _buildExploreFeaturesSection(context),
          const SizedBox(height: 24),

          // 5. SELF-PACED LEARNING: E-mmerxedu In-App Browser Card
          _buildSelfPacedCard(),
          const SizedBox(height: 20),

          // 6. RECENT ACTIVITY (Feature-based: Quiz, Points, AI, AR)
          _buildRecentActivitySection(),
          const SizedBox(height: 20),

          // 7. PROGRESS & REWARDS: Compact Horizontal Section
          _buildProgressRewardsCard(),
          const SizedBox(height: 24),

          // 8. WHAT'S NEW: Announcements & Updates
          _buildWhatsNewSection(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // 1. Compact Header Section
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Greeting Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Obx(
                        () => Text(
                          'Hi, ${controller.userName.value}!',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                            color: Color(0xFF0A2540),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '👋',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                const Text(
                  'Ready to explore and learn?',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          // Action Items: Notification Icon with Badge & User Avatar
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Notification Button with Unread Badge
              GestureDetector(
                onTap: controller.onOpenNotifications,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFF8FAFC),
                    border: Border.all(color: const Color(0xFFE2E8F0)),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(
                        PhosphorIconsBold.bell,
                        size: 16,
                        color: Color(0xFF475569),
                      ),
                      Positioned(
                        right: 7,
                        top: 7,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF127FD2),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // User Avatar with Online Dot
              GestureDetector(
                onTap: controller.onOpenProfile,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: const Color(0xFF3B82F6), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          AppAssets.studentProfileAlex,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(AppAssets.userAvatar, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                    Positioned(
                      right: -1,
                      bottom: -1,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF10B981),
                          border: Border.all(color: Colors.white, width: 1.5),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 2. PRIMARY FEATURE: AR/VR Learning Hero Card
  Widget _buildHeroCard() {
    return Container(
      height: 176,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image Visual
            Image.asset(
              AppAssets.individualHeroArVr,
              fit: BoxFit.cover,
              alignment: Alignment.center,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF0A192F),
              ),
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.45, 1.0],
                  colors: [
                    Colors.transparent,
                    const Color(0xFF0A192F).withValues(alpha: 0.5),
                    const Color(0xFF0A192F).withValues(alpha: 0.95),
                  ],
                ),
              ),
            ),

            // Top Floating Tag: "IMMERSIVE EXPERIENCE"
            Positioned(
              left: 12,
              top: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF22D3EE),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'IMMERSIVE EXPERIENCE',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: Color(0xFF67E8F9),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Text Content & CTA inside Hero
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Title & Description
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Explore a New World',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.25,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Discover immersive AR & VR learning experiences.',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFCFFAFE),
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Button: Explore AR/VR
                  GestureDetector(
                    onTap: controller.onOpenAr,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF127FD2),
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF127FD2).withValues(alpha: 0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Explore AR',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(
                            PhosphorIconsBold.arrowRight,
                            size: 11,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 3. EXPLORE FEATURES (Feature Entry Points replacing lesson cards)
  Widget _buildExploreFeaturesSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Expanded(
              child: Text(
                'EXPLORE FEATURES',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: Color(0xFF64748B),
                ),
              ),
            ),
            const SizedBox(width: 8),

            GestureDetector(
              onTap: controller.onSearchTap,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF127FD2),
                      ),
                    ),
                    SizedBox(width: 3),
                    Icon(
                      PhosphorIconsBold.caretRight,
                      size: 10,
                      color: Color(0xFF127FD2),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Horizontal Carousel of Feature Cards (Approved Figma Card UI)
        SizedBox(
          height: 168,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.recommendedModules.length,
            itemBuilder: (context, index) {
              final module = controller.recommendedModules[index];
              return _buildModuleCard(module);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildModuleCard(RecommendedModuleItem module) {
    // Parse hex colors safely
    Color catColor = const Color(0xFF127FD2);
    Color catBg = const Color(0xFFEFF6FF);
    Color catBorder = const Color(0xFFBFDBFE);

    if (module.categoryColor == '#047857') {
      catColor = const Color(0xFF047857);
      catBg = const Color(0xFFECFDF5);
      catBorder = const Color(0xFFA7F3D0);
    } else if (module.categoryColor == '#B45309') {
      catColor = const Color(0xFFB45309);
      catBg = const Color(0xFFFFFBEB);
      catBorder = const Color(0xFFFDE68A);
    } else if (module.categoryColor == '#7C3AED') {
      catColor = const Color(0xFF7C3AED);
      catBg = const Color(0xFFF5F3FF);
      catBorder = const Color(0xFFDDD6FE);
    } else if (module.categoryColor == '#0284C7') {
      catColor = const Color(0xFF0284C7);
      catBg = const Color(0xFFF0F9FF);
      catBorder = const Color(0xFFBAE6FD);
    }

    return Container(
      width: 248,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0).withValues(alpha: 0.9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top Tags (Category badge & Type tag)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: catBg,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: catBorder),
                ),
                child: Text(
                  module.category,
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: catColor,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    module.typeTag.contains('VR')
                        ? PhosphorIconsBold.headset
                        : module.typeTag.contains('Scan')
                            ? PhosphorIconsBold.radical
                            : module.typeTag.contains('Quiz')
                                ? PhosphorIconsBold.clipboardText
                                : module.typeTag.contains('Assistant')
                                    ? PhosphorIconsBold.magicWand
                                    : PhosphorIconsBold.cube,
                    size: 11,
                    color: catColor,
                  ),
                  const SizedBox(width: 3),
                  Text(
                    module.typeTag,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Title
          Text(
            module.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),

          // Description
          Text(
            module.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: Color(0xFF64748B),
              height: 1.35,
            ),
          ),

          // Horizontal Border Divider & Footer Actions
          Container(
            padding: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      PhosphorIconsBold.sparkle,
                      size: 11,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      module.duration,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: module.onTap,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        module.actionLabel,
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: catColor,
                        ),
                      ),
                      const SizedBox(width: 2),
                      Icon(
                        PhosphorIconsBold.caretRight,
                        size: 10,
                        color: catColor,
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

  // 5. SELF-PACED LEARNING: E-mmerxedu In-App Browser Card
  Widget _buildSelfPacedCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF38BDF8), Color(0xFF0284C7), Color(0xFF0C4A6E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0C4A6E).withValues(alpha: 0.25),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background Glow Circle
          Positioned(
            right: -10,
            bottom: -10,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),

          // Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left Description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'In-App Browser',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 9,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0284C7),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Flexible(
                          child: Text(
                            'e-mmerxedu.com',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFE0F2FE),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Learn at Your Own Pace',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Explore self-paced courses and vocational training modules.',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFE0F2FE),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Action Button
              GestureDetector(
                onTap: controller.openEmmerxeduWebView,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Explore Courses',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF0284C7),
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        PhosphorIconsBold.arrowSquareOut,
                        size: 11,
                        color: Color(0xFF0284C7),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 6. RECENT ACTIVITY (Feature-based: Quiz, Points, AI, AR)
  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'RECENT ACTIVITY',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: Color(0xFF64748B),
              ),
            ),
            Text(
              'Feature history',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // List of Feature-based Recent Activities
        ...controller.recentActivities.map((activity) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: activity.iconBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Icon(
                      activity.icon,
                      size: 17,
                      color: activity.iconColor,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              activity.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          Text(
                            activity.timeAgo,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              activity.subtitle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 3,
                            height: 3,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFCBD5E1),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            activity.pointsEarned,
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: activity.iconColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  // 7. PROGRESS & REWARDS: Compact Horizontal Section
  Widget _buildProgressRewardsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0).withValues(alpha: 0.8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Streak & Rewards Counter
          Row(
            children: [
              // Streak
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEB),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          PhosphorIconsBold.fire,
                          size: 16,
                          color: Color(0xFFF59E0B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              '${controller.streakDays.value} Day Streak',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          const Text(
                            'Active learner',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF059669),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Vertical Divider
              Container(
                width: 1,
                height: 28,
                color: const Color(0xFFE2E8F0),
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),

              // Rewards
              Expanded(
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F6FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          PhosphorIconsBold.medal,
                          size: 16,
                          color: Color(0xFF127FD2),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              '${controller.rewardsTokens.value} Rewards',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ),
                          const Text(
                            'Tokens earned',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF94A3B8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Wallet Micro Link
              GestureDetector(
                onTap: controller.onOpenRewards,
                child: const Text(
                  'Wallet',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF127FD2),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Divider & Motivational Footer
          Container(
            padding: const EdgeInsets.only(top: 6),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF1F5F9), width: 1)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Keep learning to unlock more rewards and features.',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ),
                Icon(
                  PhosphorIconsFill.lightning,
                  size: 12,
                  color: Color(0xFFF59E0B),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 8. WHAT'S NEW: Announcements & Updates
  Widget _buildWhatsNewSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'WHAT\'S NEW',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.6,
                color: Color(0xFF64748B),
              ),
            ),
            Text(
              'Recent releases',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: Color(0xFF94A3B8),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Item 1: New 3D Simulations in AR
        _buildReleaseItem(
          icon: PhosphorIconsBold.cube,
          iconBg: const Color(0xFFE0F6FF),
          iconColor: const Color(0xFF127FD2),
          title: 'New 3D AR Tools Released',
          badge: 'New',
          badgeColor: const Color(0xFF127FD2),
          description: 'Interactive real-world 3D simulations now ready to explore.',
          onTap: controller.onOpenAr,
        ),
        const SizedBox(height: 8),

        // Item 2: Low-Bandwidth Mode
        _buildReleaseItem(
          icon: PhosphorIconsBold.cloudArrowDown,
          iconBg: const Color(0xFFECFDF5),
          iconColor: const Color(0xFF059669),
          title: 'Low-Bandwidth Mode Enabled',
          badge: 'v2.4',
          badgeColor: const Color(0xFF059669),
          description: 'Download 3D simulations faster with optimized data saver.',
          onTap: controller.toggleLowBandwidth,
        ),
      ],
    );
  }

  Widget _buildReleaseItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String badge,
    required Color badgeColor,
    required String description,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0).withValues(alpha: 0.8)),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(icon, size: 18, color: iconColor),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        badge,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Floating Bottom Pill Navigation Bar (Rectangle 17)
  Widget _buildFloatingBottomNav() {
    return Container(
      height: 61,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(53),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(9, 30, 66, 0.25),
            blurRadius: 8,
            offset: Offset(0, 4),
            spreadRadius: -2,
          ),
          BoxShadow(
            color: Color.fromRGBO(9, 30, 66, 0.08),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Obx(
        () => Row(
          children: [
            // Home (Active)
            _buildNavItem(
              index: 0,
              icon: PhosphorIconsBold.house,
              isSelected: controller.currentNavIndex.value == 0,
              onTap: () => controller.currentNavIndex.value = 0,
            ),

            // Explore (Compass)
            _buildNavItem(
              index: 1,
              icon: PhosphorIconsBold.compass,
              isSelected: controller.currentNavIndex.value == 1,
              onTap: () => controller.currentNavIndex.value = 1,
            ),

            // Medals / Rewards
            _buildNavItem(
              index: 2,
              icon: PhosphorIconsBold.medal,
              isSelected: controller.currentNavIndex.value == 2,
              onTap: () => controller.currentNavIndex.value = 2,
            ),

            // Profile
            _buildNavItem(
              index: 3,
              icon: PhosphorIconsBold.userCircle,
              isSelected: controller.currentNavIndex.value == 3,
              onTap: () => controller.currentNavIndex.value = 3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(53),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: const Color(0xFF0E3856),
              ),
              const SizedBox(height: 4),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 1.0 : 0.0,
                child: Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF4CACD9),
                        Color(0xFF2175AE),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
