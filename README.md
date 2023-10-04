# HNGx OpenAI package for Stage 5.

This library enables stage 5 developers to focus more on coding and care less about the underlying dynamics of connecting to openAI API.

## Installing
Inside of your pubspec.yaml add these lines under your dependencies.
```yaml
hngx_openai:
    git:
      url: https://github.com/hngx-org/openai-package.git
      ref: main
````

## Importing the package within your project
```dart
import 'package:hngx_openai/repository/openai_repository.dart';
```

## Making use of the OpenAI functionalities
1. Define your query or fetch it from textfield.
   ```dart
   const String userInput = "What is today's date";
   ```
2. Get your session string; cookie (as it is needed for carrying out operations on the package).
   ```dart
   const String cookie =
        "session=487d97a5-3e43-4502-80d4-9315c3d7bf77.24ZfCu95q06BqVuCUFWuJJoLAgM";
   ```
3. Instantiate the OpenAIRepository
   ```dart
   OpenAIRepository openAI = OpenAIRepository();
   ```
4. Make of the **getChat()** function; by passing userInput and cookie as argument.
   ```dart
   final response = await openAI.getChat(userInput, cookie);
   ```

   Or the getChatCompletions which takes list of Strings; history as an additional parameter.
   
   ```dart
   history = ["What is my name", "How are you today?"];
   final response = await openAI.getChatCompletions(history userInput, cookie);
   ```
    
   This returns a String with prefix "Message" and the content if the operation was successful. Or it returns a String with prefix "Error" and the error message if there's any error.
6. Finally display the error on the app.
   ```dart
   setState(() {
      _counter = aiResponse;
    });
   ```
   
- We are returning the String with "Message" or "Error" prefix because we want the developer to use this to filter for when to display the response or display a popup on the app stating the error.

## Full Example
```dart
import 'package:flutter/material.dart';
import 'package:hngx_openai/repository/openai_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
    const String userInput = "What is today's date";
    const String cookie =
        "session=487d97a5-3e43-4502-80d4-9315c3d7bf77.24ZfCu95q06BqVuCUFWuJJoLAgM";

    // Instantiate OpenAIRepository
    OpenAIRepository openAI = OpenAIRepository();

    // For initiating a new chat
    final aiResponse = await openAI.getChat(userInput, cookie);
    // For getting chat completions
    List<String> history = ["What is my name", "How are you today?"];
    final response =
        await openAI.getChatCompletions(history, userInput, cookie);

    setState(() {
      _counter = aiResponse;
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
```

Clicking the floating action button will display the response on the app; be it error or message.

## Authors
- Farouk Bello
- Papa Kofi Boahen
- eokdev
