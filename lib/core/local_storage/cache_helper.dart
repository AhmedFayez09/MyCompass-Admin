import 'package:mycompass_admin_website/core/local_storage/cach_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static const String _cachedCode = "cachedCode";
  static const String _isDarkModeKey = "isDarkMode";

  static String getCachedLanguage() {
    final code = preferences?.getString(_cachedCode);
    if (code != null) {
      return code;
    } else {
      return 'en';
    }
  }

  static Future<void> cacheLanguage(String code) async {
    await preferences?.setString(_cachedCode, code);
  }

  static bool getIsDarkMode() {
    return preferences?.getBool(_isDarkModeKey) ?? false;
  }

  static Future<void> cacheIsDarkMode(bool isDarkMode) async {
    await preferences?.setBool(_isDarkModeKey, isDarkMode);
  }

  static Future<bool?> putString(
      {required CacheKeys key, required String value}) async {
    return await preferences?.setString(key.name, value);
  }

  static String? getString({
    required CacheKeys key,
  }) {
    return preferences?.getString(
      key.name,
    ) ??
        '';
  }

  static void putBoolean(
      {required CacheKeys key, required bool value}) async {
    await preferences?.setBool(key.name, value);
  }

  static bool getBoolean({
    required bool defaultValue,
    required CacheKeys key,
  }) {
    return preferences?.getBool(
      key.name,
    ) ??
        defaultValue;
  }

  static void putInt({required CacheKeys key, required int value}) async {
    await preferences?.setInt(key.name, value);
  }

  static int getInt({
    required CacheKeys key,
  }) {
    return preferences?.getInt(
      key.name,
    ) ??
        0;
  }

  static void putDouble(
      {required CacheKeys key, required double value}) async {
    await preferences?.setDouble(key.name, value);
  }

  static double getDouble({
    required CacheKeys key,
  }) {
    return preferences?.getDouble(
      key.name,
    ) ??
        0.0;
  }

  static Future<void> removeFromShared({
    required CacheKeys key,
  }) async {
    await preferences?.remove(key.name);
  }

  static Future<void> clearShared() async {
    await preferences?.clear();
  }
}