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
    final state = InheritedState.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('TODOs')),
      body: ReorderableListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: state.lists.length,
        itemBuilder: (BuildContext context, int index) {
          return TodoListWidget(
            index,
            key: Key(
              // TODO this is not guaranteed to be unique
              'TodoListWidget ${state.lists[index].title}',
            ),
          );
        },
        onReorder: (int oldIndex, int newIndex) {},
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createNewList(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _createNewList(BuildContext ctx) {
    final state = InheritedState.of(ctx);
    final oldLists = state.lists;
    oldLists.add(TodoList(title: 'new!'));
    state.lists = oldLists;
  }
}
