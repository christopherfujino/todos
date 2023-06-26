import 'package:flutter/material.dart';

import 'input.dart';
import 'state.dart';
import 'todo.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key}) : super(key: key);

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  Widget build(BuildContext context) {
    final state = InheritedState.of(context);
    return Center(
      child: SizedBox(
        width: 500,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ReorderableListView.builder(
                itemCount: state.todos.length,
                itemBuilder: (BuildContext ctx, int idx) => TodoWidget(
                  state,
                  idx,
                  key: Key('TodoWidget ${state.todos[idx].index}'),
                ),
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final oldTodos = state.todos;
                  final current = oldTodos.removeAt(oldIndex);
                  oldTodos.insert(newIndex, current);
                  state.todos = oldTodos;
                },
              ),
            ),
            const Divider(),
            ElevatedButton.icon(
              onPressed: () => openTodoDialog(context, state),
              label: const Text('New'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
