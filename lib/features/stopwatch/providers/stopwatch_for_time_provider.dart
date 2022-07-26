import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/main/domain/domain.dart';
import 'package:fitness_app/features/stopwatch/index.dart';

class StopwatchForTimeProvider extends StopwatchProvider {
  int? sets;

  StopwatchForTimeProvider({
    required Bloc bloc,
  }) : super(bloc) {
    _construction();
  }

  StopwatchForTimeProvider.fromService({
    required Bloc bloc,
    required StopwatchRepository service,
  }) : super(bloc) {
    _construction();

    service = service;
  }

  StopwatchForTimeProvider.fromSavedWorkout({
    required Bloc bloc,
    required Map<String, dynamic> savedWorkout,
  }) : super.fromElapsed(bloc,
            elapsed: savedWorkout[Strings.elapsedKey],
            timeCap: savedWorkout[Strings.timeCapKey]) {
    _construction();

    started = true;

    isRest = savedWorkout[Strings.isRestKey];
    sets = savedWorkout[Strings.setsKey];

    countdownCounter = 0;
  }

  void _construction() {
    if (bloc.sets > 1) {
      sets = 0;
    }
    countdownCounter = 10;
  }

  @override
  bool get isBtnActive =>
      !(isRest || isStopwatchPaused || isStopwatchStopped) &&
      !isWorkoutFinished;

  @override
  void init() {
    if (isRest) {
      stopwatch.start(bloc.rest);
      return;
    }
    stopwatch.start((bloc as ForTime).cap);
  }

  @override
  void onEnd() {
    // Only one set
    if (bloc.sets == 1) {
      fin();
      return;
    }
    // Multiple sets
    if (sets! >= bloc.sets - 1) {
      fin();
      return;
    }
    isRest = !isRest;

    if (isRest) {
      stopwatch.start(bloc.rest);
      return;
    }
    sets = sets! + 1;
    stopwatch.start((bloc as ForTime).cap);
  }

  void endWorkout() {
    stopwatch.stop();
    fin();
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

    backup[Strings.setsKey] = workout;

    return backup;
  }
}
