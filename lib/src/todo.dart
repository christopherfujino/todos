import 'package:flutter/material.dart';
import 'package:todo_flutter/src/input.dart';

import 'state.dart';

// TODO make a provider
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

class TodoWidget extends StatelessWidget {
  const TodoWidget(this.state, this.idx, {required super.key});

  final InheritedState state;
  final int idx;

  @override
  Widget build(BuildContext context) {
    final todo = state.todos[idx];
    return Card(
      key: Key('TODO ${todo.index}'),
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.body),
          ),
          ButtonBar(
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: () => openTodoDialog(context, state, previousIdx: idx),
                label: const Text('edit'),
                icon: const Icon(Icons.edit),
              ),
              ElevatedButton.icon(
                onPressed: () => state.todos = state.todos..removeAt(idx),
                label: const Text('delete'),
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
