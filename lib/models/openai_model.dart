class OpenAIModel {
  final String model;
  final String response;

  OpenAIModel({required this.model, required this.response});

  OpenAIModel.fromJson(Map<String, dynamic> json)
      : model = json['model'],
        response = json['response'];

  Map<String, dynamic> toJson() => {
        'model': model,
        'response': response,
      };
}
