import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../core/themes/app_color.dart';
import '../../../core/themes/app_textstyle.dart';
import '../../../core/utils/app_assets.dart';
import 'registration_controller.dart';

class RegistrationView extends GetView<RegistrationController> {
  const RegistrationView({super.key});

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
                      const SizedBox(height: 24),

                      // Screen Header Title
                      const Text(
                        'Set Up Your Institution',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF131313),
                          height: 25 / 20,
                        ),
                      ),

                      const SizedBox(height: 6),

                      // Subtitle
                      const Text(
                        'Tell us about your institution to get started.',
                        style: TextStyle(
                          fontFamily: AppTextStyle.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF131313),
                          height: 16 / 13,
                        ),
                      ),

                      const SizedBox(height: 28),

                      // Section 1: Institution Details
                      _buildSectionTitle('Institution Details'),
                      const SizedBox(height: 14),

                      _buildTextField(
                        controller: controller.institutionNameController,
                        hintText: 'Institution Name',
                      ),
                      const SizedBox(height: 14),

                      Obx(() => _buildDropdownField(
                            hintText: 'Select Institution Type',
                            value: controller.selectedInstitutionType.value,
                            items: controller.institutionTypes,
                            onChanged: controller.setInstitutionType,
                          )),
                      const SizedBox(height: 14),

                      _buildTextField(
                        controller: controller.registrationNumberController,
                        hintText: 'Enter Registration Number',
                      ),

                      const SizedBox(height: 28),

                      // Section 2: Add Your Institute Logo
                      _buildSectionTitle('Add Your Institute Logo'),
                      const SizedBox(height: 14),

                      _buildLogoUploadBox(),

                      const SizedBox(height: 28),

                      // Section 3: Contact Details
                      _buildSectionTitle('Contact Details'),
                      const SizedBox(height: 14),

                      _buildPhoneInputRow(context),
                      const SizedBox(height: 14),

                      _buildTextField(
                        controller: controller.officialEmailController,
                        hintText: 'Enter Official Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 14),

                      Obx(() => _buildTextField(
                            controller: controller.passwordController,
                            hintText: 'Enter Password',
                            isPassword: true,
                            isPasswordVisible:
                                controller.isPasswordVisible.value,
                            onToggleVisibility:
                                controller.togglePasswordVisibility,
                          )),
                      const SizedBox(height: 14),

                      Obx(() => _buildTextField(
                            controller: controller.rePasswordController,
                            hintText: 'Re-Enter Password',
                            isPassword: true,
                            isPasswordVisible:
                                controller.isRePasswordVisible.value,
                            onToggleVisibility:
                                controller.toggleRePasswordVisibility,
                          )),

                      const SizedBox(height: 28),

                      // Section 4: Institution Address
                      _buildSectionTitle('Institution Address'),
                      const SizedBox(height: 14),

                      _buildTextField(
                        controller: controller.completeAddressController,
                        hintText: 'Enter Complete Address',
                      ),
                      const SizedBox(height: 14),

                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField(
                              controller: controller.cityController,
                              hintText: 'Enter City',
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Obx(() => _buildDropdownField(
                                  hintText: 'State',
                                  value: controller.selectedState.value,
                                  items: controller.statesList,
                                  onChanged: controller.setStateValue,
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),

                      _buildTextField(
                        controller: controller.pincodeController,
                        hintText: 'Enter Pincode',
                        keyboardType: TextInputType.number,
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),

              // Bottom Create Institution Button
              Padding(
                padding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 24.0),
                child: _buildCreateInstitutionButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: AppTextStyle.fontFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF0E3856),
        height: 23 / 18,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onToggleVisibility,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColor.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFE3E3E3),
          width: 1,
        ),
      ),
      child: Center(
        child: TextField(
          controller: controller,
          obscureText: isPassword && !isPasswordVisible,
          keyboardType: keyboardType,
          style: const TextStyle(
            fontFamily: AppTextStyle.fontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF131313),
          ),
          cursorColor: const Color(0xFF0E5E9B),
          decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Color(0x38131313),
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFF8E8E93),
                      size: 20,
                    ),
                    onPressed: onToggleVisibility,
                  )
                : null,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String hintText,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 54,
      decoration: BoxDecoration(
        color: AppColor.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: const Color(0xFFE3E3E3),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: Colors.black,
            size: 24,
          ),
          hint: Text(
            hintText,
            style: TextStyle(
              fontFamily: AppTextStyle.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: value == null
                  ? const Color(0xFF131313)
                  : const Color(0xFF131313),
            ),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: const TextStyle(
                  fontFamily: AppTextStyle.fontFamily,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF131313),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildLogoUploadBox() {
    return GestureDetector(
      onTap: controller.pickLogo,
      child: CustomPaint(
        painter: DashedRectPainter(
          color: const Color(0xFFC9C9C9),
          strokeWidth: 1.0,
          dashWidth: 6.0,
          dashSpace: 4.0,
          borderRadius: 6.0,
        ),
        child: Container(
          width: double.infinity,
          height: 134,
          decoration: BoxDecoration(
            color: AppColor.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: CustomPaint(
              painter: DashedCirclePainter(
                color: const Color(0xFFC9C9C9),
                strokeWidth: 1.0,
                dashWidth: 4.0,
                dashSpace: 3.0,
              ),
              child: Container(
                width: 62,
                height: 62,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppAssets.iconImageAdd,
                    width: 31,
                    height: 32,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneInputRow(BuildContext context) {
    return Row(
      children: [
        // Country Code Dropdown Container
        GestureDetector(
          onTap: () => _showCountryCodePicker(context),
          child: Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: AppColor.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: const Color(0xFFE3E3E3),
                width: 1,
              ),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      controller.selectedCountryCode.value,
                      style: const TextStyle(
                        fontFamily: AppTextStyle.fontFamily,
                        fontSize: 15,
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

        const SizedBox(width: 10),

        // Contact Number Field
        Expanded(
          child: _buildTextField(
            controller: controller.contactNumberController,
            hintText: 'Contact Number',
            keyboardType: TextInputType.phone,
          ),
        ),
      ],
    );
  }

  void _showCountryCodePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return SafeArea(
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
        );
      },
    );
  }

  Widget _buildCreateInstitutionButton() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: AppColor.primaryButtonGradient,
        borderRadius: BorderRadius.circular(52),
        boxShadow: const [
          BoxShadow(
            color: Color(0x26000000),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: controller.createInstitution,
          borderRadius: BorderRadius.circular(52),
          splashColor: Colors.white24,
          highlightColor: Colors.white10,
          child: const Center(
            child: Text(
              'Create Institution',
              style: TextStyle(
                fontFamily: AppTextStyle.fontFamily,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Custom Painter for Rectangular Dashed Border
class DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;

  DashedRectPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius = 6.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rrect);
    final dashedPath = _createDashedPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final length = math.min(dashWidth, metric.length - distance);
        dest.addPath(
          metric.extractPath(distance, distance + length),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant DashedRectPainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      dashWidth != oldDelegate.dashWidth ||
      dashSpace != oldDelegate.dashSpace ||
      borderRadius != oldDelegate.borderRadius;
}

// Custom Painter for Circular Dashed Border
class DashedCirclePainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;

  DashedCirclePainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashWidth = 4.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final radius = size.width / 2;
    final path = Path()
      ..addArc(
        Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: radius,
        ),
        0,
        2 * math.pi,
      );

    final dashedPath = _createDashedPath(path, dashWidth, dashSpace);
    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source, double dashWidth, double dashSpace) {
    final dest = Path();
    for (final metric in source.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final length = math.min(dashWidth, metric.length - distance);
        dest.addPath(
          metric.extractPath(distance, distance + length),
          Offset.zero,
        );
        distance += dashWidth + dashSpace;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant DashedCirclePainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      dashWidth != oldDelegate.dashWidth ||
      dashSpace != oldDelegate.dashSpace;
}
