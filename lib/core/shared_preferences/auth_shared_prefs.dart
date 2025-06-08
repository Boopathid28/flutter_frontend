import 'dart:convert';

import 'package:ausales_application/model/auth_models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthSharedPrefs {

  static const String _loginData = "loginData";
  static const String _token = "token";
  static const String _sessionKey = "sessionKey";
  static const String _branch = "branch";


  static Future<LoginData?> getLoginData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await LoginData.fromJson(jsonDecode(prefs.getString(_loginData)!));
  }

  static Future<void> setLoginData(LoginData? loginData) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_loginData, jsonEncode(loginData));
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(_token) ?? "";
  }

  static Future<void> setToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_token, token);
  }

  static Future<String> getSessionKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(_sessionKey) ?? "";
  }

  static Future<void> setSessionKey(String sessionKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_sessionKey, sessionKey);
  }

  static Future<bool> getBranch() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(_branch) ?? false;
  }

  static Future<void> setBranch(bool branch) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_branch, branch);
  }
}