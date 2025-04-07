import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
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
