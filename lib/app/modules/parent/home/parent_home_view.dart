import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'parent_home_controller.dart';

class ParentHomeView extends GetView<ParentHomeController> {
  const ParentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildFeaturedHeroCard(),
              const SizedBox(height: 28),
              _buildExploreLearningSection(),
              const SizedBox(height: 28),
              _buildMyChildrenSection(),
              const SizedBox(height: 28),
              _buildLessonNotesSection(),
              const SizedBox(height: 28),
              _buildRecentActivitySection(),
              const SizedBox(height: 24),
              _buildBottomProgressButton(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // 1. Top Header with Parent greeting & Avatar
  Widget _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Text(
                  'Hello, ${controller.userName.value}!',
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF191C1D),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Explore learning or track your Children’s progress',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF476083),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          onTap: controller.onProfileTap,
          borderRadius: BorderRadius.circular(9999),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/student_avatar_sarah.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFD8E2FF),
                      child: const Icon(
                        Icons.person_rounded,
                        color: Color(0xFF0059BB),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 13,
                  height: 13,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0059BB),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 2. Featured Learning Card (Primary Hero)
  Widget _buildFeaturedHeroCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF52B4DF), Color(0xFF10629E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF10629E).withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Background ambient blurred motif
          Positioned(
            right: -24,
            top: -24,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
            ),
          ),
          // 3D/VR Watermark icon
          Positioned(
            right: -10,
            bottom: -10,
            child: Icon(
              Icons.view_in_ar_rounded,
              size: 110,
              color: Colors.white.withValues(alpha: 0.14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Frosted Pill: FEATURED EXPERIENCE
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.20),
                    borderRadius: BorderRadius.circular(9999),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 13),
                      SizedBox(width: 6),
                      Text(
                        'FEATURED EXPERIENCE',
                        style: TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Explore Interactive Learning',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Discover engaging ways your child can learn, practise and explore with immersive 3D & AI.',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFD8E2FF),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                // Explore Now Button
                InkWell(
                  onTap: controller.onExploreNow,
                  borderRadius: BorderRadius.circular(9999),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(9999),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Explore Now',
                          style: TextStyle(
                            fontFamily: 'Google Sans Flex',
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF127FD2),
                          ),
                        ),
                        SizedBox(width: 6),
                        Icon(Icons.arrow_forward_rounded, size: 15, color: Color(0xFF127FD2)),
                      ],
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

  // 3. Explore Learning (6 Parent Direct Access Modules)
  Widget _buildExploreLearningSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Explore Learning',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF191C1D),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Interactive tools & experiences (Direct Parent Access)',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF476083),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F6FF),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: const Text(
                '6 Modules',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF127FD2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // 3x2 Grid for Responsive Mobile Cards
        Row(
          children: [
            Expanded(child: _buildModuleCard(controller.exploreModules[0])),
            const SizedBox(width: 10),
            Expanded(child: _buildModuleCard(controller.exploreModules[1])),
            const SizedBox(width: 10),
            Expanded(child: _buildModuleCard(controller.exploreModules[2])),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _buildModuleCard(controller.exploreModules[3])),
            const SizedBox(width: 10),
            Expanded(child: _buildModuleCard(controller.exploreModules[4])),
            const SizedBox(width: 10),
            Expanded(child: _buildModuleCard(controller.exploreModules[5])),
          ],
        ),
      ],
    );
  }

  Widget _buildModuleCard(ExploreModuleModel module) {
    return InkWell(
      onTap: () => controller.openModule(module),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFECEFF2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: module.iconBgColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                module.icon,
                color: module.iconColor,
                size: 19,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              module.title,
              style: const TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              module.subtitle,
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 11,
                fontWeight: module.isHighlight ? FontWeight.w700 : FontWeight.w500,
                color: module.isHighlight ? const Color(0xFF127FD2) : const Color(0xFF476083),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  // 4. My Children Section
  Widget _buildMyChildrenSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'My Children',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F6FF),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  '${controller.children.length} Linked',
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF001C3A),
                  ),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: controller.onAddChild,
              borderRadius: BorderRadius.circular(8),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: Row(
                  children: [
                    Icon(Icons.add_rounded, size: 16, color: Color(0xFF127FD2)),
                    SizedBox(width: 3),
                    Text(
                      'Add Child',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF127FD2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Obx(
          () => Column(
            children: [
              for (int i = 0; i < controller.children.length; i++) ...[
                _buildChildCard(controller.children[i]),
                const SizedBox(height: 14),
              ],
            ],
          ),
        ),
        // Reassurance Note Banner
        _buildReassuranceBanner(),
      ],
    );
  }

  Widget _buildChildCard(ChildProgressModel child) {
    final isSecondary = child.id == 'tony';

    return InkWell(
      onTap: () => controller.onViewFullProgress(child),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECEFF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Child Header Info
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFE1E3E4), width: 1.5),
                ),
                child: ClipOval(
                  child: Image.asset(
                    child.avatar,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: const Color(0xFFD8E2FF),
                      child: const Icon(Icons.person_rounded, color: Color(0xFF0059BB)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      child.name,
                      style: const TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      child.gradeAndSchool,
                      style: const TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF476083),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F5),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  child.status,
                  style: const TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF476083),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Progress Track Box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F5).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Curriculum Progress',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                    Text(
                      child.curriculumLessons,
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: isSecondary ? const Color(0xFF127FD2) : const Color(0xFF476083),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(9999),
                  child: LinearProgressIndicator(
                    value: child.progressPercent,
                    minHeight: 8,
                    backgroundColor: const Color(0xFFE1E3E4),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isSecondary ? const Color(0xFF127FD2) : const Color(0xFF476083),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Recent quiz / equation note
                Row(
                  children: [
                    Icon(
                      child.recentIcon,
                      size: 14,
                      color: const Color(0xFF4B6062),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        child.recentActivity,
                        style: const TextStyle(
                          fontFamily: 'Google Sans Flex',
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF476083),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Bottom Right Link: View Full Progress
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () => controller.onViewFullProgress(child),
              borderRadius: BorderRadius.circular(6),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View Full Progress',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF127FD2),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: Color(0xFF127FD2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  Widget _buildReassuranceBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE6E8EA)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.people_outline_rounded,
            color: Color(0xFF476083),
            size: 20,
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Need to link another student? Tools above remain open to all.',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: Color(0xFF414754),
                height: 1.3,
              ),
            ),
          ),
          const SizedBox(width: 8),
          InkWell(
            onTap: controller.onAddChild,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 3,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: const Text(
                '+ Add',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 11,
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

  // 5. Lesson Notes Section
  Widget _buildLessonNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'Lesson Notes',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFD0E7EA),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'US (NGSS)',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF091F21),
                ),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: controller.onViewAllLessonNotes,
              child: const Text(
                'View All',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF127FD2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        // Horizontal cards
        SizedBox(
          height: 168,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: controller.lessonNotes.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final note = controller.lessonNotes[index];
              return _buildLessonNoteCard(note);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLessonNoteCard(LessonNoteModel note) {
    return Container(
      width: 245,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFECEFF2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Grade + PDF pgs
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: note.badgeBgColor,
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: Text(
                  note.gradeBadge,
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: note.badgeTextColor,
                  ),
                ),
              ),
              Text(
                note.pageCount,
                style: const TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF476083),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            note.title,
            style: const TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191C1D),
              height: 1.25,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            note.subtitle,
            style: const TextStyle(
              fontFamily: 'Google Sans Flex',
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Color(0xFF476083),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          // Quick Preview Button
          InkWell(
            onTap: () => controller.onPreviewLessonNote(note),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.visibility_outlined,
                    size: 14,
                    color: Color(0xFF127FD2),
                  ),
                  SizedBox(width: 6),
                  Text(
                    'Quick Preview',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF127FD2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 6. Recent Activity Section
  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Recent Activity',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xFF191C1D),
              ),
            ),
            InkWell(
              onTap: controller.onViewAllRecentActivity,
              child: const Text(
                'VIEW ALL',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF127FD2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFECEFF2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildActivityItem(controller.recentActivities[0]),
              const Divider(color: Color(0xFFF0F2F5), height: 24),
              _buildActivityItem(controller.recentActivities[1]),
              const Divider(color: Color(0xFFF0F2F5), height: 24),
              _buildActivityItem(controller.recentActivities[2]),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(RecentActivityItemModel activity) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: activity.iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            activity.icon,
            color: activity.iconColor,
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.title,
                style: const TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 3),
              Row(
                children: [
                  if (activity.score != null) ...[
                    Text(
                      activity.score!,
                      style: const TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF127FD2),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text('•', style: TextStyle(color: Color(0xFF476083), fontSize: 11)),
                    const SizedBox(width: 4),
                  ] else if (activity.extraInfo.isNotEmpty) ...[
                    Text(
                      activity.extraInfo,
                      style: const TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF476083),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text('•', style: TextStyle(color: Color(0xFF476083), fontSize: 11)),
                    const SizedBox(width: 4),
                  ],
                  Text(
                    activity.timeAgo,
                    style: const TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF476083),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // 7. Bottom View Full Progress Button
  Widget _buildBottomProgressButton() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF56B9E3), Color(0xFF0E5E9B)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(74),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0E5E9B).withValues(alpha: 0.25),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.onViewFullProgress(null),
          borderRadius: BorderRadius.circular(74),
          child: const Center(
            child: Text(
              'View Full Progress',
              style: TextStyle(
                fontFamily: 'Google Sans Flex',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
