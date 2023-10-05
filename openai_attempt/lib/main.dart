import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hngx_openai/repository/openai_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _counter = "No Chat";

  void _incrementCounter() async {
    // The question
    const String userInput = "What is today's date?";
    const String cookie =
        "session=75538020-037c-4981-bf17-64e6577885b8.-719DFgx15BEG2ogr-NrYC6UiAA";

    List<String> history = ["Assume today's date is January 1, 2022."];

    final aiResponseC =
        await OpenAIRepository().getChatCompletions(history, userInput, cookie);
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
        title: Text(widget.title),
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
