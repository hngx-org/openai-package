import 'package:flutter_test/flutter_test.dart';

import '../bin/hngx_openai.dart';

void main() {
  test('Checking if our endpoint works', () async {
    final response = await OpenAI().getChatResponse();
    expect(response.isNotEmpty, true);
  });
}
