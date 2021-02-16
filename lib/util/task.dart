class Task {
  /// 何を続ける？
  final String title;

  /// どれだけ続ける？
  final TaskDuration duration;

  const Task(this.title, this.duration);
}

class TaskDuration {
  /// 続ける間隔は？
  final Duration period;

  /// 何回続ける？
  final int repeat;

  /// いつ開始した？
  var startedAt = DateTime.now();

  TaskDuration(this.period, this.repeat);

  /// 開始から終了までの範囲は？
  Duration get range => period * repeat;

  /// いつ終了する予定？
  DateTime get endsAt => startedAt.add(range);
}
