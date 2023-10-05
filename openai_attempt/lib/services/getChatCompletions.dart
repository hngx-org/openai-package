import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hngx_openai/repository/openai_repository.dart';

class ChatCompletionServices {
  final ProviderRef ref;
  ChatCompletionServices(this.ref);
  Future<ResModel> chatCompletion({required GetChatCompletionDataModel model}) async {
    try {
      final aiResponseC = await OpenAIRepository().getChatCompletions(
        model.history!,
        model.userInput!,
        model.cookies!,
      );
      if (aiResponseC.startsWith("M")) {
        return ResModel(
          status: "Success",
          message: aiResponseC,
        );
      } else {
        return ResModel(
          status: "Failed",
          message: aiResponseC,
        );
      }
    } catch (e) {
      return ResModel(
        status: "Failed",
        message: "An error occured",
      );
    }
  }
}

class ResModel {
  final String? status;
  final String? message;

  ResModel({this.status, this.message});
}

final chatCompletionProvider = Provider<ChatCompletionServices>((ref) => ChatCompletionServices(ref));
final chatCompletionResponse = StateProvider.autoDispose<ResModel?>((ref) => null);

final chatCompletion = FutureProvider.autoDispose.family<bool, GetChatCompletionDataModel>((ref, arg) async {
  final fetchdata = await ref.read(chatCompletionProvider).chatCompletion(model: arg);
  final isAuth = fetchdata.status == "Success";
  if (isAuth) {
    ref.read(chatCompletionResponse.notifier).state = fetchdata;
  } else {
    ref.read(chatCompletionResponse.notifier).state = fetchdata;
  }
  return true;
});

class GetChatCompletionDataModel {
  final List<String>? history;
  final String? userInput;
  final String? cookies;

  GetChatCompletionDataModel({
    required this.history,
    required this.userInput,
    required this.cookies,
  });
}
