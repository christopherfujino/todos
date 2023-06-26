import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Todo {
  Todo._(this.index, this.title, this.body);

  factory Todo(String title, String body) {
    return Todo._(
      nextIndex++,
      title,
      body,
    );
  }

  final String title;
  final String body;
  final int index;

  static int nextIndex = 0;
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Todo> _todos = <Todo>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _todos.map<Widget>((Todo todo) {
            return Card(
              key: Key('TODO ${todo.index}'),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(todo.title),
                    subtitle: Text(todo.body),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() => _todos.remove(todo));
                    },
                    label: const Text('delete'),
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            );
          }).toList(),
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
                            setState(() {
                              _todos.add(Todo(title!, body!));
                            });
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
