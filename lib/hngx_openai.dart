library hngx_openai;

import 'package:hngx_openai/service/openai_service.dart';

class OpenAI {
  final String query = "Some text";
  final String token = "some token";

  // Should return NULL
  final queryResponse = OpenAIService().sendQuery("Some text", "Some token");
}
