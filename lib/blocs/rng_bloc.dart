import 'dart:async';
import 'dart:math';

import 'package:yet_another_rng/blocs/base_bloc.dart';
import 'package:yet_another_rng/presentations/number_list_presentation.dart';
import 'package:yet_another_rng/states/rolled_number_state.dart';
import 'package:yet_another_rng/widgets/number.dart';

import '../data/dao/settings_dao.dart';

class RngBloc extends BaseBloc {

  final SettingsDao _settingsDao;

  final StreamController<RolledNumberState> _numberController =
      StreamController<RolledNumberState>();

  final StreamController<NumberListPresentation> _numberListController =
      StreamController<NumberListPresentation>();

  final List<Number> rolledNumberList = [];

  int maxRolledNumbers = 100;

  Stream<RolledNumberState> get numberStream => _numberController.stream;

  Stream<NumberListPresentation> get numberListStream =>
      _numberListController.stream;

  RngBloc(this._settingsDao) {
    _numberController.sink.add(InitState("Toque para sortear um número."));
    _settingsDao.query().then((value) {
      maxRolledNumbers = value.first.maximum ?? 100;
    },);
  }

  generateRandomNumber() {
    if (rolledNumberList.length == maxRolledNumbers) {
      _numberController.sink.add(ErrorState("Todos já foram sorteados."));
    } else {
      var randomNumber = Random().nextInt(maxRolledNumbers);
      var foundNumber = rolledNumberList.advancedContains(
          (Number element) => element.newValue == randomNumber);
      if (foundNumber == null) {
        var oldValue =
            rolledNumberList.isNotEmpty ? rolledNumberList.last.newValue : null;
        var number = Number(
          oldValue: oldValue,
          newValue: randomNumber,
        );
        _numberController.sink.add(SuccessState(number));
        rolledNumberList.add(number);
        _numberListController.sink
            .add(NumberListPresentation(rolledNumberList));
      } else {
        generateRandomNumber();
      }
    }
  }

  reset() {
    _numberController.sink.add(InitState("Toque para sortear um número."));
    rolledNumberList.clear();
    _numberListController.sink.add(NumberListPresentation(rolledNumberList));
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
