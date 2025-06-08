import 'package:shared_preferences/shared_preferences.dart';

class HomeSharedPrefs {

  static const String _currentMenu = "currentMenu";
  static const String _branchId = "branchId";


  static Future<int?> getCurrentMenu() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getInt(_currentMenu);
  }

  static Future<String?> getBranchId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(_branchId);
  }

  static Future<void> setCurrentMenu(int id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(_currentMenu, id);
  }
  
  static Future<void> setBranchId(String id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_branchId, id);
  }
}