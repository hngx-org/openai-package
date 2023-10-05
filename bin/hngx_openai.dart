library hngx_openai;

import 'dart:developer';

import 'package:hngx_openai/repository/openai_repository.dart';

void main() async {
  const String userInput = "What is today's date";
  const String cookie =
      "session=8b611d1b-d438-4755-90e8-d3ff0610baa1.AL8Tvg99Y7hbKMnHkiYKqA8-kso";

  // For getting chat
  // final aiResponse = await OpenAIRepository().getChat(userInput, cookie);
  // For chat completions
  final aiResponseC = await OpenAIRepository().getChat(userInput, cookie);

  log(aiResponseC);
}

String filterText(String response) {
  if (response.startsWith('M')) {
    // If the return String is a Message
    log("This is a Success Text");
    return response.substring(8).trim();
  } else {
    // If the return String is an Error
    log("This is an Error Text");
    return response.substring(6).trim();
  }
}
