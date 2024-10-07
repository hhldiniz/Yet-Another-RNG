import 'package:flutter/material.dart';
import 'package:yet_another_rng/blocs/rng_bloc.dart';

import '../data/dao/settings_dao.dart';

class RngBlocProvider extends InheritedWidget {
  final RngBloc bloc;

  RngBlocProvider(Widget child, SettingsDao settingsDao, {Key? key})
      : bloc = RngBloc(settingsDao),
        super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return this != oldWidget;
  }

  static RngBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RngBlocProvider>()!;
  }
}