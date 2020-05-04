import 'package:flutter/material.dart';

const zeroDuration = Duration(seconds: 0);

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

  Duration sumDurations() => this.fold(zeroDuration, (Duration t, Duration v) => t + v);
}

const secondsInHour = 3600;
const minutesInHour = 60;
const secondsinMinute= 60;

extension DurationUtils on Duration {
  int get hours => this.inSeconds ~/ secondsInHour;
  int get minutes => this.inSeconds ~/ minutesInHour % secondsinMinute;
  int get seconds => this.inSeconds % secondsinMinute;

  String format() {
    if (this.inHours < 1) {
      return this.toString().substring(2, 7);
    }

    if (this.inDays < 1) {
      return this.toString().split('.').first.padLeft(8, "0");
    }

    return this.toString().split('.').first.padLeft(11, "0");
  }

  Duration copyWith({int hours, int minutes, int seconds}) {
    return Duration(
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
    );
  }
}

extension TextEditingControllerUtils on TextEditingController {
  void selectAll() {
    this.selection = TextSelection(baseOffset: 0, extentOffset: this.text.length);
  }
}