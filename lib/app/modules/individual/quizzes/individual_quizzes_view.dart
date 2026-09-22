import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/themes/app_textstyle.dart';
import 'individual_quizzes_controller.dart';

class IndividualQuizzesView extends GetView<IndividualQuizzesController> {
  const IndividualQuizzesView({super.key});

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
          child: Column(
            children: [
              // Top Bar: Circular Back Button & "Quizzes" Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: controller.onBackTap,
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFFF3F4F5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            PhosphorIconsBold.arrowLeft,
                            size: 16,
                            color: Color(0xFF191C1D),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Quizzes',
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontWeight: FontWeight.w700,
                        fontSize: 19,
                        letterSpacing: -0.5,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                  ],
                ),
              ),

              // Main Scrollable Body
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 6, 16, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. HERO STATUS CARD (Figma "HERO STATUS CARD")
                      _buildHeroStatusCard(),
                      const SizedBox(height: 18),

                      // 2. CREATE AN AI QUIZ (Figma "Create an AI Quiz" Card)
                      _buildCreateAiQuizCard(),
                      const SizedBox(height: 22),

                      // 3. AVAILABLE QUIZZES (Figma "Available Quizzes" Section with Cards)
                      _buildAvailableQuizzesSection(),
                      const SizedBox(height: 22),

                      // 4. QUIZ HISTORY (Figma "Quiz History" Section)
                      _buildQuizHistorySection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 1. Hero Status Card: Test Your Knowledge
  Widget _buildHeroStatusCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFF2EAEE5), Color(0xFF12639F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 89, 187, 0.25),
            blurRadius: 24,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Ambient Glow Decorator
            Positioned(
              right: -24,
              bottom: -32,
              child: Container(
                width: 176,
                height: 176,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.12),
                ),
              ),
            ),

            // Top-right watermark icon
            Positioned(
              right: 14,
              top: 14,
              child: Opacity(
                opacity: 0.15,
                child: Icon(
                  PhosphorIconsFill.brain,
                  size: 64,
                  color: Colors.white,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Pills: Self-Paced Arena & XP Multiplier Active (using Flexibles to prevent overflow)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Self-Paced Arena Pill
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.22),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                PhosphorIconsFill.sparkle,
                                size: 11,
                                color: Color(0xFFFCD34D),
                              ),
                              SizedBox(width: 4),
                              Flexible(
                                child: Text(
                                  'Self-Paced Arena',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: AppTextStyle.fontFamily,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),

                      // XP Multiplier Active Pill
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(9999),
                          ),
                          child: const Text(
                            'XP MULTIPLIER ACTIVE',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontWeight: FontWeight.w700,
                              fontSize: 9.5,
                              letterSpacing: 0.3,
                              color: Color(0xFFD8E2FF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Heading: Test Your Knowledge
                  const Text(
                    'Test Your Knowledge',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      letterSpacing: -0.5,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Challenge yourself with curated quizzes or generate an instant AI session on any topic.',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 11.5,
                      height: 1.45,
                      color: Colors.white.withValues(alpha: 0.9),
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Divider
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.16),
                  ),
                  const SizedBox(height: 10),

                  // Free Allowance Pill & Upgrade Link stacked vertically as in Figma
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pill: ⚡ 3 of 5 Free AI Quizzes Left
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4.5),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.18),
                          borderRadius: BorderRadius.circular(9999),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              PhosphorIconsFill.lightning,
                              size: 12,
                              color: Color(0xFFFCD34D),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '3 of 5 Free AI Quizzes Left',
                              style: TextStyle(
                                fontFamily: AppTextStyle.fontFamily,
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Upgrade for Unlimited →
                      GestureDetector(
                        onTap: controller.onUpgradeAllowance,
                        child: const Text(
                          'Upgrade for Unlimited →',
                          style: TextStyle(
                            fontFamily: AppTextStyle.fontFamily,
                            fontWeight: FontWeight.w600,
                            fontSize: 11,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 2. Create an AI Quiz Card
  Widget _buildCreateAiQuizCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 31, 63, 0.04),
            blurRadius: 14,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Info + 3D Hologram Thumbnail
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge: Powered by Nova AI
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F6FF),
                        borderRadius: BorderRadius.circular(9999),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            PhosphorIconsFill.sparkle,
                            size: 10,
                            color: Color(0xFF004493),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Powered by Nova AI',
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.5,
                              color: Color(0xFF004493),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Heading: Create an AI Quiz
                    const Text(
                      'Create an AI Quiz',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                    const SizedBox(height: 3),

                    // Subtitle
                    const Text(
                      'Choose any topic and let AI synthesize an adaptive, multi-concept quiz in seconds.',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 11.5,
                        height: 1.4,
                        color: Color(0xFF414754),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),

              // 3D Hologram Generator Pedestal Thumbnail
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE2E8F0), Color(0xFFCBD5E1)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  border: Border.all(color: const Color(0xFFC1C6D7).withValues(alpha: 0.3)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Pedestal plate
                    Positioned(
                      bottom: 7,
                      child: Container(
                        width: 50,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF38BDF8).withValues(alpha: 0.35),
                              blurRadius: 5,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Glowing holographic cube
                    const Positioned(
                      top: 12,
                      child: Icon(
                        PhosphorIconsFill.cube,
                        size: 32,
                        color: Color(0xFF0284C7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Label: QUICK SUBJECT
          const Text(
            'QUICK SUBJECT',
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 10.5,
              letterSpacing: 0.5,
              color: Color(0xFF414754),
            ),
          ),
          const SizedBox(height: 8),

          // Quick Subject Chips: Biology, Mathematics, Physics, History, English, + Custom
          Obx(
            () => Wrap(
              spacing: 6,
              runSpacing: 6,
              children: controller.quickSubjects.map(
                (subject) {
                  final isSelected = controller.selectedQuickSubject.value == subject;
                  return GestureDetector(
                    onTap: () => controller.onSelectQuickSubject(subject),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF127FD2) : const Color(0xFFEDEEEF),
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: isSelected
                            ? const [
                                BoxShadow(
                                  color: Color.fromRGBO(18, 127, 210, 0.2),
                                  blurRadius: 3,
                                  offset: Offset(0, 1),
                                ),
                              ]
                            : null,
                      ),
                      child: Text(
                        subject,
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          fontSize: 11,
                          color: isSelected ? Colors.white : const Color(0xFF191C1D),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
          const SizedBox(height: 12),

          // Search / Topic Input Field
          Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFC1C6D7).withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.quizTopicController,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF191C1D),
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Enter topic or chapter...',
                      hintStyle: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 11.5,
                        color: Color(0xFF94A3B8),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Primary Action CTA Button: ⚡ CREATE AI QUIZ →
          GestureDetector(
            onTap: controller.onGenerateQuiz,
            child: Container(
              width: double.infinity,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1465A1), Color(0xFF4FB0DC), Color(0xFF12639F)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1465A1).withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIconsFill.lightning,
                    size: 14,
                    color: Colors.white,
                  ),
                  SizedBox(width: 6),
                  Text(
                    'CREATE AI QUIZ →',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 11.5,
                      letterSpacing: 0.5,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Credit Note
          const Center(
            child: Text(
              'Independent topic generator • No curriculum or teacher required',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontWeight: FontWeight.w400,
                fontSize: 10.5,
                color: Color(0xFF414754),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 3. Available Quizzes Section
  Widget _buildAvailableQuizzesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title: Available Quizzes + PLATFORM CURATED Badge
        Row(
          children: [
            const Text(
              'Available Quizzes',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: Color(0xFF191C1D),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFFE0F6FF),
                borderRadius: BorderRadius.circular(9999),
              ),
              child: const Text(
                'PLATFORM CURATED',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 9.5,
                  letterSpacing: 0.3,
                  color: Color(0xFF004493),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),

        // Category Filter Pills: All, Biology, Mathematics, Physics, General Science
        Obx(
          () => SizedBox(
            height: 28,
            child: ListView(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              children: controller.quizCategories.map(
                (category) {
                  final isSelected = controller.selectedQuizCategory.value == category;
                  return Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: GestureDetector(
                      onTap: () => controller.onSelectQuizCategory(category),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF191C1D) : const Color(0xFFE7E8E9),
                          borderRadius: BorderRadius.circular(9999),
                          boxShadow: isSelected
                              ? const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.08),
                                    blurRadius: 2,
                                    offset: Offset(0, 1),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            category,
                            style: TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                              fontSize: 11.5,
                              color: isSelected ? Colors.white : const Color(0xFF191C1D),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Quiz Card 1: Cell Structure & Organelles
        _buildQuizCard(
          subject: 'Biology • Life Sciences',
          title: 'Cell Structure & Organelles',
          description:
              'Test your understanding of nucleus, mitochondria, ATP synthesis, and membrane transport mechanics.',
          duration: '15 Mins',
          questionsCount: '10 Qs',
          xpText: '+50 XP',
          onStart: () => controller.onStartFeaturedQuiz('Cell Structure & Organelles'),
        ),
        const SizedBox(height: 10),

        // Quiz Card 2: Algebraic Equations & Quadratics
        _buildQuizCard(
          subject: 'Mathematics • Algebra',
          title: 'Algebraic Equations & Quadratics',
          description:
              'Solve quadratic formulas, factoring polynomials, vertex finding, and parabolic graph relationships.',
          duration: '20 Mins',
          questionsCount: '10 Qs',
          xpText: '+60 XP',
          onStart: () => controller.onStartFeaturedQuiz('Algebraic Equations & Quadratics'),
        ),
        const SizedBox(height: 10),

        // Quiz Card 3: Photosynthesis & Solar Energy
        _buildQuizCard(
          subject: 'Biology • Botany',
          title: 'Photosynthesis & Solar Energy',
          description:
              'Light-dependent reactions, Calvin cycle transitions, and chloroplast biochemistry essentials.',
          duration: '12 Mins',
          questionsCount: '8 Qs',
          xpText: '+40 XP',
          onStart: () => controller.onStartFeaturedQuiz('Photosynthesis & Solar Energy'),
        ),
      ],
    );
  }

  Widget _buildQuizCard({
    required String subject,
    required String title,
    required String description,
    required String duration,
    required String questionsCount,
    required String xpText,
    required VoidCallback onStart,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFC1C6D7).withValues(alpha: 0.3)),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 31, 63, 0.04),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Subject + Title & XP Badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subject,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.5,
                        color: Color(0xFF127FD2),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 13.5,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // XP Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F6FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      PhosphorIconsFill.target,
                      size: 11,
                      color: Color(0xFF127FD2),
                    ),
                    const SizedBox(width: 3),
                    Text(
                      xpText,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: Color(0xFF127FD2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),

          // Description
          Text(
            description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontWeight: FontWeight.w400,
              fontSize: 11.5,
              height: 1.4,
              color: Color(0xFF414754),
            ),
          ),
          const SizedBox(height: 10),

          // Meta row: Questions + Duration + Start Quiz → Button (using Expanded & Flexible to protect against overflow)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Questions & Duration
              Expanded(
                child: Row(
                  children: [
                    const Icon(
                      PhosphorIconsRegular.fileText,
                      size: 12,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 3),
                    Flexible(
                      child: Text(
                        questionsCount,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontWeight: FontWeight.w400,
                          fontSize: 10.5,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      PhosphorIconsRegular.clock,
                      size: 12,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 3),
                    Flexible(
                      child: Text(
                        duration,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontWeight: FontWeight.w400,
                          fontSize: 10.5,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),

              // Start Quiz → Button
              GestureDetector(
                onTap: onStart,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    'Start Quiz →',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontWeight: FontWeight.w700,
                      fontSize: 11,
                      color: Color(0xFF127FD2),
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

  // 4. Quiz History Section
  Widget _buildQuizHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & See All link
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Quiz History',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: Color(0xFF191C1D),
              ),
            ),
            GestureDetector(
              onTap: controller.onViewFullQuizHistory,
              child: const Text(
                'See All',
                style: TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 11.5,
                  color: Color(0xFF127FD2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        const Text(
          'Review completed assessments and score trajectory.',
          style: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontWeight: FontWeight.w400,
            fontSize: 10.5,
            color: Color(0xFF414754),
          ),
        ),
        const SizedBox(height: 10),

        // White Container with history rows & Full History button
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFC1C6D7).withValues(alpha: 0.3)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(0, 31, 63, 0.04),
                blurRadius: 10,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Row 1: Human Body Systems (Today • Score: 9/10 (90%))
              _buildHistoryRow(
                icon: PhosphorIconsFill.microscope,
                iconColor: const Color(0xFF0284C7),
                iconBg: const Color(0xFFE0F6FF),
                title: 'Human Body Systems',
                timeText: 'Today',
                scoreText: '9/10 (90%)',
                badgeText: 'Passed',
                badgeColor: const Color(0xFF16A34A),
                badgeBg: const Color(0xFFF0FDF4),
                badgeBorder: const Color(0xFF86EFAC),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(height: 1, color: Color(0xFFEDEEEF)),
              ),

              // Row 2: Introduction to Biology (Yesterday • Score: 10/10 (100%))
              _buildHistoryRow(
                icon: PhosphorIconsFill.trophy,
                iconColor: const Color(0xFF0D9488),
                iconBg: const Color(0xFFCCFBF1),
                title: 'Introduction to Biology',
                timeText: 'Yesterday',
                scoreText: '10/10 (100%)',
                badgeText: '✔ Mastered',
                badgeColor: const Color(0xFF0F766E),
                badgeBg: const Color(0xFFF0FDFA),
                badgeBorder: const Color(0xFF99F6E4),
              ),
              const SizedBox(height: 12),

              // Bottom button: View Full History (12 Quizzes)
              GestureDetector(
                onTap: controller.onViewFullQuizHistory,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F4F5),
                    borderRadius: BorderRadius.circular(47),
                    border: Border.all(color: const Color(0xFFC1C6D7).withValues(alpha: 0.3)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        PhosphorIconsBold.folderSimple,
                        size: 14,
                        color: Color(0xFF414754),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'View Full History (12 Quizzes)',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.5,
                          color: Color(0xFF191C1D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryRow({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String timeText,
    required String scoreText,
    required String badgeText,
    required Color badgeColor,
    required Color badgeBg,
    required Color badgeBorder,
  }) {
    return Row(
      children: [
        // Left Icon in Circle
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: iconBg,
          ),
          child: Center(
            child: Icon(
              icon,
              size: 17,
              color: iconColor,
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Title & Score
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 2),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 10.5,
                    color: Color(0xFF64748B),
                  ),
                  children: [
                    TextSpan(text: '$timeText  •  '),
                    const TextSpan(text: 'Score: '),
                    TextSpan(
                      text: scoreText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 6),

        // Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: badgeBg,
            border: Border.all(color: badgeBorder),
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            badgeText,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontWeight: FontWeight.w700,
              fontSize: 10.5,
              color: badgeColor,
            ),
          ),
        ),
      ],
    );
  }
}
