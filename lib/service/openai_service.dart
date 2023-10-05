import 'dart:convert';

import 'package:hngx_openai/models/openai_model.dart';
import 'package:http/http.dart' as http;

/// The service class for communication HNGx spitfire's backend API. This class will be
/// instantiated to use the mehods provided by the class.
///
/// Each of the methods provided takes in [cookie] to authenticate the request then
/// returns OpenAIModel object which either contains an error message stored within
/// [error] attribute of the OpenAIModel object returned or contains a response message
/// stored within the [message] attribute of the OpenAIModel object returned.
///
/// The OpenAIModel object returned can never contain both [error] and [message] as it is
/// designed for one to be empty while the other is not. The only condition to this ever
/// changing is if the backend sends it.
///
/// Example:
/// ```dart
/// String userInput = "Translate from "Hello" to Yoruba";
/// String cookie = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
///
/// OpenAIService openAIService = OpenAIService();
///
/// // For initiating a new chat with ChatGPT.
/// OpenAIModel result = await openAIService.getChat(userInput: userInput,
///                                                  cookie: cookie);
///
/// // For resuming a conversation with ChatGPT.
/// List<String> history = ["History 1", "History 2", "History 3"];
/// OpenAIModel result = await openAIService.chatCompletions(
///                               history: history,
///                               userInput: userInput,
///                               cookie: cookie);
///
/// ```
///
/// The [getChat()] and [getChatCompletions()] are both Future objects so they must be
/// called asynchronously for String response to be returned.
class OpenAIService {
  /// This method sends user query to ChatGPT and returns OpenAIModel object holding the
  /// response of the process.
  ///
  /// It takes [cookie] as String object and the [userInput] as String object.
  /// The [cookie] authenticates the request as it is being passed to the headers of the
  /// request while the [userInput] get sent to ChatGPT as body of the request.
  ///
  /// OpenAIModel object then get returned from the method holding either [error] or
  /// [message].
  ///
  /// This method must be called asynchronously for String response to be returned.
  Future<OpenAIModel> chat({
    required String userInput,
    required String cookie,
  }) async {
    String endpoint = "https://spitfire-interractions.onrender.com/api/chat/";

    Map<String, String> headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Cookie": cookie,
    };

    Map<String, dynamic> body = {
      "user_input": userInput,
    };

    try {
      var request = http.Request('POST', Uri.parse(endpoint));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        String text = await response.stream.bytesToString();
        final feedback = jsonDecode(text);

        return OpenAIModel.fromJson(feedback);
      } else {
        String text = await response.stream.bytesToString();
        final feedback = jsonDecode(text);

        return OpenAIModel(
            error: feedback['error'] ?? feedback['content'], message: "");
      }
    } catch (error) {
      return OpenAIModel(error: error.toString(), message: "");
    }
  }

  /// This method sends user query to ChatGPT and returns OpenAIModel object holding the
  /// response of the process.
  ///
  /// It takes [history] as a List of String objects, [cookie] as String object and
  /// [userInput] as String object.
  /// The [cookie] authenticates the request as it is being passed to the headers of the
  /// request while the [history] and [userInput] get sent to ChatGPT as body of the
  /// request.
  ///
  /// OpenAIModel object then get returned from the method holding either [error] or
  /// [message].
  ///
  /// This method must be called asynchronously for String response to be returned.
  Future<OpenAIModel> chatCompletions({
    required List<String> history,
    required String userInput,
    required String cookie,
  }) async {
    String endpoint =
        "https://spitfire-interractions.onrender.com/api/chat/completions";

    Map<String, String> headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Cookie": cookie,
    };

    Map<String, dynamic> body = {
      "history": history,
      "user_input": userInput,
    };

    try {
      var request = http.Request('POST', Uri.parse(endpoint));
      request.body = json.encode(body);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 201) {
        String text = await response.stream.bytesToString();
        final feedback = jsonDecode(text);

        return OpenAIModel.fromJson(feedback);
      } else {
        String text = await response.stream.bytesToString();
        final feedback = jsonDecode(text);

        return OpenAIModel(
            error: feedback['error'] ?? feedback['content'], message: "");
      }
    } catch (error) {
      return OpenAIModel(error: error.toString(), message: "");
    }
  }
}
