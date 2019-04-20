import 'package:shared_preferences/shared_preferences.dart';

class SPKeys {
  static SPKeys NUMBER = SPKeys("number", 0);
  static SPKeys ACCOUNT_NAME = SPKeys("account_name", "");
  static SPKeys JWT = SPKeys("jwt", "");
  static SPKeys SETTING_SORT = SPKeys("setting_sort", "");

  String key;
  Object defaultValue;

  SPKeys(String key, Object value) {
    this.key = key;
    this.defaultValue = value;
  }

  Future set(Object value) async {
    await SpUtlis.set(key, value);
  }

  Future reset() async {
    await SpUtlis.set(key, defaultValue);
  }

  Future<int> getInt() async {
    return await SpUtlis.get(key) as int;
  }

  Future<double> getDouble() async {
    return await SpUtlis.get(key) as double;
  }

  Future<bool> getBoolean() async {
    return await SpUtlis.get(key) as bool;
  }

  Future<List<String>> getList() async {
    return await SpUtlis.get(key) as List<String>;
  }

  Future<String> getString() async {
    return await SpUtlis.get(key) as String;
  }
}

class SpUtlis {
  static Object get(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.get(key);
  }

  static Future<bool> set(String key, Object value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (value is bool) {
      return preferences.setBool(key, value);
    } else if (value is double) {
      return preferences.setDouble(key, value);
    } else if (value is int) {
      return preferences.setInt(key, value);
    } else if (value is String) {
      return preferences.setString(key, value);
    } else if (value is List<String>) {
      return preferences.setStringList(key, value);
    }
    return false;
  }

  static Future<Set<String>> getAllKeys() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getKeys();
  }
}
