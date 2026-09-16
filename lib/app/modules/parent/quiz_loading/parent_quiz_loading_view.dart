import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'parent_quiz_loading_controller.dart';

class ParentQuizLoadingView extends StatefulWidget {
  const ParentQuizLoadingView({super.key});

  @override
  State<ParentQuizLoadingView> createState() => _ParentQuizLoadingViewState();
}

class _ParentQuizLoadingViewState extends State<ParentQuizLoadingView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final ParentQuizLoadingController controller;

  static const String fontFamily = 'Google Sans Flex';

  @override
  void initState() {
    super.initState();
    if (!Get.isRegistered<ParentQuizLoadingController>()) {
      Get.put(ParentQuizLoadingController());
    }
    controller = Get.find<ParentQuizLoadingController>();

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

                // 2. Heading: Synthesizing Quiz
                const Text(
                  'Synthesizing Quiz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
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
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF414754),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 48),

                // 4. Progress Bar
                _buildProgressBar(),
                const SizedBox(height: 16),

                // 5. Module Generation Tag
                const Text(
                  'ADAPTIVE QUIZ GENERATION',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: fontFamily,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                    color: Color(0xFF717786),
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
              // Outer Pulsing Ring
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

              // Overlay Inner Ring
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 89, 187, 0.20),
                  shape: BoxShape.circle,
                ),
              ),

              // Core Icon Card
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

              // Orbiting Particle
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
