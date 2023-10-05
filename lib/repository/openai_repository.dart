import 'package:hngx_openai/service/openai_service.dart';

/// This class implemnts [OpenAI] which provides the functions that will be exposed to
/// developers using the package.
///
/// This class serves as the entity that connects our services with data model together
/// while ensuring the developers doesn't concern themselves with the underlying dynmaics
/// of the request and response.
///
/// They simply instantiate the class; then use the object to interact with OpenAI without
/// worrying about any form of exception. To use the methods exposed by this class the
/// developer will need to extract cookie details after authentication then use that to
/// authorize the request.
///
/// Example: Initiating a new chat with the API with [getChat()]
/// ```dart
/// OpenAIRepository openAI = OpenAIRepository();
///
/// String cookie = "xxxxxxxxxxxxxxxxxxxxxxxxxx";
/// String query = "What is today's date?";
/// String response = await openAI.getChat(query, cookie);
///
/// // Returns either "Message: Some message sent back"
/// // Or it returns "Error: Some error occured during the request"
/// ```
///
/// /// Example: Getting chat completions from the API with [getChatCompletions()]
/// ```dart
/// OpenAIRepository openAI = OpenAIRepository();
///
/// String cookie = "xxxxxxxxxxxxxxxxxxxxxxxxxx";
/// String query = "What is today's date?";
/// List<String> history ["History 1", "History 2", "History 3"];
/// String response = await openAI.getChatCompletions(history, query, cookie);
///
/// // Returns either "Message: Some message sent back"
/// // Or it returns "Error: Some error occured during the request"
/// ```
///
/// The [getChat()] and [getChatCompletions()] are both Future objects so they must be
/// called asynchronously for String response to be returned.
class OpenAIRepository implements OpenAI {
  final openAiService = OpenAIService();

  /// Send Chat Request as String to the server
  /// Either Returns either [message] or [error] within OpenAIModel object returned
  @override
  Future<String> getChat(
    String userInput,
    String cookie,
  ) async {
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
    List<String> history,
    String userInput,
    String cookie,
  ) async {
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
