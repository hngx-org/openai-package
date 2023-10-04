import 'package:flutter_test/flutter_test.dart';
import 'package:hngx_openai/repository/openai_repository.dart';

void main() {
  test("Checking if that we're getting response from the server", () async {
    const String userInput = "What is today's date";
    const String cookie =
        "session=487d97a5-3e43-4502-80d4-9315c3d7bf77.24ZfCu95q06BqVuCUFWuJJoLAgM";

    final response = await OpenAIRepository().getChat(userInput, cookie);
    expect(response.isNotEmpty, true);
  });
}
