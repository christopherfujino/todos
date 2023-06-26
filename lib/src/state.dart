import 'package:flutter/material.dart';

import 'list.dart';

class StateWrapper extends StatefulWidget {
  const StateWrapper(this.child, {super.key});

  final Widget child;

  @override
  State<StatefulWidget> createState() => WrapperState();
}

class WrapperState extends State<StateWrapper> {
  var lists = <TodoList>[TodoList(title: 'TODO')];

  @override
  Widget build(BuildContext context) {
    return InheritedState(
      lists,
      (List<TodoList> newLists) => setState(() => lists = newLists),
      child: widget.child,
    );
  }
}

class InheritedState extends InheritedWidget {
  const InheritedState(
    this._todoLists,
    this._todoListsSetter, {
    super.key,
    required super.child,
  });

  final List<TodoList> _todoLists;
  final void Function(List<TodoList>) _todoListsSetter;

  List<TodoList> get lists => _todoLists;
  set lists(List<TodoList> todoLists) => _todoListsSetter(todoLists);

  void updateList(int index, TodoList newList) {
    _todoLists[index] = newList;
    _todoListsSetter(_todoLists);
  }

  @override
  bool updateShouldNotify(InheritedState oldWidget) => true;

  static InheritedState of(BuildContext ctx) =>
      ctx.dependOnInheritedWidgetOfExactType<InheritedState>()!;
}
