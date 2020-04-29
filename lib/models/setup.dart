import 'package:flutter/foundation.dart';

class AppModel {
  List<Workout> _workouts = [];
  List<Workout> get workouts => List.unmodifiable(_workouts);

  Workout currentWorkout;
  Tabata currentTabata;

  AppModel() {
    // mock data
    addWorkout(Workout(
      "Workout 1",
      [
        Tabata(
          [
            "Pushups",
            "Situps",
          ],
          const Duration(seconds: 20),
          const Duration(seconds: 10),
        )
      ],
      const Duration(seconds: 10),
    ));
  }

  void addWorkout(Workout workout) => _workouts.add(workout);

  void clearCurrentWorkout() => currentWorkout = null;
}

class Workout {
  String name;
  List<Tabata> tabatas;
  Duration tabataRestDuration;

  Workout([this.name, this.tabatas, this.tabataRestDuration]);
}

class Tabata {
  final List<String> exercises;
  final Duration exerciseDuration;
  final Duration exerciseRestDuration;

  Tabata([this.exercises, this.exerciseDuration, this.exerciseRestDuration]);
}
