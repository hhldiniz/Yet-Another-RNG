import 'dart:async';

import 'package:yet_another_rng/blocs/base_bloc.dart';
import 'package:yet_another_rng/data/dao/settings_dao.dart';
import 'package:yet_another_rng/data/models/settings.dart';

class SettingsBloc extends BaseBloc {
  final SettingsDao _settingsDao = SettingsDao();

  final StreamController<Settings> _settings = StreamController.broadcast();

  Stream<Settings> get settings => _settings.stream;

  Settings _settingsValue = Settings();

  _updateLocalSettings(Settings newSettings) {
    _settingsDao.update(_settingsValue, newSettings);
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
    _settingsDao.query().then(
          (value) => _updateLocalSettings(value.first),
        );
  }

  @override
  void dispose() {}
}
