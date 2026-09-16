import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_textstyle.dart';
import 'parent_quiz_model.dart';
import 'parent_quizzes_controller.dart';

class ParentQuizzesView extends GetView<ParentQuizzesController> {
  const ParentQuizzesView({super.key});

  static const String fontFamily = AppTextStyle.fontFamily;

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<ParentQuizzesController>()) {
      Get.put(ParentQuizzesController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Top Navigation & Actions Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(),
                          child: Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 16,
                              color: Color(0xFF191C1D),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Quizzes',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: fontFamily,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF191C1D),
                                ),
                              ),
                              Text(
                                'Adaptive Learning & Practice',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: fontFamily,
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
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: controller.onCreateNewQuiz,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF127FD2), Color(0xFF0E5E9B)],
                        ),
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF127FD2).withValues(alpha: 0.25),
                            offset: const Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, size: 16, color: Colors.white),
                          SizedBox(width: 4),
                          Text(
                            'Create',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // 1. Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildSearchBar(),
            ),
            const SizedBox(height: 16),

            // 2. Filter Pills: All, Active, Inactive
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: _buildFilterTabs(),
            ),
            const SizedBox(height: 16),

            // 3. Quiz Cards List
            Expanded(
              child: Obx(() {
                final quizList = controller.filteredQuizzes;

                if (quizList.isEmpty) {
                  return _buildEmptyState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 32.0),
                  physics: const BouncingScrollPhysics(),
                  itemCount: quizList.length,
                  itemBuilder: (context, index) {
                    final quiz = quizList[index];
                    return _buildQuizCard(quiz);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // --- Search Bar ---
  Widget _buildSearchBar() {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE0F6FF),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          const Icon(
            Icons.search,
            size: 20,
            color: Color(0xFF5F6368),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller.searchController,
              onChanged: controller.onSearchChanged,
              style: const TextStyle(
                fontFamily: fontFamily,
                fontSize: 14,
                color: Color(0xFF191C1D),
              ),
              decoration: const InputDecoration(
                hintText: 'Search quizzes or subjects...',
                hintStyle: TextStyle(
                  fontFamily: fontFamily,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0x4F000000),
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          Obx(() {
            if (controller.searchQuery.value.isNotEmpty) {
              return GestureDetector(
                onTap: controller.onClearSearch,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(
                    Icons.close,
                    size: 18,
                    color: Color(0xFF5F6368),
                  ),
                ),
              );
            }
            return const SizedBox(width: 14);
          }),
        ],
      ),
    );
  }

  // --- Filter Tabs: All, Active, Inactive ---
  Widget _buildFilterTabs() {
    final tabs = [
      {'label': 'All', 'minWidth': 50.0},
      {'label': 'Active', 'minWidth': 82.0},
      {'label': 'Inactive', 'minWidth': 108.0},
    ];

    return Obx(() {
      final currentTab = controller.selectedTabIndex.value;

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: tabs.asMap().entries.map((entry) {
            final idx = entry.key;
            final tab = entry.value;
            final isSelected = currentTab == idx;
            final label = tab['label'] as String;
            final minWidth = tab['minWidth'] as double;

            return Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: GestureDetector(
                onTap: () => controller.onSelectTab(idx),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  curve: Curves.easeInOut,
                  constraints: BoxConstraints(minWidth: minWidth),
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF127FD2) : const Color(0xFFE8E8E8),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.14,
                        color: isSelected ? Colors.white : const Color(0xFF131313),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }

  // --- Quiz Card Item ---
  Widget _buildQuizCard(ParentQuizModel quiz) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFF0F0F0),
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            offset: const Offset(0, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Status Badge + Date + More Menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      _buildStatusBadge(quiz.isActive),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          quiz.date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF717786),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => controller.onQuizOptions(quiz),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(
                      Icons.more_vert,
                      size: 20,
                      color: Color(0xFF717786),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Primary Card Title
            Text(
              quiz.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: fontFamily,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
                letterSpacing: -0.1,
              ),
            ),
            const SizedBox(height: 2),

            // Subtitle: Chapter
            Text(
              quiz.chapter,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF5F6368),
              ),
            ),
            const SizedBox(height: 3),

            // Class Subject Tag
            Text(
              quiz.classSubject,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: fontFamily,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF127FD2),
                letterSpacing: 0.1,
              ),
            ),
            const SizedBox(height: 10),

            Divider(
              height: 1,
              thickness: 0.8,
              color: const Color(0xFFE1E3E4).withValues(alpha: 0.5),
            ),
            const SizedBox(height: 10),

            // Stats Row: Questions & Duration
            Wrap(
              spacing: 20,
              runSpacing: 8,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.article_outlined,
                      size: 15,
                      color: Color(0xFF5F6368),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${quiz.questionCount} Questions',
                      style: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5F6368),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 15,
                      color: Color(0xFF5F6368),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${quiz.durationMinutes} min',
                      style: const TextStyle(
                        fontFamily: fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF5F6368),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Assignment Container
            Container(
              height: 34,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  if (quiz.isAssigned) ...[
                    const Icon(
                      Icons.face_rounded,
                      size: 16,
                      color: Color(0xFF127FD2),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Assigned to ${quiz.assignedChild}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                    ),
                  ] else ...[
                    const Icon(
                      Icons.hourglass_empty,
                      size: 14,
                      color: Color(0xFF717786),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Not assigned yet',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF717786),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Action Buttons Row: Regenerate Quiz + Assign
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.onRegenerateQuiz(quiz),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFE0F6FF),
                            Color(0xFFFFFFFF),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                          color: const Color(0xFFE0F6FF),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            offset: const Offset(0, 2),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.refresh,
                            size: 16,
                            color: Color(0xFF127FD2),
                          ),
                          SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'Regenerate',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF191C1D),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => controller.onQuizOptions(quiz),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF127FD2),
                            Color(0xFF0E5E9B),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(60),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF127FD2).withValues(alpha: 0.25),
                            offset: const Offset(0, 3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.settings_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                          SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              'Options',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: fontFamily,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- Status Badge Helper ---
  Widget _buildStatusBadge(bool isActive) {
    if (isActive) {
      return Container(
        height: 18,
        padding: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: const Color(0xFFD7F8E0),
          borderRadius: BorderRadius.circular(9999),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle,
              size: 10,
              color: Color(0xFF0E7A2E),
            ),
            SizedBox(width: 4),
            Text(
              'ACTIVE',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: Color(0xFF0E7A2E),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      height: 18,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(9999),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.pause_circle_outline,
            size: 10,
            color: Color(0xFF717786),
          ),
          SizedBox(width: 4),
          Text(
            'INACTIVE',
            style: TextStyle(
              fontFamily: fontFamily,
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: Color(0xFF414754),
            ),
          ),
        ],
      ),
    );
  }

  // --- Empty State ---
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFFE0F6FF).withValues(alpha: 0.5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.quiz_outlined,
                size: 32,
                color: Color(0xFF127FD2),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Quizzes Found',
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Try adjusting your search or tab filters to find existing quizzes.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: fontFamily,
                fontSize: 14,
                color: Color(0xFF717786),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
