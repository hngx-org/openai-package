library hngx_openai;

import 'dart:developer';

import 'package:hngx_openai/service/openai_service.dart';

class OpenAI {
  final String userInput = "What is today's date";
  final String token =
      "session=487d97a5-3e43-4502-80d4-9315c3d7bf77.24ZfCu95q06BqVuCUFWuJJoLAgM";

  Future<String> getChatResponse() async {
    final result = await OpenAIService().chat(userInput, token);

    if (result != null) {
      log(result.message);
      return result.message;
    } else {
      return "";
    }
  }
}

void main() async {
  final response = await OpenAI().getChatResponse();
  print(response);
}
