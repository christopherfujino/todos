import 'package:flutter/material.dart';

import 'src/state.dart';
import 'src/todo.dart';

void main() {
  runApp(
    StateWrapper(
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final state = InheritedState.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.separated(
          itemCount: state.todos.length,
          itemBuilder: (BuildContext ctx, int idx) {
            final todo = state.todos[idx];
            return Card(
              key: Key('TODO ${todo.index}'),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.body),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => state.todos = state.todos..removeAt(idx),
                    label: const Text('delete'),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (_, __) => const Divider(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<void>(
            builder: (BuildContext context) {
              String? title;
              String? body;
              return SimpleDialog(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      TextInput((String val) => title = val),
                      TextInput((String val) => body = val),
                      ButtonBar(children: <Widget>[
                        TextButton(
                          onPressed: () {
                            state.todos = state.todos..add(Todo(title!, body!));
                            Navigator.pop(context);
                          },
                          child: const Text('Submit'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                      ]),
                    ],
                  ),
                ],
              );
            },
            context: context,
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TextInput extends StatefulWidget {
  const TextInput(this.listener, {super.key});

  final void Function(String) listener;

  @override
  _TitleState createState() => _TitleState();
}

class _TitleState extends State<TextInput> {
  _TitleState();

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => widget.listener(_controller.text));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: _controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
