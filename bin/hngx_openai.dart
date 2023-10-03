library hngx_openai;

import 'dart:developer';

import 'package:hngx_openai/repository/openai_repository.dart';

void main() async {
  const String userInput = "What is today's date";
  const String token =
      "session=487d97a5-3e43-4502-80d4-9315c3d7bf77.24ZfCu95q06BqVuCUFWuJJoLAgM";

  final aiResponse = await OpenAIRepository().getChat(userInput, token);
  log(aiResponse);
}
