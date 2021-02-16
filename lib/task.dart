import 'dart:math';

extension on Duration {
  String _momentEvery() {
    if (inSeconds < 60) {
      return "$inSeconds秒ごとに";
    } else if (inMinutes < 60) {
      return "$inMinutes分ごとに";
    } else if (inHours < 24) {
      return "$inHours時間ごとに";
    } else {
      return inDays == 1 ? "毎日" : "$inDays日ごとに";
    }
  }
}

class TaskIndex {
  final int volume;
  final List<bool> doneList;
  final int index;

  const TaskIndex({this.volume, this.doneList, this.index});

  // 完了できなかったもの
  void _fill() {
    final size = min(volume, index) - doneList.length;
    if (size > 0) {
      final skip = List<bool>(size);
      skip.fillRange(0, size, false);
      doneList.addAll(skip);
    }
  }

  // 完了できるか
  bool canDone() {
    return index >= doneList.length && index < volume;
  }

  // 完了する
  void done() {
    _fill();
    if (canDone()) {
      doneList.add(true);
    }
  }

  // 更新用
  void update() => _fill();

  // 完了しているかどうか
  bool isDone() {
    return doneList.asMap().containsKey(index) && doneList.elementAt(index);
  }
}

class Task {
  // やること
  final String title;
  // やる頻度
  final Duration period;
  // やる回数
  final int volume;

  // 作成日時
  var _createdAt = DateTime.now();
  // 達成済み
  var _checks = <bool>[];

  Task({this.title, this.period, this.volume});

  // 達成した回数
  int get completed => _checks.length;
  // 成功した回数
  int get succeed => _checks.where((x) => x).length;
  // 失敗した回数
  int get failed => _checks.length - succeed;

  // 進捗
  int get progress => (completed / volume * 100).toInt();
  // 完了したかどうか
  bool get done => completed >= volume;

  // やる頻度をよみやすく
  String get every => period._momentEvery();

  // インデックス
  TaskIndex dateFor(DateTime date) {
    final diff = date.difference(_createdAt);
    final index = diff.inMicroseconds ~/ period.inMicroseconds;
    return TaskIndex(volume: volume, doneList: _checks, index: index);
  }
}
