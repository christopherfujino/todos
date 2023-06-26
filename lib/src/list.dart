import 'package:flutter/material.dart';

import 'input.dart';
import 'state.dart';
import 'todo.dart';

class TodoListWidget extends StatefulWidget {
  const TodoListWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  Widget build(BuildContext context) {
    final state = InheritedState.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => openTodoDialog(context, state),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
