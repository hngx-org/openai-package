part of 'completions.dart';

extension ModelsList on Completions {
  String get chatCompletionsName => "ChatCompletions";

  /// List the various models available in the API.
  Future<List<AIModelsModel>?> getModels() async {
    var client = http.Client();
    Map<String, String> headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json",
    };

    try {
      var response = await client.get(Uri.parse("$baseUrlcompletions/models"),
          headers: headers);

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List modelSnapshot = jsonResponse['data'];

      List<String> models = [];
      void addUp(e) {
        models.add(e['id']);
      }

      modelSnapshot.forEach(addUp);

      return AIModelsModel.modelsFromAPI(modelSnapshot);
    } catch (error) {
      log('Error: $error');
      return null;
    } finally {
      client.close();
    }
  }

  Future<AIModelsModel?> retrieveModel({required String modelId}) async {
    var client = http.Client();
    Map<String, String> headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json",
    };
//
    try {
      var response = await client.get(
          Uri.parse("$baseUrlcompletions/models/$modelId"),
          headers: headers);

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      return AIModelsModel(
          id: jsonResponse['id'],
          created: jsonResponse['created'],
          root: jsonResponse['root']);
    } catch (error) {
      print('Error: $error');
      return null;
    } finally {
      client.close();
    }
  }
}