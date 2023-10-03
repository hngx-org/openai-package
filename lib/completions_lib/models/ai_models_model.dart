class AIModelsModel {
  /// Id or name of model
  final String id;
  final int created;
  final String root;

  AIModelsModel({
    required this.id,
    required this.created,
    required this.root,
  });

  factory AIModelsModel.fromJson(Map<String, dynamic> json) {
    return AIModelsModel(
      id: json['id'],
      created: json['created'],
      root: json['root'],
    );
  }

  static List<AIModelsModel> modelsFromAPI(List modelSnapshot) {
    return modelSnapshot
        .map((element) => AIModelsModel.fromJson(element))
        .toList();
  }
}
