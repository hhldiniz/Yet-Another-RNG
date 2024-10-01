import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yet_another_rng/blocs/base_bloc.dart';
import 'package:yet_another_rng/models/settings.dart';

class SettingsBloc extends BaseBloc {
  final StreamController<Settings> _settings = StreamController.broadcast();

  Stream<Settings> get settings => _settings.stream;

  Settings _settingsValue = Settings();

  Future save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await Future.wait([
      prefs.setInt("minimum", _settingsValue.minimum ?? 0),
      prefs.setInt("maximum", _settingsValue.maximum ?? 100)
    ]);
  }

  _updateLocalSettings(Settings newSettings) {
    _settings.sink.add(newSettings);
    _settingsValue = newSettings;
  }

  updateMinimum(int newMinimum) {
    var changedSettings = _settingsValue.copyWith(minimum: newMinimum);
    _updateLocalSettings(changedSettings);
  }

  updateMaximum(int newMaximum) {
    var changedSettings = _settingsValue.copyWith(maximum: newMaximum);
    _updateLocalSettings(changedSettings);
  }

  loadSettings() {
    SharedPreferences.getInstance().then(
      (prefs) {
        _settings.add(_settingsValue.copyWith(
            minimum: prefs.getInt("minimum") ?? 0,
            maximum: prefs.getInt("maximum") ?? 100));
      },
    );
  }

  @override
  void dispose() {}
}
