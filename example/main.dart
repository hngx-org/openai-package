import 'package:hngx_openai/chat_completions_lib/chat_completions.dart';
import 'package:hngx_openai/chat_completions_lib/models/chat_completion_model.dart';
import 'package:hngx_openai/completions_lib/completions.dart';
import 'package:hngx_openai/completions_lib/models/ai_models_model.dart';
import 'package:hngx_openai/completions_lib/models/message_model.dart';
import 'package:hngx_openai/gpt/gpt.dart';

void main() async {
  GPT gpt = GPT();
  Completions completions = Completions();
  ChatCompletions chatCompletions = ChatCompletions();

  /// names of models
  print(gpt.apiName);
  print(completions.apiName);

  /// access a list of all models. Use the id property to get the model name
  List<AIModelsModel>? models = await completions.getModels();
  if (models != null) print(models[0].id);

  /// retrieve a model
  AIModelsModel? model = await completions.retrieveModel(modelId: "davinci");
  if (model != null) print(model.id);

  /// return a response from a model
  CompletionModel? response = await completions.sendPrompt(
      model: "davinci", prompt: "Say this is a test", maxTokens: 20);
  if (response != null) print(response.aiResponse);

  /// return a response from a chat model
  ChatCompletionModel? reply = await chatCompletions.sendUserQuery(
      model: "gpt-3.5-turbo-0613", prompt: "Say this is a text");

  if (reply != null) print(reply.aiResponse);
}
