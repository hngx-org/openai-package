# HNGx OpenAI

A simple package for interacting with openai server created by team spitfire during HNGx virtual Internship. This package reduces the amount of boilerplate codes the mobile developers need to write to implement make use of the server.

## Table of Contents

1. [Installing](#installing)
2. [Import Package](#import-package)
3. [How to use the package](#how-to-use-the-package)
4. [Authors](#authors)

## Installing
Inside of your pubspec.yaml add these lines under your **dependencies**.
```yaml
hngx_openai:
    git:
      url: https://github.com/hngx-org/openai-package.git
      ref: main
````

Then run this in your project root folder within the terminal.
```
flutter pub get
```

## Import Package
Import the package into your dart file like this:

```dart
import 'package:hngx_openai/repository/openai_repository.dart';
```

## How to use the package
1. Define your query like this or fetch it from the controller of your textfield/textformfield.
   ```dart
   const String userInput = "What is today's date";

   // OR
   String userInput = textController.text;
   ```
2. Get your session string after logging in or signing up; cookie (it is needed for sending requests).
   ```dart
   const String cookie =
        "session=487d97a5-3e43-4502-80d4-9315c3d7bf77.24ZfCu95q06BqVuCUFWuJJoLAgM";
   ```
3. Instantiate the OpenAIRepository
   It is recommended the developer make use of singleton of ```OpenAIRepository``` in projects.
   
   ```dart
   OpenAIRepository openAI = OpenAIRepository();
   ```
4. Send chat requests to the server.
   - You can send a standalone chat request with ```getChat()```. This method takes in the ```userInput``` and the ```cookie``` object as arguments. Then returns String with the prefix ```Error:``` if there is an error while communicating with the server or a String with the prefix ```Message:``` if the communication was successful.
   
   ```dart
   final response = await openAI.getChat(userInput, cookie);
   ```

   - Then developers can make use of the ```getChatCompletions()``` to continue previous conversations which takes in ```history```; a list of Strings of previous conversations, as an additional parameter to the ```getChat()```. This also returns String with the prefix ```Error:``` if there is an error while communicating with the server or a String with the prefix ```Message:``` if the communication was successful.
   
   ```dart
   history = ["user: Hello!","AI: Hi! How can I help you today?","user: I'm looking for information on the latest trends in artificial intelligence.","AI: Sure, here are some of the latest trends in artificial intelligence"];
   final response = await openAI.getChatCompletions(history userInput, cookie);
   ```

   * Developers can make use of this helper function to get the actual text from the response.
   
   ```dart
    String filterText(String response) {
       if (response.startsWith('M')) {
           // If the return String is a Message
           // Other definitions can come here
           log("This is a Success Text");
           return response.substring(8).trim();
       } else {
           // If the return String is an Error
           // Other definitions can come here
           log("This is an Error Text");
           return response.substring(6).trim();
      }
    }
   ```
   
   It returns the content of the response as a String object.

5. Display the response wherever they're needed.
   ```dart
   setState(() {
      _counter = response;
    });
   ```
   
**NOTE:** We are returning the String with "Message" or "Error" prefix because we want the developer to use this to filter for when to display the response or display a popup on the app stating the error. Also because we are removing all request related concerns for developer. This way they can just call the method and get back the string they needed.

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
      _counter = response;
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
- [Farouk Bello](https://github.com/maverick0x)
- [Papa Kofi Boahen](https://github.com/Boahen123)
- [Emmanuel Olorunshola](https://github.com/eokdev)
