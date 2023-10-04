import 'dart:convert';

import 'package:hngx_openai/models/openai_model.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  /// Send Chat Request as String to the server
  /// Either Returns either [message] or [error] within OpenAIModel object returned
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

        return OpenAIModel(error: feedback['error'], message: "");
      }
    } catch (error) {
      // log(error.toString());
      return OpenAIModel(error: error.toString(), message: "");
    }
  }
}
