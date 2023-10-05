import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class SpitFireGPT {
  /// Returns [name] to lowercase.
  String get apiName => "SpitFire GPT API";

  Future<String?> sendPrompt({required String userInput}) async {
    late Map jsonResponse;
    var client = http.Client();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Cookie":
          "session=94d6d0b6-457f-442e-8e1e-cabd7a88dfea.HXpH1TioUwfua_7wy46h5UfSvRU"
    };

    Map<String, dynamic> body = {
      "user_input": userInput,
    };

    try {
      var response = await client.post(
          Uri.parse("https://spitfire-interractions.onrender.com/api/chat/"),
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
      debugPrint('$error');
      String? modelSnapshot = jsonResponse['message'];
      return modelSnapshot;
    } finally {
      client.close();
    }
  }
}
