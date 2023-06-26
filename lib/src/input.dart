import 'package:flutter/material.dart';

import 'list.dart';
import 'state.dart';
import 'todo.dart';

Future<void> openTodoDialog(
  BuildContext ctx,
  InheritedState state, {
  int? previousTodoIdx,
  required int listsIndex,
}) {
  final TodoList list = state.lists[listsIndex];
  final Todo? previous = previousTodoIdx == null ? null : list.todos[previousTodoIdx];
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
                    if (previousTodoIdx == null) {
                      state.updateList(listsIndex, list..todos.add(nextTodo));
                    } else {
                      list.todos.removeAt(previousTodoIdx);
                      list.todos.insert(previousTodoIdx, nextTodo);
                      state.updateList(listsIndex, list);
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
