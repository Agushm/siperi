import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage instance = LocalStorage();
  Future saveData(String key, String json) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json);
  }

  Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final datane = prefs.getString(key);
    return datane;
  }
}
