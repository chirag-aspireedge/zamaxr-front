import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class StudentMathSolverController extends GetxController {
  final TextEditingController equationController =
      TextEditingController(text: '2x + 5 = 15');

  final RxInt selectedTab = 0.obs; // 0: Type Equation, 1: Voice Input, 2: Scan & XR
  final RxBool isSolving = false.obs;
  final RxBool showSolution = true.obs;
  final RxBool showSuggestion = true.obs;
  final RxBool isVoiceListening = false.obs;

  final List<String> mathSymbols = [
    'x²',
    '√x',
    'π',
    '( )',
    '±',
    '÷',
    '∫',
    '=',
  ];

  @override
  void onClose() {
    equationController.dispose();
    super.onClose();
  }

  void selectTab(int index) {
    selectedTab.value = index;
    if (index == 1) {
      _startVoiceInput();
    } else if (index == 2) {
      _startScanXrMode();
    }
  }

  void insertSymbol(String symbol) {
    final text = equationController.text;
    final selection = equationController.selection;
    
    String toInsert = symbol;
    if (symbol == 'x²') toInsert = '²';
    if (symbol == '√x') toInsert = '√';
    if (symbol == '( )') toInsert = '()';

    if (selection.isValid && selection.start >= 0) {
      final newText = text.replaceRange(selection.start, selection.end, toInsert);
      final newCursorPos = selection.start + toInsert.length;
      equationController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: symbol == '( )' ? newCursorPos - 1 : newCursorPos,
        ),
      );
    } else {
      equationController.text = text + toInsert;
      equationController.selection = TextSelection.collapsed(
        offset: equationController.text.length,
      );
    }
  }

  void setEquation(String equation) {
    equationController.text = equation;
    equationController.selection = TextSelection.collapsed(
      offset: equationController.text.length,
    );
    solve();
  }

  void clearEquation() {
    equationController.clear();
    showSolution.value = false;
  }

  void closeSuggestion() {
    showSuggestion.value = false;
  }

  Future<void> solve() async {
    if (equationController.text.trim().isEmpty) {
      Get.snackbar(
        'Empty Equation',
        'Please enter a mathematical expression first',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color(0xFF191C1D),
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      );
      return;
    }

    isSolving.value = true;
    await Future.delayed(const Duration(milliseconds: 500));
    isSolving.value = false;
    showSolution.value = true;
  }

  void onAskNovaAi() {
    Get.toNamed(
      Routes.STUDENT_AI_TUTOR,
      arguments: {
        'initialPrompt': 'Can you explain the step-by-step linear proof for "${equationController.text}"?',
        'topic': 'Linear Equations & Proofs',
      },
    );
  }

  void onSolveAnother() {
    equationController.text = '3x + 9 = 24';
    showSolution.value = true;
    Get.snackbar(
      'New Equation Loaded',
      'Try solving: 3x + 9 = 24 or type your own equation.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: const Color(0xFF0059BB),
      colorText: Colors.white,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  void onProjectInXr() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0F6FF),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(
                  Icons.view_in_ar_rounded,
                  color: Color(0xFF127FD2),
                  size: 36,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '3D Graph Projection in XR',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Plotting equation on the 3D Cartesian Coordinate Plane.\nRoot: (5, 0) with slope m = 2.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF476083),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF127FD2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Close Projection',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onLaunch3DModel() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF53B5E0), Color(0xFF11629E)],
                  ),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: const Icon(
                  Icons.token_rounded,
                  color: Colors.white,
                  size: 34,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'ZAMA Spatial Concept Visualizer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF191C1D),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Launching interactive 3D spatial model for linear proof visualization.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF476083),
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 46,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF127FD2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Got It',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startVoiceInput() {
    isVoiceListening.value = true;
    Get.snackbar(
      'Voice Input Active',
      'Listening for mathematical expression... (Say e.g. "two x plus five equals fifteen")',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF0059BB),
      colorText: Colors.white,
      icon: const Icon(Icons.mic_rounded, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
    Future.delayed(const Duration(seconds: 2), () {
      isVoiceListening.value = false;
      equationController.text = '2x + 5 = 15';
    });
  }

  void _startScanXrMode() {
    Get.snackbar(
      'Scan & XR Mode',
      'Point camera at textbook equation or worksheet to solve.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF127FD2),
      colorText: Colors.white,
      icon: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white),
      duration: const Duration(seconds: 3),
    );
  }
}
