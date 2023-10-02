import 'dart:convert';
import 'dart:developer';

import 'package:hngx_openai/models/openai_model.dart';
import 'package:http/http.dart';

class OpenAIService {
  String endpoint = "";

  // Will Return response from OpenAI
  Future<OpenAIModel?> sendQuery(String query, String token) async {
    // Prepare the header of the request to be sent.
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    // Prepare the query to be sent.
    // This will change depending on the endpoint supplied
    var body = jsonEncode({'message': query});

    // Now send the query to the server
    try {
      final result = await post(
        Uri.parse(endpoint),
        headers: headers,
        body: body,
      );

      // Check if we our request was successful and get the response
      if (result.statusCode == 201) {
        final data = jsonDecode(result.body);

        return OpenAIModel.fromJson(data);
      }
    } catch (error) {
      log("Error occurred while sending query: ${error.toString}");
    }
    return null;
  }
}
