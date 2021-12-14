import 'dart:async';
import 'dart:math';

import 'package:yet_another_rng/blocs/base_bloc.dart';
import 'package:yet_another_rng/presentations/number_list_presentation.dart';
import 'package:yet_another_rng/presentations/number_presentation.dart';

class RngBloc extends BaseBloc {
  final StreamController<NumberPresentation> _numberController =
      StreamController<NumberPresentation>();

  final StreamController<NumberListPresentation> _numberListController =
      StreamController<NumberListPresentation>();

  final List<NumberPresentation> rolledNumberList = [];

  Stream<NumberPresentation> get numberStream => _numberController.stream;

  Stream<NumberListPresentation> get numberListStream =>
      _numberListController.stream;

  generateRandomNumber() {
    var randomNumber = Random().nextInt(100);
    var numberText = randomNumber.toString();
    if (randomNumber < 10) {
      numberText = "0" + numberText;
    }
    var numberPresentation = NumberPresentation(numberText);
    _numberController.sink.add(numberPresentation);
    rolledNumberList.add(numberPresentation);
    _numberListController.sink.add(NumberListPresentation(rolledNumberList));
  }

  @override
  void dispose() {
    _numberController.close();
  }
}
