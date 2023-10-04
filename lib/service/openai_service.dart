import 'dart:convert';

import 'package:hngx_openai/models/openai_model.dart';
import 'package:http/http.dart';

class OpenAIService {
  /// Send Chat Request as String to the server
  /// Either Returns either [message] or [error] within OpenAIModel object returned
  Future<OpenAIModel> chat({
    required String userInput,
    required String cookie,
  }) async {
    String endpoint = "https://spitfire-interractions.onrender.com/api/chat/";
    var client = Client();

    Map<String, String> headers = {
      "accept": "application/json",
      "Content-Type": "application/json",
      "Cookie": cookie,
    };

    Map<String, dynamic> body = {
      "user_input": userInput,
    };

    try {
      var response = await client.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(body),
      );

      // log("Body of the response:\n${response.body}");

      if (response.statusCode == 201) {
        final feedback = jsonDecode(response.body);

        return OpenAIModel.fromJson(feedback);
      } else {
        final feedback = jsonDecode(response.body);

        return OpenAIModel(error: feedback['error'], message: "");
      }
    } catch (error) {
      // log(error.toString());
      return OpenAIModel(error: error.toString(), message: "");
    }
  }

  /// Send Chat Request as String and List of historys to the server
  /// Either Returns either [message] or [error] within OpenAIModel object returned
  Future<OpenAIModel> chatCompletions({
    required List<String> history,
    required String userInput,
    required String cookie,
  }) async {
    String endpoint =
        "https://spitfire-interractions.onrender.com/api/chat/completions";
    var client = Client();

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
      var response = await client.post(
        Uri.parse(endpoint),
        headers: headers,
        body: jsonEncode(body),
      );

      // log("Body of the response:\n${response.body}");

      if (response.statusCode == 201) {
        final feedback = jsonDecode(response.body);

        return OpenAIModel.fromJson(feedback);
      } else {
        final feedback = jsonDecode(response.body);

        return OpenAIModel(error: feedback['error'], message: "");
      }
    } catch (error) {
      // log(error.toString());
      return OpenAIModel(error: error.toString(), message: "");
    }
  }
}
