import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hngx_openai/repository/openai_repository.dart';

const String cookie = "session=75538020-037c-4981-bf17-64e6577885b8.-719DFgx15BEG2ogr-NrYC6UiAA";

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  String _counter = "No Chat";

  void _incrementCounter() async {
    // The question
    const String userInput = "What is today's date?";

    List<String> history = ["Assume today's date is January 1, 2022."];

    final aiResponseC = await OpenAIRepository().getChatCompletions(history, userInput, cookie);
    log(aiResponseC);

    setState(() {
      _counter = aiResponseC;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Team Harpoon"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Hit the plus button to get response from the server',
            ),
            Text(
              _counter,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
