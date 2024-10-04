import 'package:shared_preferences/shared_preferences.dart';
import 'package:yet_another_rng/data/dao/base_dao.dart';
import 'package:yet_another_rng/data/models/settings.dart';

class SettingsDao implements BaseDao<Settings> {
  Future _save(minimum, maximum) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await Future.wait(
        [prefs.setInt("minimum", minimum), prefs.setInt("maximum", maximum)]);
  }

  @override
  delete(Settings model) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("minimum");
    prefs.remove("maximum");
  }

  @override
  insert(Settings model) {
    _save(model.minimum ?? 0, model.maximum ?? 100);
  }

  @override
  update(Settings model, Settings newModel) {
    insert(
        model.copyWith(minimum: newModel.minimum, maximum: newModel.maximum));
  }

  @override
  Future<List<Settings>> query() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var minimumValue = prefs.getInt("minimum");
    var maximumValue = prefs.getInt("maximum");
    return [Settings(minimum: minimumValue, maximum: maximumValue)];
  }
}
