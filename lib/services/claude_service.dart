import 'package:anthropic_sdk_dart/anthropic_sdk_dart.dart';
import 'package:capricon_story_app/utils/api_keys.dart';

class ClaudeService {
  final String apiKey=claudeKey;

  Future<String> formatStory(String story) async {
    final client = AnthropicClient(apiKey: apiKey);
    String prompt="You are an AI assistant with a passion for creative writing and storytelling. Your task is to format a story for a user and make it engaging, offering dramatic expressions in it.";
    try {
      // Create the request for Claude API to format the story
      final response = await client.createMessage(
        request: CreateMessageRequest(
          model: Model.model(Models.claude3Haiku20240307), // Use the Claude model
          maxTokens: 150,
          messages: [
            Message(
              role: MessageRole.user,
              content: MessageContent.text(prompt),
            ),
          ],
        ),
      );

      return response.content.text; // Return the formatted story
    } catch (e) {
      throw Exception('Failed to format story with Claude: $e');
    } finally {
      client.endSession();
    }
  }
}
