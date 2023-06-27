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
  TodoWidget((int, int) indices, {required super.key}) : listsIndex = indices.$1, todoIndex = indices.$2;

  final int listsIndex;
  final int todoIndex;

  @override
  Widget build(BuildContext context) {
    final state = InheritedState.of(context);
    final list = state.lists[listsIndex];
    final todo = list.todos[todoIndex];
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
                onPressed: () => openTodoDialog(context, listsIndex: listsIndex, previousTodoIdx: todoIndex),
                label: const Text('edit'),
                icon: const Icon(Icons.edit),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  list.todos.removeAt(todoIndex);
                  state.updateList(listsIndex, list);
                },
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
