import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:hngx_openai/completions_lib/completions.dart';
import 'package:hngx_openai/completions_lib/models/ai_models_model.dart';
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
    String? apiKey = env['OPENAI_API_KEY'];

    setUp(() {
      mockClient = MockClient();
    });

    test('retrieveModel handles error response', () async {
      final completions = OpenAIService().chat("who are you", apiKey!);
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
  });
}
