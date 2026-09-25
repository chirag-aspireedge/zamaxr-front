import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'student_search_controller.dart';

class StudentSearchView extends StatelessWidget {
  final bool isTab;
  const StudentSearchView({super.key, this.isTab = false});

  StudentSearchController get controller =>
      Get.isRegistered<StudentSearchController>()
          ? Get.find<StudentSearchController>()
          : Get.put(StudentSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar with Back Button, Search Field, and Notification
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: _buildTopBar(context),
            ),
            // Body: Reactive Search Results
            Expanded(
              child: Obx(() => _buildSearchResults()),
            ),
          ],
        ),
      ),
    );
  }

  // Top Bar: Back Button, Search Field (Rectangle 33), Notification Button
  Widget _buildTopBar(BuildContext context) {
    return Row(
      children: [
        // Circular Back Button (Ellipse 18)
        GestureDetector(
          onTap: controller.onBackTap,
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F5),
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.08),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Icon(
              PhosphorIcons.arrowLeft(PhosphorIconsStyle.bold),
              size: 20,
              color: const Color(0xFF1567A2),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Search Field Pill (Rectangle 33)
        Expanded(
          child: Container(
            height: 44,
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
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                Icon(
                  PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.regular),
                  size: 18,
                  color: const Color(0xFF1567A2),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: controller.searchTextController,
                    focusNode: controller.searchFocusNode,
                    onChanged: controller.onSearchChanged,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191C1D),
                    ),
                    decoration: InputDecoration(
                      hintText: controller.isIndividual
                          ? 'Search features & tools...'
                          : 'Search subject...',
                      hintStyle: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF717786),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
                Obx(
                  () => controller.query.value.isNotEmpty
                      ? GestureDetector(
                          onTap: controller.clearSearch,
                          child: Icon(
                            PhosphorIcons.xCircle(PhosphorIconsStyle.fill),
                            size: 18,
                            color: const Color(0xFF717786),
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Circular Notification Button
        GestureDetector(
          onTap: controller.onNotificationTap,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F5),
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Icon(
                  PhosphorIcons.bell(PhosphorIconsStyle.bold),
                  size: 20,
                  color: const Color(0xFF1567A2),
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
                            color: Color(0xFF1567A2),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white,
                                spreadRadius: 1.5,
                              ),
                            ],
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Search & Explore Results Layout
  Widget _buildSearchResults() {
    final results = controller.searchResults;

    if (results.isEmpty) {
      return _buildNoResultsState();
    }

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20, 16, 20, isTab ? 110 : 32),
      children: [
        // Title & Count Subtitle
        Obx(
          () => Text(
            controller.isSearching
                ? 'Search Results'
                : (controller.isIndividual ? 'Explore Features' : 'Explore Topics'),
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.14,
              color: Color(0xFF414754),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Obx(
          () => Text(
            controller.resultsCountSummary,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF414754),
            ),
          ),
        ),
        const SizedBox(height: 18),
        // Filter Pills Row (All, Lessons, Subjects, AR Experiences)
        _buildFilterPills(),
        const SizedBox(height: 20),
        // Result Cards List
        ...results.map((result) {
          return _buildResultCard(result);
        }),
      ],
    );
  }

  // State 3: No Search Results Found (Figma CSS Layout)
  Widget _buildNoResultsState() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20, 24, 20, isTab ? 110 : 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          // 192x192 Empty state illustration with drop-shadow (Figma specs)
          Container(
            width: 192,
            height: 192,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.12),
                  blurRadius: 25,
                  offset: Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                AppAssets.searchEmptyState,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFF0F7FF),
                    alignment: Alignment.center,
                    child: Icon(
                      PhosphorIcons.bookOpen(PhosphorIconsStyle.duotone),
                      size: 72,
                      color: const Color(0xFF1567A2),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 32),
          // Heading 2: "No results found"
          const Text(
            'No results found',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              height: 1.4,
              letterSpacing: -0.3,
              color: Color(0xFF191C1D),
            ),
          ),
          const SizedBox(height: 12),
          // Subtitle / Body text
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 280),
            child: Text(
              controller.isIndividual
                  ? "We couldn't find matches for your search. Try searching for another subject, AR experience or topic."
                  : "We couldn't find matches for your search. Try searching for another subject, lesson or topic.",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.55,
                color: Color(0xFF414754),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // Filter Pills Horizontal Bar
  Widget _buildFilterPills() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Obx(
        () => Row(
          children: controller.categories.map((cat) {
            final isSelected = controller.selectedCategory.value == cat;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => controller.selectCategory(cat),
                  borderRadius: BorderRadius.circular(9999),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF127FD2)
                          : const Color(0xFFEDEEEF),
                      borderRadius: BorderRadius.circular(9999),
                    ),
                    child: Text(
                      cat,
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? Colors.white : const Color(0xFF191C1D),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Result Card (Rectangle 34 & 35)
  Widget _buildResultCard(StudentSearchResultModel result) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFE3E3E3),
          width: 1,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.03),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Tag (Uppercase, e.g. BIOLOGY, CHEMISTRY)
          Text(
            result.category,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.6,
              color: Color(0xFF476083),
            ),
          ),
          const SizedBox(height: 6),
          // Subject Title
          Text(
            result.title,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              height: 28 / 22,
              color: Color(0xFF191C1D),
            ),
          ),
          const SizedBox(height: 8),
          // Description
          Text(
            result.description,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              height: 22 / 15,
              color: Color(0xFF414754),
            ),
          ),
          const SizedBox(height: 12),
          // Metadata Line: Class 8 • Biology (Student role only)
          if (!controller.isIndividual) ...[
            Row(
              children: [
                Text(
                  result.gradeLevel,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF414754),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: Color(0xFFC1C6D7),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  result.subject,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF414754),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
          ],
          // Media Badges Row
          Row(
            children: result.mediaBadges.map((badge) {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: badge.backgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: badge.hasActiveGlow
                      ? const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 89, 187, 0.3),
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Icon(
                  badge.icon,
                  size: 15,
                  color: badge.iconColor,
                ),
              );
            }).toList(),
          ),
          // Progress Section (for in-progress courses)
          if (result.hasProgress) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Progress',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF414754),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    result.progressText,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0059BB),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(9999),
              child: LinearProgressIndicator(
                value: result.progress,
                minHeight: 6,
                backgroundColor: const Color(0xFFE1E3E4),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFF0E3856),
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),
          // CTA Button (Rectangle 7, Continue Lesson / Start Lesson)
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: () => controller.onResultAction(result),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF56B9E3),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(74),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      controller.getCtaText(result),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    PhosphorIcons.arrowRight(PhosphorIconsStyle.bold),
                    size: 16,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
