import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';

class AiTutorIngredientItem {
  final String title;
  final String description;
  final Color color;

  const AiTutorIngredientItem({
    required this.title,
    required this.description,
    required this.color,
  });
}

class AiTutorMessage {
  final String id;
  final bool isUser;
  final String text;
  final DateTime timestamp;
  final String? secondaryText;
  final List<AiTutorIngredientItem>? ingredients;
  final String? conclusionText;
  final String? interactiveModelTitle;
  final String? interactiveModelSubtitle;
  final String? keyFunctionsHeader;
  final List<String>? keyFunctions;
  final String? diagramAsset;

  AiTutorMessage({
    required this.id,
    required this.isUser,
    required this.text,
    required this.timestamp,
    this.secondaryText,
    this.ingredients,
    this.conclusionText,
    this.interactiveModelTitle,
    this.interactiveModelSubtitle,
    this.keyFunctionsHeader,
    this.keyFunctions,
    this.diagramAsset,
  });
}

class StudentAiTutorController extends GetxController {
  final messages = <AiTutorMessage>[].obs;
  final textController = TextEditingController();
  final scrollController = ScrollController();
  final isVoiceListening = false.obs;
  final isTyping = false.obs;
  final String topicTitle = 'Cell Structure';

  final quickPrompts = const [
    'Explain this simpler',
    'Give me an example',
    'Show me a diagram',
  ];

  @override
  void onInit() {
    super.onInit();
    _loadInitialConversation();
  }

  @override
  void onClose() {
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  void _loadInitialConversation() {
    // Exact conversation matching Figma CSS & layout
    messages.assignAll([
      AiTutorMessage(
        id: 'msg_1',
        isUser: true,
        text: 'What is the mitochondria?',
        timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
      ),
      AiTutorMessage(
        id: 'msg_2',
        isUser: false,
        text: 'Think of a plant like a tiny solar-powered kitchen! 🌿',
        secondaryText:
            'Photosynthesis is the process plants use to make their own food. They use:',
        ingredients: const [
          AiTutorIngredientItem(
            title: 'Sunlight',
            description: '(the energy)',
            color: Color(0xFF0059BB),
          ),
          AiTutorIngredientItem(
            title: 'Water',
            description: '(from the roots)',
            color: Color(0xFF4B6062),
          ),
          AiTutorIngredientItem(
            title: 'Carbon Dioxide',
            description: '(from the air)',
            color: Color(0xFF476083),
          ),
        ],
        conclusionText:
            'They mix these ingredients to create sugar for themselves to grow, and they release Oxygen for us to breathe!',
        interactiveModelTitle: '3D Model: Chloroplast',
        interactiveModelSubtitle: 'Tap to interact',
        timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
      ),
    ]);
  }

  void onBackTap() {
    Get.back();
  }

  void onQuickPromptTap(String prompt) {
    sendMessage(prompt);
  }

  void onSendPressed() {
    final query = textController.text.trim();
    if (query.isEmpty) return;
    sendMessage(query);
    textController.clear();
  }

  void sendMessage(String query) {
    // 1. Add user query
    final userMsg = AiTutorMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      isUser: true,
      text: query,
      timestamp: DateTime.now(),
    );
    messages.add(userMsg);
    _scrollToBottom();

    // 2. Simulate AI response
    isTyping.value = true;
    Future.delayed(const Duration(milliseconds: 900), () {
      isTyping.value = false;
      final aiResponse = _generateAiResponse(query);
      messages.add(aiResponse);
      _scrollToBottom();
    });
  }

  AiTutorMessage _generateAiResponse(String query) {
    final lower = query.toLowerCase();

    if (lower.contains('simpler') || lower.contains('simple')) {
      return AiTutorMessage(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        isUser: false,
        text:
            'Think of the mitochondria like the battery or tiny power plant inside your cell! Just like a battery powers your phone, mitochondria turn the food you eat into chemical power (ATP) so your muscles can move and your brain can think.',
        timestamp: DateTime.now(),
        keyFunctionsHeader: 'IN SHORT:',
        keyFunctions: [
          'Food goes in',
          'Oxygen is consumed',
          'Energy (ATP) powers you up!',
        ],
      );
    } else if (lower.contains('example')) {
      return AiTutorMessage(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        isUser: false,
        text:
            'A great real-world example: Muscle cells in athletes contain thousands of mitochondria because they require huge bursts of stamina and energy, while inactive skin cells have far fewer.',
        timestamp: DateTime.now(),
        keyFunctionsHeader: 'REAL LIFE IMPACT:',
        keyFunctions: [
          'Heart muscles: ~40% volume is mitochondria',
          'Exercising triggers growth of new mitochondria',
        ],
      );
    } else if (lower.contains('diagram')) {
      return AiTutorMessage(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        isUser: false,
        text:
            'Here is the 3D anatomical diagram of the cell and its mitochondria membranes:',
        timestamp: DateTime.now(),
        diagramAsset: AppAssets.studentCellStructureHero,
        keyFunctionsHeader: 'MEMBRANE PARTS:',
        keyFunctions: [
          'Outer membrane: Protective barrier',
          'Cristae folds: Surface area for ATP synthesis',
          'Matrix: Contains mitochondrial DNA',
        ],
      );
    } else {
      return AiTutorMessage(
        id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
        isUser: false,
        text:
            'Great question! Inside $topicTitle, every organelle coordinates together. Would you like to explore another part, see an interactive 3D model, or take a quick quiz?',
        timestamp: DateTime.now(),
      );
    }
  }

  void toggleVoiceListening() {
    isVoiceListening.value = !isVoiceListening.value;
    if (isVoiceListening.value) {
      Get.snackbar(
        'Voice Assistant',
        'Listening... Say your question aloud.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF0059BB),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      Future.delayed(const Duration(seconds: 3), () {
        if (isVoiceListening.value) {
          isVoiceListening.value = false;
          sendMessage('Can you explain how ATP is made?');
        }
      });
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 150), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
