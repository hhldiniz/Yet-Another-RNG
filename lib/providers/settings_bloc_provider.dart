import 'package:flutter/widgets.dart';
import 'package:yet_another_rng/blocs/settings_bloc.dart';

class SettingsBlocProvider extends InheritedWidget {
  final SettingsBloc bloc;

  SettingsBlocProvider(Widget child, {super.key})
      : bloc = SettingsBloc(),
        super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return this != oldWidget;
  }

  static SettingsBlocProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SettingsBlocProvider>()!;
}
