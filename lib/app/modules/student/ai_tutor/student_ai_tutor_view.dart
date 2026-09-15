import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import '../../../routes/app_pages.dart';
import 'student_ai_tutor_controller.dart';

class StudentAiTutorView extends GetView<StudentAiTutorController> {
  const StudentAiTutorView({super.key});

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
        backgroundColor: const Color(0xFFFFFFFF),
        body: SafeArea(
          bottom: true,
          child: Column(
            children: [
              // 1. Top App Bar (Group 2079 + Title)
              _buildTopAppBar(context),

              const Divider(height: 1, color: Color(0xFFF1F2F4)),

              // 2. Chat Messages Viewport
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    controller: controller.scrollController,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    itemCount: controller.messages.length +
                        (controller.isTyping.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.messages.length &&
                          controller.isTyping.value) {
                        return _buildTypingIndicator();
                      }
                      final msg = controller.messages[index];
                      if (msg.isUser) {
                        return _buildUserMessage(msg);
                      }
                      return _buildAiMessage(msg);
                    },
                  ),
                ),
              ),

              // 3. Quick Suggestion Prompts Row (Horizontal Scroll)
              _buildQuickPromptsRow(),

              const SizedBox(height: 10),

              // 4. Bottom Input Bar (Microphone + Pill Textfield + Send Button)
              _buildBottomInputBar(context),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // TOP APP BAR
  // ==========================================
  Widget _buildTopAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          // Circular Back Button (Group 2079 / Ellipse 18: 44x44)
          GestureDetector(
            onTap: controller.onBackTap,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFF3F4F5),
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
          const SizedBox(width: 14),

          // Title & Status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.topicTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF191C1D),
                    letterSpacing: -0.2,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 7,
                      height: 7,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF22C55E),
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'AI Tutor Active',
                      style: TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF127FD2),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // AI Tutor Robot Icon Header Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE0F6FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIcons.sparkle(PhosphorIconsStyle.fill),
                  size: 14,
                  color: const Color(0xFF0059BB),
                ),
                const SizedBox(width: 4),
                const Text(
                  'Zama AI',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0059BB),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // MESSAGE: User Bubble (Exact Figma #0B3460)
  // ==========================================
  Widget _buildUserMessage(AiTutorMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(width: 48), // Indent from left
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF0B3460),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(2),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.1),
                    blurRadius: 6,
                    offset: Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.06),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                msg.text,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.45,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // MESSAGE: AI Tutor Response (Exact Figma #F9F9F9)
  // ==========================================
  Widget _buildAiMessage(AiTutorMessage msg) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Tutor Avatar (32x32 with border)
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0x33C1C6D7),
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.05),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                AppAssets.studentAiTutorAvatar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF0059BB),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.auto_awesome,
                      color: Colors.white,
                      size: 16,
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Message Bubble
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F4F4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                boxShadow: [
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
                  // Primary greeting/metaphor text
                  Text(
                    msg.text,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF191C1D),
                      height: 1.5,
                    ),
                  ),

                  // Secondary header text
                  if (msg.secondaryText != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      msg.secondaryText!,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF191C1D),
                        height: 1.5,
                      ),
                    ),
                  ],

                  // Ingredients List with colored keys
                  if (msg.ingredients != null && msg.ingredients!.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: msg.ingredients!.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '• ',
                                  style: TextStyle(
                                    fontFamily: AppTextStyle.fontFamily,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF191C1D),
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: item.title,
                                        style: TextStyle(
                                          fontFamily: AppTextStyle.fontFamily,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: item.color,
                                        ),
                                      ),
                                      const TextSpan(text: ' '),
                                      TextSpan(
                                        text: item.description,
                                        style: const TextStyle(
                                          fontFamily: AppTextStyle.fontFamily,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF414754),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],

                  // Conclusion summary
                  if (msg.conclusionText != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      msg.conclusionText!,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF191C1D),
                        height: 1.5,
                      ),
                    ),
                  ],

                  // Interactive 3D Model Card (Figma Chloroplast card)
                  if (msg.interactiveModelTitle != null) ...[
                    const SizedBox(height: 16),
                    Material(
                      color: const Color(0xFFE7E8E9),
                      borderRadius: BorderRadius.circular(8),
                      child: InkWell(
                        onTap: () {
                          Get.toNamed(Routes.STUDENT_AR_LEARNING);
                        },
                        borderRadius: BorderRadius.circular(8),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFD8E2FF),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.play_circle_fill_rounded,
                                  size: 24,
                                  color: Color(0xFF001A41),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      msg.interactiveModelTitle!,
                                      style: const TextStyle(
                                        fontFamily: AppTextStyle.fontFamily,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF191C1D),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      msg.interactiveModelSubtitle ?? 'Tap to interact',
                                      style: const TextStyle(
                                        fontFamily: AppTextStyle.fontFamily,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF414754),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                PhosphorIcons.arrowRight(PhosphorIconsStyle.bold),
                                size: 16,
                                color: const Color(0xFF414754),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],

                  // Optional Embedded Diagram
                  if (msg.diagramAsset != null) ...[
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        msg.diagramAsset!,
                        fit: BoxFit.cover,
                        height: 160,
                        width: double.infinity,
                      ),
                    ),
                  ],

                  // KEY FUNCTIONS Header
                  if (msg.keyFunctionsHeader != null) ...[
                    const SizedBox(height: 14),
                    Text(
                      msg.keyFunctionsHeader!,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF414754),
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],

                  // KEY FUNCTIONS Bullet List
                  if (msg.keyFunctions != null) ...[
                    for (int i = 0; i < msg.keyFunctions!.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: _buildFunctionIcon(i),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                msg.keyFunctions![i],
                                style: const TextStyle(
                                  fontFamily: AppTextStyle.fontFamily,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF191C1D),
                                  height: 1.35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFunctionIcon(int index) {
    IconData icon;
    switch (index % 3) {
      case 0:
        icon = PhosphorIcons.lightning(PhosphorIconsStyle.fill);
        break;
      case 1:
        icon = PhosphorIcons.gearSix(PhosphorIconsStyle.fill);
        break;
      default:
        icon = PhosphorIcons.arrowsClockwise(PhosphorIconsStyle.bold);
        break;
    }
    return Icon(icon, size: 15, color: const Color(0xFF0059BB));
  }

  // ==========================================
  // TYPING INDICATOR
  // ==========================================
  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFE0F6FF),
            ),
            child: const Icon(
              Icons.auto_awesome,
              color: Color(0xFF0059BB),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F9F9),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF0059BB)),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'AI Tutor is typing...',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF717786),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // QUICK SUGGESTION PROMPTS
  // ==========================================
  Widget _buildQuickPromptsRow() {
    return SizedBox(
      height: 36,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: controller.quickPrompts.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final prompt = controller.quickPrompts[index];
          return GestureDetector(
            onTap: () => controller.onQuickPromptTap(prompt),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF4F4F4),
                borderRadius: BorderRadius.circular(9999),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                prompt,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF414754),
                  letterSpacing: 0.14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ==========================================
  // BOTTOM INPUT BAR
  // ==========================================
  Widget _buildBottomInputBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        children: [
          // Voice Microphone Button (44x44 circle)
          GestureDetector(
            onTap: controller.toggleVoiceListening,
            child: Obx(
              () => Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: controller.isVoiceListening.value
                      ? const Color(0xFF0059BB)
                      : const Color(0xFFF9F9F9),
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
                  PhosphorIcons.microphone(PhosphorIconsStyle.bold),
                  size: 20,
                  color: controller.isVoiceListening.value
                      ? Colors.white
                      : const Color(0xFF191C1D),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),

          // Pill Input Field (Rectangle 33 / Group 2093)
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(23),
                border: Border.all(
                  color: const Color(0xFFE0F6FF),
                  width: 1.2,
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
                  Expanded(
                    child: TextField(
                      controller: controller.textController,
                      onSubmitted: (_) => controller.onSendPressed(),
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 14,
                        color: Color(0xFF191C1D),
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Ask a question...',
                        hintStyle: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0x66000000),
                        ),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Send Button (30x30 circle #127FD2)
                  GestureDetector(
                    onTap: controller.onSendPressed,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF127FD2),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.08),
                            blurRadius: 2,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.arrow_upward_rounded,
                        size: 18,
                        color: Colors.white,
                      ),
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
}
