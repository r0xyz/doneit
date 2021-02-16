import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:doneit/task.dart';

// TODO: ツイッター連携
// TODO: パーセントで後ろの色を変える
// TODO: タップで新しいページを作る
// TODO: だんだんキツくなるタスクの作成
// TODO: 確認の通知
// TODO: 達成しなかった場合に消すか待機するか

class App extends StatelessWidget {
  final _title = "鉄の掟";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        brightness: Brightness.dark,
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
      period: Duration(seconds: 5),
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
        title: Text(widget.title),
        centerTitle: true,
        toolbarHeight: 100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(60),
          ),
        ),
      ),
      // 一覧表示
      body: ListView.separated(
        itemBuilder: (context, index) {
          final task = _tasks.elementAt(index);
          final taskIndex = task.dateFor(DateTime.now());

          // デバッグ用
          print("${task.title}");

          // アイコン
          final icon = Icon(
            task.done
                ? Icons.check
                : (taskIndex.isDone()
                    ? Icons.assignment_turned_in
                    : Icons.assignment_late_outlined),
          );

          return Slidable(
            child: ListTile(
              enabled: taskIndex.canDone(),
              leading: icon,
              title: Text("${task.every}、${task.title}"),
              subtitle: Text(
                  "${task.progress}% 完了 (${task.completed} / ${task.volume}) / ${task.succeed} 達成 - ${task.failed} 失敗"),
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
        tooltip: '掟を追加',
        child: Icon(Icons.add),
      ),
    );
  }
}