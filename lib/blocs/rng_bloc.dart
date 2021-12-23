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

  final int maxRolledNumbers = 100;

  Stream<NumberPresentation> get numberStream => _numberController.stream;

  Stream<NumberListPresentation> get numberListStream =>
      _numberListController.stream;

  generateRandomNumber() {
    NumberPresentation numberPresentation;
    if (rolledNumberList.length == maxRolledNumbers) {
      numberPresentation =
          NumberPresentation(0, message: "Todos já foram sorteados.");
      _numberController.sink.add(numberPresentation);
    } else {
      var randomNumber = Random().nextInt(maxRolledNumbers);
      var foundNumber = rolledNumberList.advancedContains(
              (NumberPresentation element) => element.rolledNumber == randomNumber);
      if (foundNumber == null) {
        numberPresentation = NumberPresentation(randomNumber);
        _numberController.sink.add(numberPresentation);
        rolledNumberList.add(numberPresentation);
        _numberListController.sink.add(NumberListPresentation(rolledNumberList));
      } else {
        generateRandomNumber();
      }
    }
  }

  @override
  void dispose() {
    _numberController.close();
  }
}

extension ListUtils on List {
  advancedContains<R>(Function(R) predicate) {
    for (var element in this) {
      if (predicate(element)) {
        return element;
      }
    }
    return null;
  }
}
