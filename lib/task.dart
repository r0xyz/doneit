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
  // 作成日時
  var createdAt = DateTime.now();
  // やること
  final String title;
  // やる頻度
  final Duration period;
  // やる回数
  final int volume;
  // 完了済み
  var doneList = <bool>[];

  Task({this.title, this.period, this.volume});

  // 読みやすい頻度
  String every() => period._momentEvery();
  // 進捗
  int percent() => (doneList.length / volume * 100).toInt();
  // 達成したかどうか
  bool isComplete() => doneList.length == volume;

  // インデックス
  TaskIndex dateFor(DateTime date) {
    final diff = date.difference(createdAt);
    final index = diff.inMicroseconds ~/ period.inMicroseconds;
    return TaskIndex(volume: volume, doneList: doneList, index: index);
  }
}
