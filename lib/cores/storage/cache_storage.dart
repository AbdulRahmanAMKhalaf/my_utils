import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_utils/cores/failure/failure.dart';
import 'package:flutter/foundation.dart';

class CacheHelper {
  final SharedPreferences preferences;
  CacheHelper({required this.preferences});

  Future<void> setData(String key, dynamic value) async {
    if (value is String) {
      if (kDebugMode) {
        debugPrint('[CacheHelper] setData: key=$key, value=$value');
      }
      await preferences.setString(key, value);
    } else if (value is int) {
      if (kDebugMode) {
        debugPrint('[CacheHelper] setData: key=$key, value=$value');
      }
      await preferences.setInt(key, value);
    } else if (value is double) {
      if (kDebugMode) {
        debugPrint('[CacheHelper] setData: key=$key, value=$value');
      }
      await preferences.setDouble(key, value);
    } else if (value is bool) {
      if (kDebugMode) {
        debugPrint('[CacheHelper] setData: key=$key, value=$value');
      }
      await preferences.setBool(key, value);
    } else if (value is List<String>) {
      if (kDebugMode) {
        debugPrint('[CacheHelper] setData: key=$key, value=$value');
      }
      await preferences.setStringList(key, value);
    } else {
      if (kDebugMode) {
        debugPrint(
          '[CacheHelper] setData: Unsupported type: ${value.runtimeType}',
        );
      }
      throw CacheFailure('Unsupported type: ${value.runtimeType}');
    }
  }

  // ✅ Fixed typo + added default parameter
  int getIntegerData(String key, [int defaultValue = 0]) {
    if (kDebugMode) {
      debugPrint('[CacheHelper] getIntegerData: key=$key');
    }
    return preferences.getInt(key) ?? defaultValue;
  }

  String getStringData(String key, [String defaultValue = '']) {
    if (kDebugMode) {
      debugPrint('[CacheHelper] getStringData: key=$key');
    }
    return preferences.getString(key) ?? defaultValue;
  }

  bool getBoolData(String key, [bool defaultValue = false]) {
    if (kDebugMode) {
      debugPrint('[CacheHelper] getBoolData: key=$key');
    }
    return preferences.getBool(key) ?? defaultValue;
  }

  double getDoubleData(String key, [double defaultValue = 0.0]) {
    if (kDebugMode) {
      debugPrint('[CacheHelper] getDoubleData: key=$key');
    }
    return preferences.getDouble(key) ?? defaultValue;
  }

  // // ✅ For JSON objects (example)
  // Future<void> setJsonObject<T>(
  //   String key,
  //   T object,
  //   String Function(T) toJson,
  // ) async {
  //   await preferences.setString(key, toJson(object));
  // }

  // T? getJsonObject<T>(String key, T? Function(String) fromJson) {
  //   final jsonString = preferences.getString(key);
  //   return jsonString != null ? fromJson(jsonString) : null;
  // }

  List<String> getListStringData(String key) {
    if (kDebugMode) {
      debugPrint('[CacheHelper] getListStringData: key=$key');
    }
    return preferences.getStringList(key) ?? [];
  }

  Future<bool> clearData() async {
    if (kDebugMode) {
      debugPrint('[CacheHelper] clearData');
    }
    return await preferences.clear();
  }

  bool isContainKey(String key) {
    if (kDebugMode) {
      debugPrint('[CacheHelper] isContainKey: key=$key');
    }
    return preferences.containsKey(key);
  }

  Future<bool> deleteKey(String key) async {
    if (kDebugMode) {
      debugPrint('[CacheHelper] deleteKey: key=$key');
    }
    return await preferences.remove(key);
  }
}
