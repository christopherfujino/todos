import 'package:flutter/material.dart';

import 'input.dart';
import 'state.dart';
import 'todo.dart';

class TodoList {
  TodoList({required this.title, List<Todo>? todos})
      : todos = todos ?? <Todo>[];

  final String title;
  final List<Todo> todos;
}

class TodoListWidget extends StatefulWidget {
  const TodoListWidget(this.listsIndex, {Key? key}) : super(key: key);

  final int listsIndex;

  @override
  State<TodoListWidget> createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget> {
  @override
  Widget build(BuildContext context) {
    final state = InheritedState.of(context);
    final list = state.lists[widget.listsIndex];
    return Center(
      child: SizedBox(
        width: 500,
        child: Column(
          children: <Widget>[
            Text(list.title, style: Theme.of(context).textTheme.titleMedium),
            Expanded(
              child: ReorderableListView.builder(
                itemCount: list.todos.length,
                itemBuilder: (BuildContext ctx, int idx) => TodoWidget(
                  state,
                  (widget.listsIndex, idx),
                  key: Key('TodoWidget ${list.todos[idx].index}'),
                ),
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final oldTodos = list.todos;
                  final current = oldTodos.removeAt(oldIndex);
                  oldTodos.insert(newIndex, current);
                  state.updateList(widget.listsIndex, list);
                },
              ),
            ),
            const Divider(),
            ElevatedButton.icon(
              onPressed: () =>
                  openTodoDialog(context, state, listsIndex: widget.listsIndex),
              label: const Text('New'),
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
