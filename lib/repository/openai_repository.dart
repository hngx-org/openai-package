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
/// List<String> history = ["History 1", "History 2", "History 3"];
/// String response = await openAI.getChatCompletions(history, query, cookie);
///
/// // Returns either "Message: Some message sent back"
/// // Or it returns "Error: Some error occured during the request"
/// ```
///
/// The [getChat()] and [getChatCompletions()] are both Future objects so they must be
/// called asynchronously for String response to be returned.
class OpenAIRepository implements OpenAI {
  /// Private OpenAIService object that will be used to make all requests sent to the
  /// server. This private object is only intended for use within this class and not
  /// outside the class.
  final _openAiService = OpenAIService();

  /// The [getChat()] method starts a new chat with ChatGPT without considering previous
  /// requests made.
  ///
  /// This method takes [cookie] as String object and the [userInput] as String object.
  /// The [cookie] authenticates the request while the [userInput] get sent to ChatGPT.
  ///
  /// The returned model object is then checked if it contains [message] or [error] so
  /// that a String object with the prefix "Error" or "Message" will be returned for the
  /// developer to use in any way they choose to.
  ///
  /// This method must be called asynchronously for String response to be returned.
  @override
  Future<String> getChat(
    String userInput,
    String cookie,
  ) async {
    final result = await _openAiService.chat(
      userInput: userInput,
      cookie: cookie,
    );

    if (result.error.isEmpty) {
      return "Message: ${result.message}";
    } else {
      return "Error: ${result.error}";
    }
  }

  /// The [getChatCompletions()] method starts a new chat with ChatGPT while considering
  /// previous requests made.
  ///
  /// This method takes [history] as a List of String objects, [cookie] as String object
  /// and the [userInput] as String object.
  /// The [cookie] authenticates the request while the [history] and [userInput] get sent
  ///  to ChatGPT.
  ///
  /// The returned model object is then checked if it contains [message] or [error] so
  /// that a String object with the prefix "Error" or "Message" will be returned for the
  /// developer to use in any way they choose to.
  ///
  /// This method must be called asynchronously for String response to be returned.
  @override
  Future<String> getChatCompletions(
    List<String> history,
    String userInput,
    String cookie,
  ) async {
    final result = await _openAiService.chatCompletions(
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

/// The abstract class for exposing the functionalities provided by OpenAIService.
///
/// This class exists for the sole purpose of handling the response gotten from the
/// server.
///
/// The developer can choose to create their own Repository with custome functionalities.
/// Then this class can be implemented to know what and what is needed to make a
/// successful request. Then add their own functionality for manipulating the data before
/// returning String object.
abstract class OpenAI {
  /// The first method in the OpenAIService class that must be implemented to initiate a
  /// new chat with GPT.
  ///
  /// The method takes [cookie] as String object and the [userInput] as String object.
  /// The [cookie] authenticates the request while the [userInput] get sent to ChatGPT.
  Future<String> getChat(String userInput, String cookie);

  /// The second method in the OpenAIService class that must be implemented to
  /// chat with ChatGPT while considering previous prompts.
  ///
  /// This method takes [history] as a List of String objects, [cookie] as String object
  /// and the [userInput] as String object.
  /// The [cookie] authenticates the request while the [history] and [userInput] get sent
  ///  to ChatGPT.
  Future<String> getChatCompletions(
      List<String> history, String userInput, String cookie);
}
