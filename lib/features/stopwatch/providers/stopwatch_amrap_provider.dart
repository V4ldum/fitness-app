import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/features/main/domain/domain.dart';
import 'package:fitness_app/features/stopwatch/index.dart';

class StopwatchAMRAPProvider extends StopwatchProvider {
  int? sets;
  int progress = 0;
  Duration? _totalElapsedSinceIncrement;
  Duration? _lastRep;

  StopwatchAMRAPProvider({required Bloc bloc}) : super(bloc) {
    _construction();
  }

  StopwatchAMRAPProvider.fromService({
    required Bloc bloc,
    required StopwatchRepository service,
  }) : super(bloc) {
    _construction();

    service = service;
  }

  StopwatchAMRAPProvider.fromSavedWorkout({
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
    _lastRep = savedWorkout[Strings.lastRepKey];
    _totalElapsedSinceIncrement = savedWorkout[Strings.totalElapsedKey];

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
      !(isStopwatchStopped || isStopwatchPaused || isRest) &&
      !isWorkoutFinished;
  String? get lastRep => _lastRep?.toString().substring(2, 7);

  @override
  void init() {
    progress = 0;
    _totalElapsedSinceIncrement = null;
    _lastRep = null;

    if (isRest) {
      stopwatch.start(bloc.rest);
      return;
    }
    stopwatch.start((bloc as AMRAP).cap);
  }

  @override
  void onEnd() {
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
    progress = 0;
    _totalElapsedSinceIncrement = null;
    _lastRep = null;
    stopwatch.start((bloc as AMRAP).cap);
  }

  void increment() {
    progress++;
    Duration tmp = elapsed;

    if (_totalElapsedSinceIncrement == null) {
      _lastRep = tmp;
      _totalElapsedSinceIncrement = tmp;
      return;
    }
    _lastRep = tmp - _totalElapsedSinceIncrement!;
    _totalElapsedSinceIncrement = tmp;
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
    workout[Strings.lastRepKey] = _lastRep;
    workout[Strings.totalElapsedKey] = _totalElapsedSinceIncrement;

    backup[Strings.workoutBackupKey] = workout;

    return backup;
  }
}
