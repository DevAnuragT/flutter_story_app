import 'package:flutter_dotenv/flutter_dotenv.dart';

final String gptKey = dotenv.env['OPENAI_API_KEY'] ?? " ";
String claudeKey = dotenv.env['CLAUDE_API_KEY'] ?? " ";