class OpenAIModel {
  final String message;

  OpenAIModel({required this.message});

  OpenAIModel.fromJson(Map<String, dynamic> json) : message = json["message"];

  Map<String, dynamic> toJson() => {
        'message': message,
      };
}
