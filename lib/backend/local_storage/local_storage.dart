import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sysbot3/backend/local_storage/local_storage_keys.dart';
import 'package:sysbot3/model/rizz_quizz_model.dart';
import 'package:sysbot3/model/user_model.dart';

class LocalStorage {
  static SharedPreferences? _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Primary
  Future<bool> setString(String key, String value) async {
    return await _prefs?.setString(key, value) ?? false;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs?.setBool(key, value) ?? false;
  }

  Future<bool> setInt(String key, int value) async {
    return await _prefs?.setInt(key, value) ?? false;
  }

  bool getBool(String key) {
    return _prefs?.getBool(key) ?? false;
  }

  int getInt(String key) {
    return _prefs?.getInt(key) ?? 0;
  }

  bool getBoolFirstTimeTrueVal(String key) {
    return _prefs?.getBool(key) ?? true;
  }

  String getString(String key, {String defaultValue = ''}) {
    final value = _prefs?.getString(key);
    return value ?? defaultValue;
  }

  //* Values / add data to storage
  Future<bool> setUserData(UserModel? value) async {
    if (value == null) {
      return false;
    }
    final jsonValue = jsonEncode(value.toJson());
    return await setString(LocalStorageKey.userData, jsonValue);
  }

  Future<bool> setRizzQuizzData(RizzQuizzModel? value) async {
    if (value == null) {
      return false;
    }
    final jsonValue = jsonEncode(value.toJson());
    return await setString(LocalStorageKey.rizzQuizz, jsonValue);
  }

  Future<bool> setIsUserUpgrade(bool value) async {
    return await setBool(LocalStorageKey.upgradeUser, value);
  }

  Future<bool> setUserBadgesCount(int value) async {
    return await setInt(LocalStorageKey.badgesCount, value);
  }

  // _prefs?.remove(LocalStorageKey.setOtpFlowDone);

  void clearAll() {
    _prefs?.clear();
  }

  bool get getIsUserUpgrade => getBool(LocalStorageKey.upgradeUser);

  //? want free access to all features? uncommint below line and comment above line
  // bool get getIsUserUpgrade => true;

  int get getUserBadgesCount => getInt(LocalStorageKey.badgesCount);

  UserModel get getUserData {
    final data = getString(LocalStorageKey.userData);
    if (data.isEmpty) return UserModel();
    return UserModel.fromJson(jsonDecode(data));
  }

  RizzQuizzModel? get getRizzQuizzData {
    final data = getString(LocalStorageKey.rizzQuizz);
    if (data.isEmpty) return null;
    return RizzQuizzModel.fromJson(jsonDecode(data));
  }
}
