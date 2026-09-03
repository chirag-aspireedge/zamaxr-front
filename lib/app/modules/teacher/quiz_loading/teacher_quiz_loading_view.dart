import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'teacher_quiz_loading_controller.dart';

class TeacherQuizLoadingView extends StatefulWidget {
  const TeacherQuizLoadingView({super.key});

  @override
  State<TeacherQuizLoadingView> createState() => _TeacherQuizLoadingViewState();
}

class _TeacherQuizLoadingViewState extends State<TeacherQuizLoadingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  final TeacherQuizLoadingController controller = Get.find<TeacherQuizLoadingController>();

  static const String fontFamily = 'Google Sans Flex';

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: 276.92,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 1. AI Pulsing Rings and Core Icon with Orbiting Particle
                _buildAiPulsingAnimation(),
                const SizedBox(height: 32),

                // 2. Heading: Synthesizing Lesson
                const Text(
                  'Synthesizing Lesson',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.6,
                    color: Color(0xFF191C1D),
                    height: 32 / 24,
                  ),
                ),
                const SizedBox(height: 8),

                // 3. Rotating Status Message
                SizedBox(
                  height: 24,
                  child: Obx(() {
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        controller.statusMessage.value,
                        key: ValueKey(controller.statusMessage.value),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: fontFamily,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF414754),
                          height: 24 / 16,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 48),

                // 4. Progress Bar
                _buildProgressBar(),
                const SizedBox(height: 16),

                // 5. XR Module Generation Tag
                const Text(
                  'XR MODULE GENERATION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.6,
                    color: Color(0xFF717786),
                    height: 16 / 12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAiPulsingAnimation() {
    return AnimatedBuilder(
      animation: _animController,
      builder: (context, child) {
        final angle = _animController.value * 2 * math.pi;
        final pulseScale = 1.0 + 0.05 * math.sin(angle);

        return SizedBox(
          width: 128,
          height: 128,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer Pulsing Ring (128x128)
              Transform.scale(
                scale: pulseScale,
                child: Container(
                  width: 128,
                  height: 128,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(0, 89, 187, 0.10),
                    shape: BoxShape.circle,
                  ),
                ),
              ),

              // Overlay Inner Ring (96x96)
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 89, 187, 0.20),
                  shape: BoxShape.circle,
                ),
              ),

              // Core Icon Card (64x64)
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF001C3A).withValues(alpha: 0.10),
                      offset: const Offset(0, 4),
                      blurRadius: 20,
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.auto_awesome,
                    size: 28,
                    color: Color(0xFF0059BB),
                  ),
                ),
              ),

              // Orbiting Particle (12x12)
              Positioned(
                left: 64 + 48 * math.cos(angle) - 6,
                top: 64 + 48 * math.sin(angle) - 6,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0E3856),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF476083).withValues(alpha: 0.50),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProgressBar() {
    return Container(
      width: 228.92,
      height: 6,
      decoration: BoxDecoration(
        color: const Color(0xFFE7E8E9),
        borderRadius: BorderRadius.circular(9999),
      ),
      alignment: Alignment.centerLeft,
      child: Obx(() {
        return FractionallySizedBox(
          widthFactor: controller.progress.value,
          child: Container(
            height: 6,
            decoration: BoxDecoration(
              color: const Color(0xFF127FD2),
              borderRadius: BorderRadius.circular(9999),
            ),
          ),
        );
      }),
    );
  }
}

typedef QuizLoadingView = TeacherQuizLoadingView;
