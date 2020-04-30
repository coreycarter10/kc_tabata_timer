extension ListUtils on List<Duration> {
  List<Duration> joinDurations(Duration separator) {
    final Iterator<Duration> iterator = this.iterator;

    final List<Duration> result = [];

    if (!iterator.moveNext()) return result;

    result.add(iterator.current);

    while (iterator.moveNext()) {
      result.add(separator);
      result.add(iterator.current);
    }

    return result;
  }

  Duration sumDurations() => this.reduce((Duration t, Duration v) => t + v);
}

extension DurationUtils on Duration {
  String format() {
    if (this.inHours < 1) {
      return this.toString().substring(2, 7);
    }

    if (this.inDays < 1) {
      return this.toString().split('.').first.padLeft(8, "0");
    }

    return this.toString().split('.').first.padLeft(11, "0");
  }
}