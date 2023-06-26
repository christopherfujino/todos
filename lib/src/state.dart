import 'package:flutter/material.dart';

import 'todo.dart';

class StateWrapper extends StatefulWidget {
  const StateWrapper(this.child, {super.key});

  final Widget child;

  @override
  State<StatefulWidget> createState() => WrapperState();
}

class WrapperState extends State<StateWrapper> {
  var todos = <Todo>[];

  @override
  Widget build(BuildContext context) {
    return InheritedState(
      todos,
      (List<Todo> newTodos) => setState(() => todos = newTodos),
      child: widget.child,
    );
  }
}

class InheritedState extends InheritedWidget {
  const InheritedState(
    this._todos,
    this._todoSetter, {
    super.key,
    required super.child,
  });

  final List<Todo> _todos;
  final void Function(List<Todo>) _todoSetter;

  List<Todo> get todos => _todos;
  set todos(List<Todo> todos) => _todoSetter(todos);

  @override
  bool updateShouldNotify(InheritedState oldWidget) => true;

  static InheritedState of(BuildContext ctx) =>
      ctx.dependOnInheritedWidgetOfExactType<InheritedState>()!;
}
