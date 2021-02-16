import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:doneit/task.dart';

// TODO: ツイッター連携
// TODO: パーセントで後ろの色を変える

class App extends StatelessWidget {
  final _title = "Done It";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: TaskListWidget(
        title: _title,
      ),
    );
  }
}

class TaskListWidget extends StatefulWidget {
  TaskListWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TaskListWidget createState() => _TaskListWidget();
}

class _TaskListWidget extends State<TaskListWidget> {
  var _tasks = [
    Task(
      title: "腹筋を10回する",
      period: Duration(days: 1),
      volume: 500,
    ),
    Task(
      title: "散歩をする",
      period: Duration(days: 1),
      volume: 365,
    ),
    Task(
      title: "飲み物を飲む",
      period: Duration(seconds: 5),
      volume: 3,
    ),
  ];
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      _tasks.forEach((task) {
        setState(() {
          task.dateFor(DateTime.now()).update();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 上部のバー
      appBar: AppBar(
        leading: Icon(Icons.work),
        title: Text(widget.title),
      ),
      // 一覧表示
      body: ListView.separated(
        itemBuilder: (context, index) {
          final task = _tasks.elementAt(index);
          final taskIndex = task.dateFor(DateTime.now());

          // デバッグ用
          print("${task.title} => ${task.doneList}");

          // アイコン
          final icon = Icon(
            task.isComplete()
                ? Icons.check
                : (taskIndex.isDone()
                    ? Icons.assignment_turned_in
                    : Icons.assignment_late_outlined),
          );

          return Slidable(
            child: ListTile(
              enabled: taskIndex.canDone(),
              leading: icon,
              title: Text("${task.every()}、${task.title}"),
              subtitle: Text(
                  "${task.percent()}% 完了 (${task.doneList.length} / ${task.volume})"),
              onTap: () {
                setState(() => taskIndex.done());
              },
            ),
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            secondaryActions: [
              // 削除ボタン
              IconSlideAction(
                caption: '削除',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  setState(() {
                    _tasks.removeAt(index);
                  });
                },
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 0,
          );
        },
        itemCount: _tasks.length,
      ),
      // TODO: 追加ボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'タスクを追加',
        child: Icon(Icons.add),
      ),
    );
  }
}
