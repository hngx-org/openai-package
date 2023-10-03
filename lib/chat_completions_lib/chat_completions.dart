library chat_completions;

import 'dart:convert';
import 'dart:io';

import 'package:hngx_openai/gpt/gpt.dart';
import 'package:http/http.dart' as http;

import 'models/chat_completion_model.dart';

// part 'gpt_models.dart';

class ChatCompletions {
  static List<Map<String, String>> messages = [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "Hello!"}
  ];

  /// List maintained to store currently running conversation(responses and replies)
  static List<Map<String, String>> get getConversationArray => messages;

  /// Update array with new responses
  void updateConversationArray(List<Map<String, String>> newMessage) {
    messages.addAll(newMessage);
  }

  /// Returns [name] to lowercase.
  String get apiName => "Chat Completions API";

  Future<ChatCompletionModel?> sendUserQuery(
      {String model = "gpt-3.5-turbo", required String prompt}) async {
    var client = http.Client();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    Map<String, dynamic> body = {
      "model": model,
      "messages": ChatCompletions.messages
    };

    try {
      var response = await client.post(
          Uri.parse("$baseUrlcompletions/chat/completions"),
          headers: headers,
          body: jsonEncode(body));

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      // List modelSnapshot = jsonResponse['choices'];

      // if (modelSnapshot.isNotEmpty) {}
      List<Map<String, String>> newMessage = [
        {
          "role": "user",
          "content": prompt,
        },
        {
          "role": "system",
          "content": jsonResponse['choices'][0]['message']['content'],
        }
      ];

      /// update conversation array
      ChatCompletions().updateConversationArray(newMessage);

      return ChatCompletionModel(
          choicesList: jsonResponse['choices'],
          model: jsonResponse['model'],
          aiResponse: jsonResponse['choices'][0]['message']['content']);
    } catch (error) {
      print('Error caught to console: $error');
      return null;
    } finally {
      client.close();
    }
  }
}
