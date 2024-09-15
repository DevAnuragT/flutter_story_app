import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import '../model/story_model.dart';
import '../services/claude_service.dart';
import '../services/openai_service.dart';

class StoryController extends GetxController {
  var stories = <Story>[].obs;
  var isLoading = false.obs;
  var selectedStoryIndex = (-1).obs;
  FlutterTts flutterTts = FlutterTts();
  TextEditingController promptController = TextEditingController();

  final OpenAIService openAIService = OpenAIService();
  final ClaudeService claudeService = ClaudeService();

  Future<void> generateStory(String prompt) async {
    final userPrompt = prompt.trim();
    if (userPrompt.isEmpty) return;

    isLoading.value = true;
    try {
      // Request OpenAI to generate the title and story
      final openAIResponse = await openAIService.generateStoryWithTitle(userPrompt);

      String title = openAIResponse['title'] ?? "Untitled";  // Get the title
      String story = openAIResponse['story'] ?? "No story generated";  // Get the story content

      // Send the story content to Claude for formatting
      final formattedStory = await claudeService.formatStory(story);

      // Add the new story to the list
      stories.add(Story(
        title: title,  // Use the title from OpenAI response
        generatedStory: story,  // Use the original story content
        formattedStory: formattedStory,  // Use the formatted story from Claude
      ));
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> narrateStory(String formattedStory) async {
    if (formattedStory.isNotEmpty) {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setPitch(1.0);
      await flutterTts.speak(formattedStory);
    }
  }
}
