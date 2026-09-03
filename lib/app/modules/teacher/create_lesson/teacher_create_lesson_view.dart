import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remixicon/remixicon.dart';
import '../../../core/themes/app_textstyle.dart';
import 'teacher_create_lesson_controller.dart';

class TeacherCreateLessonView extends GetView<TeacherCreateLessonController> {
  const TeacherCreateLessonView({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<TeacherCreateLessonController>()) {
      Get.put(TeacherCreateLessonController());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            _buildTopBar(),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Lesson Information
                    _buildLessonInformationCard(),
                    const SizedBox(height: 16),

                    // Section 2: Lesson Notes
                    _buildLessonNotesSection(),
                    const SizedBox(height: 16),

                    // Section 3: Add Content
                    _buildAddContentSection(),
                    const SizedBox(height: 16),

                    // Section 4: Visible to Students
                    _buildVisibilityCard(),
                    const SizedBox(height: 24),

                    // Section 5: Create Lesson Button
                    _buildCreateLessonButton(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Top App Bar
  // ---------------------------------------------------------------------------
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          // Back Button (40x40 circle button)
          GestureDetector(
            onTap: controller.onBack,
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF191C1D),
                  size: 22,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Title
          const Text(
            'Create Lesson',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Color(0xFF191C1D),
              height: 32 / 24,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 1: Lesson Information
  // ---------------------------------------------------------------------------
  Widget _buildLessonInformationCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE3E3E3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Text(
            'Lesson Information',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF191C1D),
              height: 24 / 16,
            ),
          ),
          const SizedBox(height: 16),

          // Lesson Title Label
          const Text(
            'Lesson Title',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF414754),
              letterSpacing: 0.14,
            ),
          ),
          const SizedBox(height: 8),

          // Lesson Title Input (50px height)
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFC1C6D7), width: 1),
            ),
            child: TextField(
              controller: controller.titleController,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 15,
                color: Color(0xFF191C1D),
              ),
              decoration: const InputDecoration(
                hintText: 'Enter lesson title',
                hintStyle: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9CA3AF),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Description Label
          const Text(
            'Description',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF414754),
              letterSpacing: 0.14,
            ),
          ),
          const SizedBox(height: 8),

          // Description Textarea (98px height)
          Container(
            height: 98,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFC1C6D7), width: 1),
            ),
            child: TextField(
              controller: controller.descriptionController,
              maxLines: 3,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 15,
                color: Color(0xFF191C1D),
              ),
              decoration: const InputDecoration(
                hintText: 'Add a short description about this lesson',
                hintStyle: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9CA3AF),
                  height: 1.4,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Class & Subject Row
          Row(
            children: [
              // Class Card
              Expanded(
                child: GestureDetector(
                  onTap: controller.onSelectClass,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Class',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF414754),
                            height: 16 / 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(
                          () => Text(
                            controller.selectedClass.value,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF191C1D),
                              height: 24 / 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Subject Card
              Expanded(
                child: GestureDetector(
                  onTap: controller.onSelectSubject,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F4F5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Subject',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF414754),
                            height: 16 / 12,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(
                          () => Text(
                            controller.selectedSubject.value,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF191C1D),
                              height: 24 / 16,
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
    );
  }

  // ---------------------------------------------------------------------------
  // Section 2: Lesson Notes
  // ---------------------------------------------------------------------------
  Widget _buildLessonNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lesson Notes',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF191C1D),
            height: 24 / 16,
          ),
        ),
        const SizedBox(height: 8),

        // Textarea (146px height)
        Container(
          height: 146,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFC1C6D7), width: 1),
          ),
          child: TextField(
            controller: controller.notesController,
            maxLines: 5,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 15,
              color: Color(0xFF191C1D),
            ),
            decoration: const InputDecoration(
              hintText: '|Write lesson notes...',
              hintStyle: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: Color(0xFF9CA3AF),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // Section 3: Add Content Section (Grey Card with 2x2 Grid + Video URL)
  // ---------------------------------------------------------------------------
  Widget _buildAddContentSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          const Text(
            'Add Content',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Color(0xFF191C1D),
              height: 24 / 16,
            ),
          ),
          const SizedBox(height: 16),

          // 2x2 Grid: Row 1 (Documents & Images)
          Row(
            children: [
              Expanded(
                child: _buildUploadCard(
                  icon: Remix.file_text_line,
                  label: 'Documents',
                  onTap: controller.onUploadDocuments,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildUploadCard(
                  icon: Remix.image_line,
                  label: 'Images',
                  onTap: controller.onUploadImages,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 2x2 Grid: Row 2 (Audio & Assessments)
          Row(
            children: [
              Expanded(
                child: _buildUploadCard(
                  icon: Remix.music_2_line,
                  label: 'Audio',
                  onTap: controller.onUploadAudio,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildUploadCard(
                  icon: Remix.questionnaire_line,
                  label: 'Assessments',
                  onTap: controller.onAddAssessments,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Video URL Label
          const Text(
            'Video URL',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Color(0xFF414754),
              letterSpacing: 0.14,
            ),
          ),
          const SizedBox(height: 8),

          // Video URL Input Field (50px height)
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFC1C6D7), width: 1),
            ),
            child: TextField(
              controller: controller.videoUrlController,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 15,
                color: Color(0xFF191C1D),
              ),
              decoration: const InputDecoration(
                hintText: 'Paste video URL',
                hintStyle: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF9CA3AF),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Helper Text
          const Text(
            'Add a link to the video you want to include in this lesson.',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF191C1D),
              height: 16 / 12,
            ),
          ),
          const SizedBox(height: 12),

          // ADD VIDEO Button
          GestureDetector(
            onTap: controller.onAddVideo,
            child: Container(
              width: double.infinity,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFE0F6FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'ADD VIDEO',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF127FD2),
                    letterSpacing: 0.35,
                  ),
                ),
              ),
            ),
          ),

          // Video Preview Card (Obx)
          Obx(() {
            if (!controller.hasUploadedVideo.value) {
              return const SizedBox.shrink();
            }
            return Padding(
              padding: const EdgeInsets.only(top: 14.0),
              child: Container(
                height: 74,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFC1C6D7).withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    // Video Thumbnail Placeholder
                    Container(
                      width: 64,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE1E3E4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.play_circle_outline_rounded,
                          color: Color(0xFF414754),
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Label
                    const Expanded(
                      child: Text(
                        'Uploaded Video',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF191C1D),
                          letterSpacing: 0.14,
                        ),
                      ),
                    ),

                    // Remove Button
                    GestureDetector(
                      onTap: controller.onRemoveVideo,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        child: const Text(
                          'REMOVE',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFBA1A1A),
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  // Helper for 2x2 upload button
  Widget _buildUploadCard({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFC1C6D7), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Circular Icon Container
            Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: Color(0x1A0059BB),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  icon,
                  color: const Color(0xFF0059BB),
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Label
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF191C1D),
                letterSpacing: 0.14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 4: Visible to Students Card
  // ---------------------------------------------------------------------------
  Widget _buildVisibilityCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Text Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Visible to Students',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF191C1D),
                    height: 24 / 16,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Allow students to see this lesson',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF414754),
                    height: 16 / 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          // Custom Toggle
          Obx(
            () => GestureDetector(
              onTap: () => controller.toggleVisibility(!controller.isVisibleToStudents.value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 44,
                height: 24,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9999),
                  color: controller.isVisibleToStudents.value
                      ? const Color(0xFF127FD2)
                      : const Color(0xFFD1D5DB),
                ),
                child: AnimatedAlign(
                  duration: const Duration(milliseconds: 200),
                  alignment: controller.isVisibleToStudents.value
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xFFD1D5DB),
                        width: 1,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x1A000000),
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Section 5: Create Lesson Button
  // ---------------------------------------------------------------------------
  Widget _buildCreateLessonButton() {
    return GestureDetector(
      onTap: controller.onCreateLesson,
      child: Container(
        width: double.infinity,
        height: 54,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(74),
          gradient: const LinearGradient(
            colors: [
              Color(0xFF56B9E3),
              Color(0xFF0E5E9B),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x26000000),
              offset: Offset(0, 4),
              blurRadius: 4,
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Create Lesson',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}
