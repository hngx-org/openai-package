import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:hngx_openai/repository/openai_repository.dart';

import 'package:hngx_openai/gpt/gpt.dart';
import 'package:hngx_openai/service/openai_service.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

class MockClient extends Mock implements http.Client {
  @override
  void close() {
    // TODO: implement close
  }

  @override
  Future<http.Response> delete(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) {
    // TODO: implement head
    throw UnimplementedError();
  }

  @override
  Future<http.Response> patch(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement patch
    throw UnimplementedError();
  }

  @override
  Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future<http.Response> put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) {
    // TODO: implement put
    throw UnimplementedError();
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    // TODO: implement readBytes
    throw UnimplementedError();
  }

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    // TODO: implement send
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
      const String cookie = "session=487d97a5-3e43-4502-80d4-9315c3d7bf77.24ZfCu95q06BqVuCUFWuJJoLAgM";
      final completions = OpenAIService().chat(cookie: cookie, userInput: userInput);
      const modelId = 'model1';

      // Mock the HTTP response to simulate an error
      when(mockClient.get(
        Uri.parse('$baseUrlcompletions/models/$modelId'),
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

    test("Checking if we're getting response from the server", () async {
      const String userInput = "What is today's date";
      const String cookie = "session=487d97a5-3e43-4502-80d4-9315c3d7bf77.24ZfCu95q06BqVuCUFWuJJoLAgM";

      final response = await OpenAIRepository().getChat(userInput, cookie);
      expect(response.isNotEmpty, true);
    });
  });
}
