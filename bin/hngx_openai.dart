library hngx_openai;

import 'dart:developer';

import 'package:hngx_openai/repository/openai_repository.dart';

void main() async {
  const String userInput = "What is today's date";
  const String cookie =
      "session=d6ab1702-050f-4fc1-89e3-8e5e6ab85bec.MlfGY9pUNM0BI-4gd9CpZtvWynQ";

  // For getting chat
  // final aiResponse = await OpenAIRepository().getChat(userInput, cookie);
  // For chat completions
  final aiResponseC =
      await OpenAIRepository().getChatCompletions([], userInput, cookie);
  log(aiResponseC);
}
