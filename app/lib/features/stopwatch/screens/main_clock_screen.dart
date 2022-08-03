import 'package:fitness_app/config/index.dart';
import 'package:fitness_app/config/strings.dart';
import 'package:fitness_app/features/app_wide/providers/app_wide_provider.dart';
import 'package:fitness_app/features/main/index.dart';
import 'package:fitness_app/shared/widgets/alert/alert.dart';
import 'package:fitness_app/shared/widgets/app_bar/app_bar.dart';
import 'package:fitness_app/shared/widgets/error_page/error_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens.dart';
import '../providers/providers.dart';

class MainClockScreen extends StatelessWidget {
  static const String route = "clock";

  late final Map<Type, Widget Function()> _blocTypeSwitcher = {
    AMRAP: () => const AMRAPScreen(),
    EMOM: () => const EMOMScreen(),
    ForTime: () => const ForTimeScreen(),
    ExerciseSet: () => const SetScreen(),
    Tabata: () => const TabataScreen(),
  };
  late final Map<Type, String Function()> _titleSwitcher = {
    AMRAP: () => Strings.appBarAMRAP,
    EMOM: () => Strings.appBarEMOM,
    ForTime: () => Strings.appBarForTime,
    ExerciseSet: () => Strings.appBarSet,
    Tabata: () => Strings.appBarTabata,
  };
  late final Map<Type, StopwatchProvider Function()> _providerSwitcher = {
    AMRAP: () => StopwatchAMRAPProvider(bloc: bloc),
    EMOM: () => StopwatchEMOMProvider(bloc: bloc),
    ForTime: () => StopwatchForTimeProvider(bloc: bloc),
    ExerciseSet: () => StopwatchSetProvider(bloc: bloc),
    Tabata: () => StopwatchTabataProvider(bloc: bloc),
  };
  late final Map<Type, StopwatchProvider Function(Map<String, dynamic>)>
      _providerFromSavedWorkoutSwitcher = {
    AMRAP: (workout) => StopwatchAMRAPProvider.fromSavedWorkout(
        bloc: bloc, savedWorkout: workout),
    EMOM: (workout) => StopwatchEMOMProvider.fromSavedWorkout(
        bloc: bloc, savedWorkout: workout),
    ForTime: (workout) => StopwatchForTimeProvider.fromSavedWorkout(
        bloc: bloc, savedWorkout: workout),
    ExerciseSet: (workout) => StopwatchSetProvider.fromSavedWorkout(
        bloc: bloc, savedWorkout: workout),
    Tabata: (workout) => StopwatchTabataProvider.fromSavedWorkout(
        bloc: bloc, savedWorkout: workout),
  };

  final Bloc bloc;

  MainClockScreen({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  void _openAlert(BuildContext context) {
    PopupAlert.open(
      context: context,
      title: Strings.leavingTitle,
      desc: Strings.leavingMessage,
      buttons: [
        AlertButton(
          text: Strings.saveWorkoutButton,
          onPressed: () {
            var provider = context.read<StopwatchProvider>();

            if (!provider.isStopwatchPaused) {
              provider.playpauseStopwatch();
            }
            context.read<AppWideProvider>().saveWorkout(provider.backup());
            Navigator.popUntil(context, ModalRoute.withName(MainScreen.route));
          },
        ),
        AlertButton(
          text: Strings.leaveWorkoutButton,
          onPressed: () {
            context.read<AppWideProvider>().savedWorkout = null;
            Navigator.popUntil(context, ModalRoute.withName(MainScreen.route));
          },
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    Widget? blocType = _blocTypeSwitcher[bloc.runtimeType]?.call();
    Map<String, dynamic>? savedWorkout =
        context.read<AppWideProvider>().savedWorkout;

    if (blocType != null) {
      return ChangeNotifierProvider<StopwatchProvider>(
        create: (_) => savedWorkout != null &&
                savedWorkout[Strings.idKey] == bloc.toString()
            ? _providerFromSavedWorkoutSwitcher[bloc.runtimeType]!(
                savedWorkout[Strings.workoutBackupKey])
            : _providerSwitcher[bloc.runtimeType]!(),
        child: Scaffold(
          appBar: MyAppBar(
            title: _titleSwitcher[bloc.runtimeType]?.call() ??
                Strings.appBarUnknownType,
            leading: Consumer<StopwatchProvider>(
              builder: (newContext, provider, _) {
                return AppBarButton(
                  icon: Icons.arrow_back,
                  onPressed: () {
                    if (provider.isWorkoutStarted &&
                        !provider.isWorkoutFinished) {
                      _openAlert(newContext);
                      return;
                    }
                    if (provider.isWorkoutFinished) {
                      context.read<AppWideProvider>().savedWorkout = null;
                    }
                    Navigator.pop(newContext);
                  },
                );
              },
            ),
            trailing: Consumer<StopwatchProvider>(
              builder: (_, provider, __) {
                return AppBarButton(
                  icon: provider.isMuted ? Icons.volume_off : Icons.volume_up,
                  onPressed: provider.muteUnmute,
                );
              },
            ),
          ),
          body: blocType,
        ),
      );
    }
    return Scaffold(
      appBar: MyAppBar(
        title: Strings.appBarError,
        leading: AppBarButton(
          icon: Icons.arrow_back,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const ErrorPage(
        image: Images.stopwatch,
        title: Strings.unknownErrorHeader,
        content: Strings.unknownErrorBody,
      ),
    );
  }
}
