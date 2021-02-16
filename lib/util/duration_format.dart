class _Format {
  final int value;
  final String suffix;

  const _Format([this.value = 0, this.suffix = ""]);
}

class DurationFormat {
  final Duration duration;
  final bool every;

  const DurationFormat(this.duration, {this.every});

  @override
  String toString() {
    final formats = [
      _Format(duration.inDays, "日"),
      _Format(duration.inHours, "時間"),
      _Format(duration.inMinutes, "分"),
      _Format(duration.inSeconds, "秒"),
    ];
    final fmt = formats.firstWhere((x) => x.value > 0, orElse: () => _Format());
    return every ? (fmt.value == 1 ? "毎${fmt.suffix}" : "${fmt.value}${fmt.suffix}ごと") : "${fmt.value}${fmt.suffix}";
  }
}
