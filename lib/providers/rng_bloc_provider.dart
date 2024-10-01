import 'package:flutter/material.dart';
import 'package:yet_another_rng/blocs/rng_bloc.dart';
import 'package:yet_another_rng/blocs/settings_bloc.dart';

class RngBlocProvider extends InheritedWidget {
  final RngBloc bloc;

  RngBlocProvider(Widget child, SettingsBloc settingsBloc, {Key? key})
      : bloc = RngBloc(settingsBloc),
        super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return this != oldWidget;
  }

  static RngBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RngBlocProvider>()!;
  }
}