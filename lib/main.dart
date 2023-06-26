import 'package:flutter/material.dart';

import 'src/list.dart';
import 'src/state.dart';

void main() {
  runApp(
    StateWrapper(
      MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const TodoListWidget(title: 'TODOs'),
      ),
    ),
  );
}


