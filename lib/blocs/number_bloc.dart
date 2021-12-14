import 'dart:async';
import 'dart:math';

import 'package:yet_another_rng/blocs/base_bloc.dart';
import 'package:yet_another_rng/presentations/number_presentation.dart';

class NumberBloc extends BaseBloc {
  final StreamController<NumberPresentation> _numberController =
      StreamController<NumberPresentation>();

  Stream<NumberPresentation> get numberStream => _numberController.stream;

  generateRandomNumber() {
    _numberController.sink
        .add(NumberPresentation(Random().nextInt(100).toString()));
  }

  @override
  void dispose() {
    _numberController.close();
  }
}
