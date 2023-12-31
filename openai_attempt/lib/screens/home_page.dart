import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:openai_attempt/constants/constants.dart';
import 'package:openai_attempt/services/get_chat_completions.dart';
import 'package:openai_attempt/widgets/alert_dialog.dart';

final loadingState = StateProvider<bool>((ref) => false);

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  final chatController = TextEditingController();
  String message = "";
  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(chatCompletionResponse, (previous, next) {
      if (next!.status == "Success") {
        chatController.text = "";
        setState(() {
          message = next.message ?? "";
        });
        ref.read(loadingState.notifier).state = false;
      } else {
        ref.read(loadingState.notifier).state = false;
        errResponseDialog(context: context, errMessage: next.message);
      }
    });
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leadingWidth: 100,
          leading: const Padding(
            padding: EdgeInsets.only(left: 5),
            child: Center(
              child: Stack(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: AssetImage("images/farouk.jpeg"),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 25,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage("images/passport.jpg"),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 50,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundImage: AssetImage("images/papakoffi.jpeg"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            "Team Harpoon",
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              //Ai Response here
              message.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: SizedBox(
                        height: double.infinity,
                        width: MediaQuery.of(context).size.width,
                        child: Center(child: SvgPicture.asset("images/bg_image.svg")),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          top: 15,
                          right: 15,
                          left: 15,
                          bottom: 15,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
              Positioned(
                bottom: 2,
                child: Container(
                  height: 74,
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 10,
                    bottom: 10,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        width: MediaQuery.of(context).size.width * 0.7,
                        padding: const EdgeInsets.only(left: 15),
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: chatController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Type something...",
                              hintStyle: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (chatController.text.isNotEmpty) {
                            FocusScope.of(context).unfocus();
                            ref.read(loadingState.notifier).state = true;
                            final data =
                                GetChatCompletionDataModel(history: ["history"], userInput: chatController.text, cookies: ConstantDatas.cookie);
                            ref.read(chatCompletion(data));
                          }
                        },
                        child: Container(
                          height: 56,
                          width: MediaQuery.of(context).size.width * 0.16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ref.watch(loadingState)
                              ? const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 25, width: 25, child: CircularProgressIndicator()),
                                  ],
                                )
                              : const Icon(
                                  Icons.send_sharp,
                                  color: Colors.black,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
