import 'package:flutter/material.dart';

import 'src/list.dart';
import 'src/state.dart';

void main() {
  runApp(
    StateWrapper(
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const App(),
      ),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    //final state = InheritedState.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('TODOs')),
      body: const TodoListWidget(0),
    );
  }
}
