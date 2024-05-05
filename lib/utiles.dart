import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveToken(String? token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('token', token!);
}

Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  return token;
}

Future<void> saveUserId(String? userid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userid!);
}

Future<String?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('userId');
  return userId;
}
