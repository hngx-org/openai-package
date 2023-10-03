library gpt;

// import 'package:dotenv/dotenv.dart' as dotenv;
import 'package:dotenv/dotenv.dart';

DotEnv env = DotEnv(includePlatformEnvironment: true)..load();

/// Globally access the API key, import in any file needed
String? apiKey = env['OPENAI_API_KEY'];

/// Globally access the baseUrl for completions, import in any file needed
String? baseUrlcompletions = env['OPENAI_BASE_URL'];

class GPT {
  /// Returns [name] of this model.
  String get apiName => "GPT API";

}

