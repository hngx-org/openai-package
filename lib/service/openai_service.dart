import 'dart:convert';
import 'dart:developer';

import 'package:hngx_openai/models/openai_model.dart';
import 'package:http/http.dart';

class OpenAIService {
  String endpoint = "https://spitfire-interractions.onrender.com/api/chat/";

  // Will Return response from OpenAI
  Future<OpenAIModel?> chat(String userInput, String token) async {
    // Prepare the header of the request to be sent.
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": token,
    };

    // Prepare the query to be sent.
    // This will change depending on the endpoint supplied
    var body = jsonEncode(
      <String, String>{
        "user_input": userInput,
      },
    );

    // Now send the query to the server
    try {
      final result = await post(
        Uri.parse(endpoint),
        headers: headers,
        body: body,
      );

      log(result.body);

      // Check if we our request was successful and get the response
      final feedback = jsonDecode(result.body);

      log(feedback);
      return OpenAIModel(message: feedback["message"]);
    } catch (error) {
      log("Error occurred while sending query: ${error.toString()}");
    }
    return null;
  }
}
