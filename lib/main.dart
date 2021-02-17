import 'package:flutter/material.dart';

import "package:doneit/widget/task_list.dart";

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '鉄の掟',
      theme: ThemeData.dark(),
      home: TaskListWidget(),
    );
  }
}
