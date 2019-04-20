import 'package:flutter/cupertino.dart';
import 'package:flutter_app/generated/i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPKeys {
  static SPKeys NUMBER = SPKeys("number", 0);
  static SPKeys ACCOUNT_NAME = SPKeys("account_name", "");
  static SPKeys JWT = SPKeys("jwt", "");
  static SPKeys SETTING_SORT = SPKeys("setting_sort", 0);
  static SPKeys SETTING_FONT_SIZE = SPKeys("setting_font_size", 0);

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
    var result = await SpUtlis.get(key) as int;
    if (result == null) {
      return defaultValue;
    }
    return result;
  }

  Future<double> getDouble() async {
    var result = await SpUtlis.get(key) as double;
    if (result == null) {
      return defaultValue;
    }
    return result;
  }

  Future<bool> getBoolean() async {
    var result = await SpUtlis.get(key) as bool;
    if (result == null) {
      return defaultValue;
    }
    return result;
  }

  Future<List<String>> getList() async {
    var result = await SpUtlis.get(key) as List<String>;
    if (result == null) {
      return defaultValue;
    }
    return result;
  }

  Future<String> getString() async {
    var result = await SpUtlis.get(key) as String;
    if (result == null) {
      return defaultValue;
    }
    return result;
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
