import 'dart:convert';

import 'package:f_common_package_1/models/model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesKeys {
  static const String userInfo = 'user_info';
}

class SharedPreferencesService {
  static late SharedPreferences _instance;

  static SharedPreferences get instance => _instance;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static String? getString(String key) {
    var value = _instance.getString(key);
    return value;
  }

  static Future<bool> setString(String key, String value) async {
    var result = await _instance.setString(key, value);
    return result;
  }

  static Future<bool> remove(String key) async {
    var result = await _instance.remove(key);
    return result;
  }

  static Future<bool> saveModel(String key, Model model) async {
    String jsonString = jsonEncode(model.toJson());
    return await setString(key, jsonString);
  }

  static T? getModel<T extends Model>(
      String key, T Function(Map<String, dynamic>) fromJson) {
    String? jsonString = getString(key);
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return fromJson(jsonMap);
    }
    return null;
  }
}
