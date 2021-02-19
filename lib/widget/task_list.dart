import 'package:flutter/material.dart';

import 'package:doneit/util/task.dart';
import "package:doneit/util/duration_format.dart";
import "package:doneit/widget/task.dart";

class TaskListWidget extends StatefulWidget {
  @override
  _TaskListWidget createState() => _TaskListWidget();
}

class _TaskListWidget extends State<TaskListWidget> {
  final List<Task> _tasks = [
    Task("腹筋100回", Duration(days: 1), 20),
    Task("腕立て", Duration(days: 1), 50, [0, 0, 1, 1, 1, 0, 1, 0, 0, 0, 1]),
    Task("スクワット", Duration(days: 1), 36, [0, 1, 1, 1, 1]),
    Task("腹筋", Duration(seconds: 5), 3, [1, 0, 1]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_tasks.length} 個の掟があります"),
      ),
      body: ListView.separated(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks.elementAt(index);
          return ListTile(
            leading: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Icon(task.progress.done ? Icons.check : Icons.assignment),
            ),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text("${task.title} を ${DurationFormat(task.duration.period, every: true)} やります！"),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TaskWidget(task)));
            },
          );
        },
        separatorBuilder: (context, index) => Divider(height: 0),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: '掟を追加',
        onPressed: () {},
      ),
    );
  }
}
