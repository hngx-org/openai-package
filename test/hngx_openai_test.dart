import 'package:flutter_test/flutter_test.dart';
import 'package:hngx_openai/hngx_openai.dart';

void main() {
  test('Returns HELLO in lower case', () {
    final openAI = OpenAI();
    expect(openAI.sample("HELLO"), 'hello');
  });
}
