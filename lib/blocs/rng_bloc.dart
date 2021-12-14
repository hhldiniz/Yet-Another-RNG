import 'dart:async';
import 'dart:math';

import 'package:yet_another_rng/blocs/base_bloc.dart';
import 'package:yet_another_rng/presentations/number_presentation.dart';

class RngBloc extends BaseBloc {
  final StreamController<NumberPresentation> _numberController =
      StreamController<NumberPresentation>();

  Stream<NumberPresentation> get numberStream => _numberController.stream;

  generateRandomNumber() {
    var randomNumber = Random().nextInt(100);
    var numberText = randomNumber.toString();
    if(randomNumber < 10) {
      numberText = "0" + numberText;
    }
    _numberController.sink
        .add(NumberPresentation(numberText));
  }

  @override
  void dispose() {
    _numberController.close();
  }
}
