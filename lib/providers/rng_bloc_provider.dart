import 'package:flutter/material.dart';
import 'package:yet_another_rng/blocs/rng_bloc.dart';

class RngBlocProvider extends InheritedWidget {
  final RngBloc bloc;

  RngBlocProvider(Widget child, {Key? key})
      : bloc = RngBloc(),
        super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return this != oldWidget;
  }

  static RngBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<RngBlocProvider>()!;
  }
}