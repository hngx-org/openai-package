library hngx_openai;

import 'dart:developer';

import 'package:hngx_openai/repository/openai_repository.dart';

void main() async {
  const String userInput = "What month are we in???";
  const String cookie =
      "session=75538020-037c-4981-bf17-64e6577885b8.-719DFgx15BEG2ogr-NrYC6UiAA";

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
