import 'dart:convert';
import 'dart:developer';
import 'package:ausales_application/core/constants/nav_controller.dart';
import 'package:ausales_application/core/shared_preferences/auth_shared_prefs.dart';
import 'package:ausales_application/view/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiCalls {
  static Future post({required String url, required Object body}) async {
    final headers = {"Content-Type": "application/json"};

    try {
      var request = await http.post(Uri.parse(url),
          body: jsonEncode(body), headers: headers);
      if (request.statusCode == 200) {
        final data = jsonDecode(request.body);
        return data;
      }
      return null;
    } catch (err) {
      return null;
    }
  }

  static Future postWithToken(
      {required String url, required Object body}) async {
    String token = await AuthSharedPrefs.getToken();
    String sessionKey = await AuthSharedPrefs.getSessionKey();

    if (token.isNotEmpty && sessionKey.isNotEmpty) {
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Token ${token}",
        "session-key": sessionKey
      };

      try {
        var request = await http.post(Uri.parse(url),
            body: jsonEncode(body), headers: headers);

        if (request.statusCode == 200) {
          final data = jsonDecode(request.body);
          return data;
        } else if (request.statusCode == 401) {
          // AuthSharedPrefs.setLoginData(null);
          // AuthSharedPrefs.setToken("");
          // AuthSharedPrefs.setSessionKey("");
          navLogin();
        }
        return null;
      } catch (err) {
        return null;
      }
    } else {
      Get.offAll(() => SplashScreen());
      AuthSharedPrefs.setLoginData(null);
      AuthSharedPrefs.setToken("");
      AuthSharedPrefs.setSessionKey("");
    }
  }

  static Future putWithToken(
      {required String url, required Object body}) async {
    String token = await AuthSharedPrefs.getToken();
    String sessionKey = await AuthSharedPrefs.getSessionKey();

    if (token.isNotEmpty && sessionKey.isNotEmpty) {
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Token ${token}",
        "session-key": sessionKey
      };
      try {
        var request = await http.put(Uri.parse(url),
            body: jsonEncode(body), headers: headers);
        if (request.statusCode == 200) {
          final data = jsonDecode(request.body);
          return data;
        } else if (request.statusCode == 401) {
          // AuthSharedPrefs.setLoginData(null);
          // AuthSharedPrefs.setToken("");
          // AuthSharedPrefs.setSessionKey("");
          navLogin();
        }
        return null;
      } catch (err) {
        return null;
      }
    } else {
      AuthSharedPrefs.setLoginData(null);
      AuthSharedPrefs.setToken("");
      AuthSharedPrefs.setSessionKey("");
      navLogin();
    }
  }

  static Future get({required String url}) async {
    final headers = {"Content-Type": "application/json"};
    try {
      var request = await http.get(Uri.parse(url), headers: headers);

      if (request.statusCode == 200) {
        final data = jsonDecode(request.body);
        return data;
      }
      return null;
    } catch (err) {
      return null;
    }
  }

  static Future getWithToken({required String url}) async {
    String token = await AuthSharedPrefs.getToken();
    String sessionKey = await AuthSharedPrefs.getSessionKey();

    if (token.isNotEmpty && sessionKey.isNotEmpty) {
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Token ${token}",
        "session-key": sessionKey
      };

      try {
        var request = await http.get(Uri.parse(url), headers: headers);
        if (request.statusCode == 200) {
          final data = jsonDecode(request.body);
          return data;
        } else if (request.statusCode == 401) {
          // AuthSharedPrefs.setLoginData(null);
          // AuthSharedPrefs.setToken("");
          // AuthSharedPrefs.setSessionKey("");
          navLogin();
        }
        return null;
      } catch (err) {
        return null;
      }

    } else {
      AuthSharedPrefs.setLoginData(null);
      AuthSharedPrefs.setToken("");
      AuthSharedPrefs.setSessionKey("");
      navLogin();
    }
  }

  static Future deleteWithToken({required String url}) async {
    String token = await AuthSharedPrefs.getToken();
    String sessionKey = await AuthSharedPrefs.getSessionKey();

    if (token.isNotEmpty && sessionKey.isNotEmpty) {
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Token ${token}",
        "session-key": sessionKey
      };
      try {
        var request = await http.delete(Uri.parse(url), headers: headers);

        if (request.statusCode == 200) {
          final data = jsonDecode(request.body);
          return data;
        } else if (request.statusCode == 401) {
          // AuthSharedPrefs.setLoginData(null);
          // AuthSharedPrefs.setToken("");
          // AuthSharedPrefs.setSessionKey("");
          navLogin();
        }
        return null;
      } catch (err) {
        return null;
      }
    } else {
      AuthSharedPrefs.setLoginData(null);
      AuthSharedPrefs.setToken("");
      AuthSharedPrefs.setSessionKey("");
      navLogin();
    }
  }


  static Future downloadFile(
      {required String url}) async {
    String token = await AuthSharedPrefs.getToken();
    String sessionKey = await AuthSharedPrefs.getSessionKey();

    if (token.isNotEmpty && sessionKey.isNotEmpty) {
      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Token ${token}",
        "session-key": sessionKey
      };

      try {
        var request = await http.get(Uri.parse(url), headers: headers);

        if (request.statusCode == 200) {
          final data = request.bodyBytes;
          return data;
        } else if (request.statusCode == 401) {
          navLogin();
        }
        return null;
      } catch (err) {
        return null;
      }
    } else {
      Get.offAll(() => SplashScreen());
      AuthSharedPrefs.setLoginData(null);
      AuthSharedPrefs.setToken("");
      AuthSharedPrefs.setSessionKey("");
    }
  }
}
