import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {


Future<void> saveUserId(String userId) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

Future<String?> getUserId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}

Future<void> saveUserName(String userName) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userName', userName);
}
Future<String?> getUserName() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userName');
}
 Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

