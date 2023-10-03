import 'package:hngx_openai/service/openai_service.dart';

class OpenAIRepository implements OpenAI {
  final openAiService = OpenAIService();

  @override
  Future<String> getChat(String userInput, String token) async {
    final result = await openAiService.chat(userInput, token);

    if (result != null) {
      if (result.error.isEmpty) {
        return "Message: ${result.message}";
      } else {
        return "Error: ${result.error}";
      }
    } else {
      return "";
    }
  }
}

abstract class OpenAI {
  Future<String> getChat(String userInput, String token);
}
