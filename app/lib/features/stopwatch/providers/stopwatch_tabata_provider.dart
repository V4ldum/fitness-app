import 'package:fitness_app/config/strings.dart';
import 'package:fitness_app/features/main/domain/domain.dart';

import '../index.dart';

class StopwatchTabataProvider extends StopwatchProvider {
  int? sets;
  int progress = 0;
  bool? _isPause;

  StopwatchTabataProvider({required Bloc bloc}) : super(bloc) {
    _construction();
  }

  StopwatchTabataProvider.fromService({
    required Bloc bloc,
    required StopwatchRepository service,
  }) : super(bloc) {
    _construction();

    service = service;
  }

  StopwatchTabataProvider.fromSavedWorkout({
    required Bloc bloc,
    required Map<String, dynamic> savedWorkout,
  }) : super.fromElapsed(bloc,
            elapsed: savedWorkout[Strings.elapsedKey],
            timeCap: savedWorkout[Strings.timeCapKey]) {
    _construction();

    started = true;

    isRest = savedWorkout[Strings.isRestKey];
    sets = savedWorkout[Strings.setsKey];
    progress = savedWorkout[Strings.progressKey];
    _isPause = savedWorkout[Strings.isPauseKey];

    countdownCounter = 0;
  }

  void _construction() {
    if (bloc.sets > 1) {
      sets = 0;
    }
    countdownCounter = 10;
  }

  @override
  bool get isBtnActive => !isWorkoutFinished;

  @override
  void init() {
    if (bloc.sets > 1) {
      _isPause = false;
    }
    stopwatch.start((bloc as Tabata).work);
  }

  @override
  void onEnd() {
    // Last clock was a rest or a pause
    if (isRest) {
      isRest = false;
      // Last clock was a pause (rest between cycles)
      if (sets != null && _isPause != null && _isPause!) {
        _isPause = false;
        sets = sets! + 1;
        progress = 0;
        stopwatch.start((bloc as Tabata).work);
        return;
      }
      // Last clock was a rest (between works, inside a cycle)
      stopwatch.start((bloc as Tabata).work);
      return;
    }

    // Last clock was a work
    progress++;

    // Last clock was the last work of a cycle
    if (progress >= bloc.exercises.length) {
      // There are multiple cycles to be done
      if (sets != null) {
        // All cycles are done
        if (sets! >= bloc.sets - 1) {
          fin();
          return;
        }
        // All cycles are not done
        isRest = true;
        _isPause = true;
        stopwatch.start((bloc as Tabata).pause);
        return;
      }
      // There aren't multiple cycles to be done
      fin();
      return;
    }
    // Last clock was a work that isn't the last one
    isRest = true;
    stopwatch.start(bloc.rest);
  }

  @override
  Map<String, dynamic> backup() {
    Map<String, dynamic> backup = {};
    Map<String, dynamic> workout = {};

    backup[Strings.idKey] = bloc.toString();

    workout[Strings.isRestKey] = isRest;
    workout[Strings.elapsedKey] = elapsed;
    workout[Strings.timeCapKey] = stopwatch.timeCap;
    workout[Strings.setsKey] = sets;
    workout[Strings.progressKey] = progress;
    workout[Strings.isPauseKey] = _isPause;

    backup[Strings.workoutBackupKey] = workout;

    return backup;
  }
}
