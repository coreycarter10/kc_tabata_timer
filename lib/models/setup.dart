import '../utils/utils.dart';

class AppModel {
  List<Workout> _workouts = [];
  List<Workout> get workouts => List.unmodifiable(_workouts);

  Workout currentWorkout;
  Tabata currentTabata;

  AppModel() {
    // mock data
    addWorkout(Workout(
      "Example Workout",
      [
        Tabata(
          exercises: [
            "Pushups",
            "Situps",
          ],
        ),
        Tabata(
          exercises: [
            "Pullups",
            "Crunches",
          ],
        ),
      ],
    ));
  }

  void addWorkout(Workout workout) => _workouts.add(workout);
  void removeWorkout(Workout workout) => _workouts.remove(workout);
  void clearCurrentWorkout() => currentWorkout = null;
  void clearCurrentTabata() => currentTabata = null;
}

class Workout {
  static const defaultRest = Duration(minutes: 2);

  String name;
  List<Tabata> tabatas;
  Duration tabataRestDuration;

  Workout([this.name = 'Untitled Workout', this.tabatas, this.tabataRestDuration = defaultRest]) {
    tabatas = tabatas ?? [];
  }

  void add(Tabata tabata) => tabatas.add(tabata);
  void remove(Tabata tabata) => tabatas.remove(tabata);

  Duration get totalTime {
    final tabataDurations = tabatas.map((Tabata t) => t.totalTime).toList();
    final allDurations = tabataDurations.joinDurations(tabataRestDuration);
    return allDurations.sumDurations();
  }
}

class Tabata {
  static const defaultExercise = Duration(seconds: 30);
  static const defaultRest = Duration(seconds: 10);
  static const defaultSets = 2;

  List<String> exercises;
  Duration exerciseDuration;
  Duration exerciseRestDuration;
  int sets;

  Tabata({this.exercises, this.exerciseDuration = defaultExercise, this.exerciseRestDuration = defaultRest, this.sets = defaultSets}) {
    exercises = exercises ?? [];
  }

  void add(String exercise) => exercises.add(exercise);
  void remove(String exercise) => exercises.remove(exercise);

  Duration get totalTime {
    final totalSets = sets * exercises.length;
    final exerciseDurations = List<Duration>.filled(totalSets, exerciseDuration);
    final allDurations = exerciseDurations.joinDurations(exerciseRestDuration);

    return allDurations.sumDurations();
  }
}