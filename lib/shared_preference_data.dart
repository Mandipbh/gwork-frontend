import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceData {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  setUserRole(int role) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt('user_role', role);
  }

  Future<int> getUserRole() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getInt('user_role') ?? -1;
  }

  setToken(String token) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('user_token', token);
  }

  Future<String> getToken() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString('user_token') ?? '';
  }

  clearPrefs() async {
    final SharedPreferences prefs = await _prefs;
    await prefs.clear();
  }
}
