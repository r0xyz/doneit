import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:doneit/task.dart';

// TODO: ツイッター連携
// TODO: パーセントで後ろの色を変える
// TODO: タップで新しいページを作る
// TODO: だんだんキツくなるタスクの作成
// TODO: 確認の通知

class App extends StatelessWidget {
  final _title = "鉄の掟";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.grey,
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
      title: "腕立てをする",
      period: Duration(days: 1),
      volume: 50,
    ),
    Task(
      title: "スクワットをする",
      period: Duration(days: 1),
      volume: 36,
    ),
    Task(
      title: "腹筋をする",
      period: Duration(days: 1),
      volume: 3,
    ),
  ];
  Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
              // 編集ボタン
              IconSlideAction(
                caption: '編集',
                color: Colors.blue,
                icon: Icons.edit,
                onTap: () {},
              ),
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
