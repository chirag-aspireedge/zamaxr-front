import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'teacher_registration_controller.dart';

class TeacherRegistrationView extends GetView<TeacherRegistrationController> {
  const TeacherRegistrationView({super.key});

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
        backgroundColor: AppColor.white,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Screen Title (Set Up Your Profile)
                      const Text(
                        'Set Up Your Profile',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF131313),
                          height: 25 / 20,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Subtitle (Tell us about yourself.)
                      const Text(
                        'Tell us about yourself.',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF131313),
                          height: 16 / 13,
                        ),
                      ),

                      const SizedBox(height: 32),

                      // Center Avatar Upload Picker
                      Center(
                        child: _buildAvatarPicker(),
                      ),

                      const SizedBox(height: 32),

                      // Section 1: Personal Details
                      _buildSectionHeader('Personal Details'),
                      const SizedBox(height: 15),

                      _buildInputField(
                        controller: controller.fullNameController,
                        hintText: 'Full name',
                      ),
                      const SizedBox(height: 15),

                      _buildInputField(
                        controller: controller.teacherIdController,
                        hintText: 'Teacher ID/ Employee ID',
                      ),

                      const SizedBox(height: 32),

                      // Section 2: Contact Details
                      _buildSectionHeader('Contact Details'),
                      const SizedBox(height: 15),

                      _buildPhoneInputRow(context),
                      const SizedBox(height: 15),

                      _buildInputField(
                        controller: controller.emailController,
                        hintText: 'Enter Official Email',
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 32),

                      // Section 3: Institution
                      _buildSectionHeader('Institution'),
                      const SizedBox(height: 15),

                      _buildInstitutionSelector(context),

                      const SizedBox(height: 48),

                      // Continue Button (Pill shaped with Figma gradient)
                      _buildContinueButton(),

                      const SizedBox(height: 32),
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

  // --- Widgets ---

  Widget _buildSectionHeader(String title) {
    // Optical standard: Section Headers at 15px - 17px (FontWeight.w600)
    return Text(
      title,
      style: const TextStyle(
        fontFamily: AppTextStyle.fontFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF0E3856),
        height: 21 / 16,
      ),
    );
  }

  Widget _buildAvatarPicker() {
    return GestureDetector(
      onTap: controller.pickAvatar,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 106,
        height: 100,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Center Dashed Circle Avatar Frame (84x84)
            Positioned(
              left: 4,
              top: 4,
              child: CustomPaint(
                painter: DashedCirclePainter(
                  color: const Color(0xFF8C8C8C),
                  strokeWidth: 1.6,
                  dashWidth: 7.5,
                  dashSpace: 8.5,
                ),
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.white,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AppAssets.iconProfileAvatarPlaceholder,
                      width: 44,
                      height: 44,
                    ),
                  ),
                ),
              ),
            ),

            // Plus Badge (36x36) at bottom-right
            Positioned(
              right: 6,
              bottom: 4,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFF127FD2),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x38000000),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: Center(
                  child: CustomPaint(
                    size: const Size(15, 15),
                    painter: _PlusIconPainter(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    // Optical standard: Primary inputs / field text at 15px (FontWeight.w400)
    return Container(
      height: 54,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFE3E3E3),
          width: 1,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontFamily: AppTextStyle.fontFamily,
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Color(0xFF131313),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF131313).withValues(alpha: 0.16),
            height: 19 / 15,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }

  Widget _buildPhoneInputRow(BuildContext context) {
    return Row(
      children: [
        // Country code button (54x54)
        GestureDetector(
          onTap: () => _showCountryCodePicker(context),
          behavior: HitTestBehavior.opaque,
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFFE3E3E3),
                width: 1,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      controller.selectedCountryCode.value,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 14.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF131313),
                      ),
                    ),
                  ),
                  const SizedBox(width: 1),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 16,
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 8),

        // Phone number input field
        Expanded(
          child: _buildInputField(
            controller: controller.contactNumberController,
            hintText: 'Contact Number',
            keyboardType: TextInputType.phone,
          ),
        ),
      ],
    );
  }

  Widget _buildInstitutionSelector(BuildContext context) {
    return GestureDetector(
      onTap: () => _showInstitutionPicker(context),
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 54,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: const Color(0xFFE3E3E3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Obx(
                () {
                  final institution = controller.selectedInstitution.value;
                  return Text(
                    institution ?? 'Search Your Institution',
                    style: TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: institution != null
                          ? const Color(0xFF131313)
                          : const Color(0xFF131313),
                      height: 19 / 15,
                    ),
                  );
                },
              ),
            ),
            SvgPicture.asset(
              AppAssets.iconChevronDownFigma,
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    // Optical standard: Pill / Action buttons at 16px - 18px (FontWeight.w500 / w600)
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF56B9E3),
            Color(0xFF0E5E9B),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(27),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(27),
          onTap: controller.onContinue,
          child: const Center(
            child: Text(
              'Continue',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                height: 22 / 17,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- Bottom Sheets ---

  void _showCountryCodePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ListView(
              shrinkWrap: true,
              children: controller.countryCodes.map((code) {
                return ListTile(
                  title: Text(
                    code,
                    style: const TextStyle(
                      fontFamily: AppTextStyle.fontFamily,
                      fontSize: 16,
                      color: Color(0xFF131313),
                    ),
                  ),
                  onTap: () {
                    controller.setCountryCode(code);
                    Navigator.pop(ctx);
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  void _showInstitutionPicker(BuildContext context) {
    controller.institutionSearchController.clear();
    controller.filterInstitutions('');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
          ),
          child: Container(
            height: MediaQuery.of(ctx).size.height * 0.65,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Select Institution',
                  style: TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0E3856),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller.institutionSearchController,
                  onChanged: controller.filterInstitutions,
                  style: const TextStyle(
                    fontFamily: AppTextStyle.fontFamily,
                    fontSize: 15,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search institution name...',
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF56B9E3)),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Obx(
                    () => ListView.separated(
                      itemCount: controller.filteredInstitutions.length,
                      separatorBuilder: (context, index) => Divider(
                        color: Colors.grey.shade200,
                        height: 1,
                      ),
                      itemBuilder: (context, index) {
                        final item = controller.filteredInstitutions[index];
                        return ListTile(
                          title: Text(
                            item,
                            style: const TextStyle(
                              fontFamily: AppTextStyle.fontFamily,
                              fontSize: 15,
                              color: Color(0xFF131313),
                            ),
                          ),
                          onTap: () {
                            controller.setInstitution(item);
                            Navigator.pop(ctx);
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// --- Custom Dashed Circle Painter for Profile Avatar ---
class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 1.6,
    this.dashWidth = 7.5,
    this.dashSpace = 8.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final radius = (size.width - strokeWidth) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final circumference = 2 * math.pi * radius;
    final totalDashCount = (circumference / (dashWidth + dashSpace)).floor();
    if (totalDashCount <= 0) return;

    final adjustedDashAngle = (2 * math.pi) / totalDashCount;
    final dashFraction = dashWidth / (dashWidth + dashSpace);

    for (int i = 0; i < totalDashCount; i++) {
      final startAngle = i * adjustedDashAngle;
      final sweepAngle = adjustedDashAngle * dashFraction;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant DashedCirclePainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      dashWidth != oldDelegate.dashWidth ||
      dashSpace != oldDelegate.dashSpace;
}

// --- Custom Plus Icon Painter for Blue Avatar Badge ---
class _PlusIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    final cx = size.width / 2;
    final cy = size.height / 2;

    // Horizontal bar
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), paint);
    // Vertical bar
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
