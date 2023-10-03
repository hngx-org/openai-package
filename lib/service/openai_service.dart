import 'dart:convert';
import 'dart:developer';

import 'package:hngx_openai/models/openai_model.dart';
import 'package:http/http.dart';

class OpenAIService {
  Future<OpenAIModel?> chat(String userInput, String token) async {
    // Endpoint for the chat API
    String endpoint =
        "https://spitfire-interractions.onrender.com/api/chat/completions";

    // Prepare the header of the request to be sent.
    Map<String, String> headers = {
      "accept": "application/json",
      "Content-Type": "application/json; charset=UTF-8",
      "Cookie": token,
    };

    // Prepare the query to be sent.
    // This will change depending on the endpoint supplied
    var body = jsonEncode(
      <String, String>{
        "user_input": userInput,
      },
    );

    try {
      final result = await post(
        Uri.parse(endpoint),
        headers: headers,
        body: body,
      );

      log("Body of the response:\n${result.body}");

      if (result.statusCode == 201) {
        final feedback = jsonDecode(result.body);

        return OpenAIModel.fromJson(feedback);
      } else {
        final feedback = jsonDecode(result.body);

        return OpenAIModel(error: feedback['error'], message: "");
      }
    } catch (e) {
      log(e.toString());
      return OpenAIModel(error: e.toString(), message: "");
    }
  }
}
