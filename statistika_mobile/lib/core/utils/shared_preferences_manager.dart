import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static Future<void> clear() async {
    final instance = await SharedPreferences.getInstance();
    instance.clear();
  }

  static Future<bool> setUserId(String userId) async {
    final instance = await SharedPreferences.getInstance();
    return await instance.setString('userId', userId);
  }

  static Future<String?> getUserId() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('userId');
  }

  static Future<bool> setToken(String token) async {
    final instance = await SharedPreferences.getInstance();
    return await instance.setString('token', token);
  }

  static Future<String?> getToken() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString('token');
  }

  static Future<Map<String, dynamic>> getTokenAsMap() async {
    final instance = await SharedPreferences.getInstance();
    final token = instance.getString('token');
    return {'Authorization': 'Bearer $token'};
  }
}
