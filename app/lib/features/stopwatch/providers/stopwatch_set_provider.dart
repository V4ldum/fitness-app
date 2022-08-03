import 'package:fitness_app/config/strings.dart';
import 'package:fitness_app/features/main/domain/domain.dart';
import 'package:fitness_app/features/stopwatch/index.dart';

class StopwatchSetProvider extends StopwatchProvider {
  int sets = 0;

  StopwatchSetProvider({required Bloc bloc}) : super(bloc) {
    _construction();
  }

  StopwatchSetProvider.fromService({
    required Bloc bloc,
    required StopwatchRepository service,
  }) : super(bloc) {
    _construction();

    service = service;
  }

  StopwatchSetProvider.fromSavedWorkout({
    required Bloc bloc,
    required Map<String, dynamic> savedWorkout,
  }) : super.fromElapsed(bloc,
            elapsed: savedWorkout[Strings.elapsedKey],
            timeCap: savedWorkout[Strings.timeCapKey]) {
    _construction();

    started = true;

    isRest = savedWorkout[Strings.isRestKey];
    sets = savedWorkout[Strings.setsKey];

    if (isRest) {
      playpauseStopwatch();
    }
  }

  void _construction() {
    countdownCounter = 0; // No Countdown for sets
    stopwatch.start(bloc.rest);
    stopwatch.pause();
  }

  @override
  bool get isBtnActive => !isRest && !isWorkoutFinished;

  @override
  void init() {
    if (!isRest) {
      sets++;

      if (sets >= bloc.sets) {
        fin();
        notifyListeners();
        return;
      }
      isRest = true;
      stopwatch.resume();
    }
  }

  @override
  void onEnd() {
    isRest = false;
    if (sets < bloc.sets - 1) {
      stopwatch.start(bloc.rest);
      stopwatch.pause();
    }
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

    backup[Strings.workoutBackupKey] = workout;

    return backup;
  }
}
