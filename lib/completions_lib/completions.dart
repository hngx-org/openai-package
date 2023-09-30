library completions;

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import '../gpt/gpt.dart';
import 'models/ai_models_model.dart';
import 'package:http/http.dart' as http;

part 'models_list.dart';

class Completions {
  /// Returns [name] to lowercase.
  String get apiName => "Completions API";
}
