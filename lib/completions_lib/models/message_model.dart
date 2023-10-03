class CompletionModel {
  /// Id or name of model
  final List choicesList;
  final String model;
  final String aiResponse;

  CompletionModel({
    required this.choicesList,
    required this.model,
    required this.aiResponse,
  });

  factory CompletionModel.fromJson(Map<String, dynamic> json) {
    return CompletionModel(
        choicesList: json['choices'],
        model: json['model'],
        aiResponse: json['choices'][0]['text']);
  }
}
