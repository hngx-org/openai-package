library completions;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:hngx_openai/completions_lib/models/message_model.dart';

import '../gpt/gpt.dart';
import 'models/ai_models_model.dart';
import 'package:http/http.dart' as http;

part 'gpt_models.dart';

class Completions {
  /// Returns [name] to lowercase.
  String get apiName => "Completions API";

  Future<CompletionModel?> sendPrompt(
      {maxTokens = 100,
      temperature = 0,
      required String model,
      required String prompt}) async {
    var client = http.Client();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apiKey",
    };

    Map<String, dynamic> body = {
      "model": model,
      "prompt": prompt,
      "max_tokens": maxTokens,
      "temperature": temperature
    };

    try {
      var response = await client.post(
          Uri.parse("$baseUrlcompletions/completions"),
          headers: headers,
          body: jsonEncode(body));

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List modelSnapshot = jsonResponse['choices'];

      if (modelSnapshot.isNotEmpty) {}

      return CompletionModel(
          choicesList: jsonResponse['choices'],
          model: jsonResponse['model'],
          aiResponse: jsonResponse['choices'][0]['text']);
    } catch (error) {
      log('Error caught to console: $error');
      return null;
    } finally {
      client.close();
    }
  }
}
