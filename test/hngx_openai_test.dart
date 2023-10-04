import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hngx_openai/repository/openai_repository.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {
  @override
  void close() {}

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    throw UnimplementedError();
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    throw UnimplementedError();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnimplementedError();
  }
}

void main() {
  group('ModelsList Extension', () {
    late http.Client mockClient;

    setUp(() {
      mockClient = MockClient();
    });

    test('retrieveModel handles error response', () async {
      const String userInput = "What is today's date";
      const String cookie =
          "session=487d97a5-3e43-4502-80d4-9315c3d7bf77.24ZfCu95q06BqVuCUFWuJJoLAgM";
      final completions =
          OpenAIRepository().getChatCompletions([], cookie, userInput);

      // Mock the HTTP response to simulate an error
      when(mockClient.get(
        Uri.parse('https://spitfire-interractions.onrender.com/api/chat/'),
        headers: anyNamed('headers'),
      )).thenAnswer((_) async {
        return http.Response(
          jsonEncode({
            'error': {'message': 'Error message'}
          }),
          400,
        );
      });

      final model = await completions;

      expect(model, isNull);
    });

    test("Checking if that we're getting response from the server", () async {
      const String userInput = "What is today's date";
      const String cookie =
          "session=487d97a5-3e43-4502-80d4-9315c3d7bf77.24ZfCu95q06BqVuCUFWuJJoLAgM";

      final response = await OpenAIRepository().getChat(userInput, cookie);
      expect(response.isNotEmpty, true);
    });
  });
}
