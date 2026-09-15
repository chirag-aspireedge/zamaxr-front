import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'add_child_controller.dart';

class AddChildView extends GetView<AddChildController> {
  const AddChildView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Custom Circular Back Button
              _buildBackButton(),
              const SizedBox(height: 24),
              // Page Header
              const Text(
                'Add Child',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Add your child’s details to get started.',
                style: TextStyle(
                  fontFamily: 'Google Sans Flex',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF414754),
                ),
              ),
              const SizedBox(height: 28),

              // Field 1: Child's Full Name
              _buildFieldLabel("Child's Full Name"),
              const SizedBox(height: 8),
              _buildTextInput(
                controller: controller.fullNameController,
                hintText: "Enter child's full name",
                keyboardType: TextInputType.name,
              ),

              const SizedBox(height: 22),

              // Field 2: Age
              _buildFieldLabel('Age'),
              const SizedBox(height: 8),
              _buildTextInput(
                controller: controller.ageController,
                hintText: 'Enter age',
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 22),

              // Field 3: Class / Grade Selector
              _buildFieldLabel('Class / Grade'),
              const SizedBox(height: 8),
              _buildClassDropdownSelector(context),

              const SizedBox(height: 60),

              // Continue Button
              _buildContinueButton(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF1567A2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1567A2), size: 20),
        onPressed: () => Get.back(),
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: 'Google Sans Flex',
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF191C1D),
      ),
    );
  }

  Widget _buildTextInput({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE1E3E4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontFamily: 'Google Sans Flex',
          fontSize: 14,
          color: Color(0xFF191C1D),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'Google Sans Flex',
            fontSize: 14,
            color: Color(0xFF717786),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildClassDropdownSelector(BuildContext context) {
    return Obx(() {
      final selected = controller.selectedClass.value;
      return Container(
        height: 48,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE1E3E4)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => _showClassPicker(context),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selected ?? 'Select class',
                    style: TextStyle(
                      fontFamily: 'Google Sans Flex',
                      fontSize: 14,
                      color: selected != null ? const Color(0xFF191C1D) : const Color(0xFF717786),
                      fontWeight: selected != null ? FontWeight.w500 : FontWeight.w400,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Color(0xFF414754),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void _showClassPicker(BuildContext context) {
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.55,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select Class / Grade',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF191C1D),
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.classOptions.length,
                itemBuilder: (context, index) {
                  final className = controller.classOptions[index];
                  final isSelected = controller.selectedClass.value == className;
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                    title: Text(
                      className,
                      style: TextStyle(
                        fontFamily: 'Google Sans Flex',
                        fontSize: 15,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        color: isSelected ? const Color(0xFF0E5E9B) : const Color(0xFF191C1D),
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(Icons.check_circle_rounded, color: Color(0xFF0E5E9B))
                        : null,
                    onTap: () {
                      controller.selectClass(className);
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildContinueButton() {
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
          onTap: controller.submitChild,
          borderRadius: BorderRadius.circular(74),
          child: const Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Continue',
                  style: TextStyle(
                    fontFamily: 'Google Sans Flex',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
