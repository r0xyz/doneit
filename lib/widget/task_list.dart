import 'package:flutter/material.dart';

import 'package:doneit/util/task.dart';
import "package:doneit/util/duration_format.dart";

class TaskListWidget extends StatefulWidget {
  @override
  _TaskListWidget createState() => _TaskListWidget();
}

class _TaskListWidget extends State<TaskListWidget> {
  final List<Task> _tasks = [
    Task("腹筋100回", Duration(days: 1), 20),
    Task("腕立て", Duration(days: 1), 50),
    Task("スクワット", Duration(days: 1), 36),
    Task("腹筋", Duration(seconds: 5), 3),
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
            leading: Icon(Icons.assignment),
            title: Text("${task.title} を ${DurationFormat(task.duration.period, every: true)} やります！"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TaskWidget(task)));
            },
          );
        },
        separatorBuilder: (context, index) => Divider(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: '掟を追加',
        onPressed: () {},
      ),
    );
  }
}

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("掟の詳細"),
      ),
      body: Column(children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blue,
            child: Center(child: Text("${task.title} を ${DurationFormat(task.duration.period, every: true)} やります！", style: Theme.of(context).textTheme.headline6)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Row(children: [
                  Expanded(
                    flex: 2,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("${DurationFormat(task.duration.period, every: true)} x ${task.duration.repeat} 連続")]),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("計 ${DurationFormat(task.duration.total)}")]),
                  )
                ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red[600],
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("開始")]),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("${task.duration.startedAt}")]),
                  )
                ]),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.green[600],
                child: Row(children: [
                  Expanded(
                    flex: 1,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("終了予定")]),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text("${task.duration.endsAt}")]),
                  )
                ]),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
