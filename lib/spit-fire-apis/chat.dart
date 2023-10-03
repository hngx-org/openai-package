import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class SpitFireOpenAI {
  /// Returns [name] to lowercase.
  String get apiName => "Completions API";

  Future<String?> sendPrompt(
      {required List<String> history, required String userInput}) async {
    late Map jsonResponse;
    var client = http.Client();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Cookie":
          "session=94d6d0b6-457f-442e-8e1e-cabd7a88dfea.HXpH1TioUwfua_7wy46h5UfSvRU"
    };

    Map<String, dynamic> body = {
      "history": history,
      "user_input": userInput,
    };

    try {
      var response = await client.post(
          Uri.parse(
              "https://spitfire-interractions.onrender.com/api/chat/completions"),
          headers: headers,
          body: jsonEncode(body));

      jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']);
      }

      String? modelSnapshot = jsonResponse['message'];

      // if (modelSnapshot) {}

      return modelSnapshot;
    } catch (error) {
      print('$error');
      String? modelSnapshot = jsonResponse['message'];
      return modelSnapshot;
    } finally {
      client.close();
    }
  }
}
