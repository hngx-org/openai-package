library hngx_openai;

import 'dart:developer';

import 'package:hngx_openai/repository/openai_repository.dart';

void main() async {
  const String userInput = "What is today's date";
  const String cookie =
      "session=96ef3dbc-90ae-4bc0-9c59-812d2155585b.U0PxaqhJkcUjpbLiL7mojeTXXOc";

  // For getting chat
  // final aiResponse = await OpenAIRepository().getChat(userInput, cookie);
  // For chat completions
  final aiResponseC = await OpenAIRepository().getChat(userInput, cookie);
  log(aiResponseC);
}
