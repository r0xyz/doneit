class Task {
  /// 何を続ける？
  final String title;

  /// 続ける間隔は？
  final Duration period;

  /// 何回続ける？
  final int size;

  /// 開始時刻
  var startedAt = DateTime.now();

  Task(this.title, this.period, this.size);

  /// 終了予定
  DateTime get endsAt => startedAt.add(period * size);
}
