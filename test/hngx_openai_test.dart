import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';

import '../bin/hngx_openai.dart';

void main() {
  test('Checking if our endpoint works', () async {
    final response = await OpenAI().getChatResponse();
    log(response);
    expect(response.isEmpty, true);
  });
}
