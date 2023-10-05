class RelatableModel {
  /// Id or name of model
  final String id;
  final int created;
  final String root;

  RelatableModel({
    required this.id,
    required this.created,
    required this.root,
  });

  factory RelatableModel.fromJson(Map<String, dynamic> json) {
    return RelatableModel(
      id: json['id'],
      created: json['created'],
      root: json['root'],
    );
  }

  static List<RelatableModel> modelsFromAPI(List modelSnapshot) {
    return modelSnapshot
        .map((element) => RelatableModel.fromJson(element))
        .toList();
  }
}
