import 'package:flutter/material.dart';

import 'state.dart';
import 'todo.dart';

Future<void> openTodoDialog(
  BuildContext ctx,
  InheritedState state, {
  int? previousIdx,
}) {
  final Todo? previous = previousIdx == null ? null : state.todos[previousIdx];
  return showDialog<void>(
    builder: (BuildContext context) {
      String? title = previous?.title;
      String? body = previous?.body;
      return SimpleDialog(
        children: <Widget>[
          Column(
            children: <Widget>[
              TextInput((String val) => title = val, initial: title, autofocus: true),
              TextInput((String val) => body = val, initial: body),
              ButtonBar(children: <Widget>[
                TextButton(
                  onPressed: () {
                    final nextTodo = Todo(title!, body!);
                    if (previousIdx == null) {
                      state.todos = state.todos..add(nextTodo);
                    } else {
                      final todos = state.todos;
                      todos.removeAt(previousIdx);
                      todos.insert(previousIdx, nextTodo);
                      state.todos = todos;
                    }
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
    context: ctx,
  );
}

class TextInput extends StatefulWidget {
  const TextInput(this.listener, {super.key, this.initial, this.autofocus = false});

  final void Function(String) listener;
  final String? initial;
  final bool autofocus;

  @override
  _TitleState createState() => _TitleState();
}

class _TitleState extends State<TextInput> {
  _TitleState();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initial)
      ..addListener(() => widget.listener(_controller.text));
  }

  late final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(controller: _controller, autofocus: widget.autofocus);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
