import 'package:shared_preferences/shared_preferences.dart';
import 'package:yet_another_rng/blocs/base_bloc.dart';

class SettingsBloc extends BaseBloc {

  int _minimum = 0;
  int _maximum = 100;

  Future save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt("minimum", _minimum);
    await prefs.setInt("maximum", _maximum);
  }

  updateMinimum(int newMinimum) {
    _minimum = newMinimum;
  }

  updateMaximum(int newMaximum) {
    _maximum = newMaximum;
  }

  @override
  void dispose() {}
}
