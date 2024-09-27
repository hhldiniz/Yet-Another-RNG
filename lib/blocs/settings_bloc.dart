import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yet_another_rng/blocs/base_bloc.dart';

class SettingsBloc extends BaseBloc {

  int? minimumValue;
  int? maximumValue;

  final StreamController<int> _minimum = StreamController();
  final StreamController<int> _maximum = StreamController();

  Stream<int> get minimum => _minimum.stream;
  Stream<int> get maximum => _maximum.stream;

  save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("minimum", await minimum.last);
    await prefs.setInt("maximum", await maximum.last);
  }

  updateMinimum(int newMinimum) {
    minimumValue = newMinimum;
    _minimum.sink.add(newMinimum);
  }

  updateMaximum(int newMaximum) {
    maximumValue = newMaximum;
    _maximum.sink.add(newMaximum);
  }

  loadSettings(){
    SharedPreferences.getInstance().then((prefs) {
      updateMinimum(prefs.getInt("minimum") ?? 0);
      updateMaximum(prefs.getInt("maximum") ?? 100);
    },);
  }

  @override
  void dispose() {}
}
