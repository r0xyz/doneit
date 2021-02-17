import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'package:doneit/util/task.dart';
import "package:doneit/util/duration_format.dart";

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
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          color: Colors.teal,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("${task.title} を ${DurationFormat(task.duration.period, every: true)} やります！", style: Theme.of(context).textTheme.headline6),
          ]),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("${DurationFormat(task.duration.period, every: true)} x ${task.duration.repeat} 連続 = 計 ${DurationFormat(task.duration.total)}"),
          ]),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            LinearPercentIndicator(
              padding: EdgeInsets.symmetric(horizontal: 25),
              lineHeight: 30,
              animation: true,
              animationDuration: 3000,
              percent: task.progress.completedRate,
              center: Text("${(task.progress.completedRate * 100).toInt()}% 完了"),
              trailing: Text("${task.progress.completedCount} / ${task.progress.length}"),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor: Colors.blue,
              backgroundColor: Theme.of(context).splashColor,
            ),
          ]),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CircularPercentIndicator(
              radius: 120,
              lineWidth: 15,
              animation: true,
              animationDuration: 4000,
              percent: task.progress.succeedRate,
              center: Text("${(task.progress.succeedRate * 100).toInt()}% 達成"),
              footer: Text("${task.progress.succeedCount} / ${task.progress.failedCount}"),
              progressColor: Colors.green,
              backgroundColor: Theme.of(context).splashColor,
            ),
          ]),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(children: [
              Expanded(
                flex: 1,
                child: Column(children: [Text("開始")]),
              ),
              Expanded(
                flex: 2,
                child: Column(children: [Text("${task.duration.startedAt}")]),
              )
            ]),
          ]),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Row(children: [
              Expanded(
                flex: 1,
                child: Column(children: [Text("終了予定")]),
              ),
              Expanded(
                flex: 2,
                child: Column(children: [Text("${task.duration.endsAt}")]),
              )
            ]),
          ]),
        ),
      ]),
    );
  }
}
