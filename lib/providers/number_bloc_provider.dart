import 'package:flutter/material.dart';
import 'package:yet_another_rng/blocs/number_bloc.dart';

class NumberBlocProvider extends InheritedWidget {
  final NumberBloc bloc;

  NumberBlocProvider(Widget child, {Key? key})
      : bloc = NumberBloc(),
        super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return this != oldWidget;
  }

  static NumberBlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<NumberBlocProvider>()!;
  }
}