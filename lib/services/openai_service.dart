import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:capricon_story_app/utils/api_keys.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  final String _apiKey=gptKey;
  final String _baseUrl = 'https://api.openai.com/v1';

  Future<Map<String, String>> generateStoryWithTitle(String prompt) async {
    try {
      var response = await http.post(
        Uri.parse("$_baseUrl/chat/completions"),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {
                "role": "user",
                "content": "Generate a title and story for the following prompt: $prompt",
              }
            ],
            "max_tokens": 150,
          },
        ),
      );

      Map<String, dynamic> jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']["message"]);
      }

      if (jsonResponse["choices"].isNotEmpty) {
        final storyText = jsonResponse["choices"][0]["message"]["content"];

        final title = storyText.split('\n').first;
        final story = storyText.substring(storyText.indexOf('\n') + 1);

        return {
          "title": title,
          "story": story,
        };
      } else {
        throw Exception('No choices returned from OpenAI');
      }
    } catch (error) {
      log("Error generating story: $error");
      throw Exception('Failed to generate story: $error');
    }
  }
}
