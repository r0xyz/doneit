class Task {
  /// 何を続ける？
  final String title;

  /// 続ける間隔は？
  final Duration _period;

  /// 何回続ける？
  final int _size;

  /// どこまで達成した？
  final List<int> _progressData;

  TaskDuration _duration;
  TaskProgress _progress;

  Task(this.title, this._period, this._size, [this._progressData = const []]) {
    _duration = TaskDuration(_period, _size, DateTime.now());
    _progress = TaskProgress(_progressData, _size);
  }

  /// 期間を管理しているよ
  TaskDuration get duration => _duration;

  /// 進捗を管理しているよ
  TaskProgress get progress => _progress;
}

class TaskDuration {
  /// 続ける間隔は？
  final Duration period;

  /// 何回繰り返す？
  final int repeat;

  /// いつ開始した？
  final DateTime startedAt;

  const TaskDuration(this.period, this.repeat, this.startedAt);

  /// 開始から終了までの範囲は？
  Duration get range => period * repeat;

  /// いつ終了する予定？
  DateTime get endsAt => startedAt.add(range);
}

class TaskProgress {
  /// どこまで達成した？ (0: 失敗、1: 成功)
  final List<int> _data;

  /// 長さは？
  final int length;

  const TaskProgress(this._data, this.length);

  /// 達成した回数は？
  int get completedCount => _data.length;

  /// 達成率は？
  int get completedRate => length <= 0 ? 0 : (completedCount / length * 100).toInt();

  /// 失敗した回数は？
  int get failedCount => _data.where((x) => x == 0).length;

  /// 成功した回数は？
  int get succeedCount => _data.where((x) => x == 1).length;

  /// 成功率は？
  int get succeedRate => completedCount <= 0 ? 0 : (succeedCount / completedCount * 100).toInt();
}
