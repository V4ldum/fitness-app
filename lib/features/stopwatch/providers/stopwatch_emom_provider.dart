import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/stopwatch/index.dart';

import '../../main/domain/domain.dart';

class StopwatchEMOMProvider extends StopwatchProvider {
  int? sets;
  int progress = 0;

  StopwatchEMOMProvider({required Bloc bloc}) : super(bloc) {
    _construction();
  }

  StopwatchEMOMProvider.fromService({
    required Bloc bloc,
    required StopwatchRepository service,
  }) : super(bloc) {
    _construction();

    service = service;
  }

  StopwatchEMOMProvider.fromSavedWorkout({
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
    progress = 0;

    if (isRest) {
      stopwatch.start(bloc.rest);
      return;
    }
    stopwatch.start((bloc as EMOM).work);
  }

  @override
  void onEnd() {
    progress++;

    // Only one set
    if (bloc.sets == 1) {
      if (progress >=
          (bloc as EMOM).cap.inSeconds ~/ (bloc as EMOM).work.inSeconds) {
        fin();
        return;
      }
      stopwatch.start((bloc as EMOM).work);
      return;
    }
    // Multiple sets
    // Finished all sets
    if (sets! >= bloc.sets - 1 &&
        progress >=
            (bloc as EMOM).cap.inSeconds ~/ (bloc as EMOM).work.inSeconds) {
      fin();
      return;
    }
    // Has just done a rest phase
    if (isRest) {
      progress = 0;
      sets = sets! + 1;
      isRest = false;
    }
    // Finished one set
    if (progress >=
        (bloc as EMOM).cap.inSeconds ~/ (bloc as EMOM).work.inSeconds) {
      isRest = true;
      stopwatch.start(bloc.rest);
      return;
    }
    stopwatch.start((bloc as EMOM).work);
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

    backup[Strings.workoutBackupKey] = workout;

    return backup;
  }
}
