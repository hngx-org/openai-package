import 'package:flutter_test/flutter_test.dart';
import 'package:hngx_openai/hngx_openai.dart';

void main() {
  test(
      'This is to test that we\'re getting back null value since we don\'t have endpoint ',
      () async {
    final openAI = OpenAI();
    expect(await openAI.queryResponse, null);
  });
}
