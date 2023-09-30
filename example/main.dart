import 'package:hngx_openai/completions_lib/completions.dart';
import 'package:hngx_openai/completions_lib/models/ai_models_model.dart';
import 'package:hngx_openai/gpt/gpt.dart';

void main() async {
  GPT gpt = GPT();
  Completions chatCompletions = Completions();

  /// names of models
  print(gpt.apiName);
  print(chatCompletions.apiName);

  /// access a list of all models. Use the id property to get the model name
  List<AIModelsModel> models = await chatCompletions.getModels();
  print(models[0].id);

  /// get completions
}
