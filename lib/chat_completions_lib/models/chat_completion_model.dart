class ChatCompletionModel {
  /// Id or name of model
  final List choicesList;
  final String model;
  final String aiResponse;

  ChatCompletionModel({
    required this.choicesList,
    required this.model,
    required this.aiResponse,
  });

  factory ChatCompletionModel.fromJson(Map<String, dynamic> json) {
    return ChatCompletionModel(
        choicesList: json['choices'],
        model: json['model'],
        aiResponse: json['choices'][0]['message']['content']);
  }
}
