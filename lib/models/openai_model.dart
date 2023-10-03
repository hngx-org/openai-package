class OpenAIModel {
  final String error;
  final String message;

  OpenAIModel({required this.error, required this.message});

  OpenAIModel.fromJson(Map<String, dynamic> json)
      : error = json["error"] ?? "",
        message = json["message"];

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
      };
}
