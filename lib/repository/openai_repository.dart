import 'package:hngx_openai/service/openai_service.dart';

class OpenAIRepository implements OpenAI {
  final openAiService = OpenAIService();

  /// Send Chat Request as String to the server
  /// Either Returns either [message] or [error] within OpenAIModel object returned
  @override
  Future<String> getChat(String userInput, String cookie) async {
    final result = await openAiService.chat(
      userInput: userInput,
      cookie: cookie,
    );

    if (result.error.isEmpty) {
      return "Message: ${result.message}";
    } else {
      return "Error: ${result.error}";
    }
  }

  /// Send Chat Request as String and List of historys to the server
  /// Either Returns either [message] or [error] within OpenAIModel object returned
  @override
  Future<String> getChatCompletions(
      List<String> history, String userInput, String cookie) async {
    final result = await openAiService.chatCompletions(
      history: history,
      userInput: userInput,
      cookie: cookie,
    );

    if (result.error.isEmpty) {
      return "Message: ${result.message}";
    } else {
      return "Error: ${result.error}";
    }
  }
}

abstract class OpenAI {
  Future<String> getChat(String userInput, String cookie);

  Future<String> getChatCompletions(
      List<String> history, String userInput, String cookie);
}
