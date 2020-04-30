import '../utils/utils.dart';

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
          exercises: [
            "Pushups",
            "Situps",
          ],
          exerciseDuration: const Duration(seconds: 20),
          exerciseRestDuration: const Duration(seconds: 10),
          sets: 4,
        ),
        Tabata(
          exercises: [
            "Pullups",
            "Crunches",
          ],
          exerciseDuration: const Duration(seconds: 20),
          exerciseRestDuration: const Duration(seconds: 10),
          sets: 4,
        ),
      ],
      const Duration(seconds: 10),
    ));

    print(_workouts.first.tabatas.first.totalTime);
  }

  void addWorkout(Workout workout) => _workouts.add(workout);

  void clearCurrentWorkout() => currentWorkout = null;
}

class Workout {
  String name;
  List<Tabata> tabatas;
  Duration tabataRestDuration;

  Workout([this.name, this.tabatas, this.tabataRestDuration]);

  Duration get totalTime {
    final tabataDurations = tabatas.map((Tabata t) => t.totalTime).toList();
    final allDurations = tabataDurations.joinDurations(tabataRestDuration);
    return allDurations.sumDurations();
  }
}

class Tabata {
  final List<String> exercises;
  final Duration exerciseDuration;
  final Duration exerciseRestDuration;
  final int sets;

  Tabata({this.exercises, this.exerciseDuration, this.exerciseRestDuration, this.sets});

  Duration get totalTime {
    final totalSets = sets * exercises.length;
    final exerciseDurations = List<Duration>.filled(totalSets, exerciseDuration);
    final allDurations = exerciseDurations.joinDurations(exerciseRestDuration);

    return allDurations.sumDurations();
  }
}