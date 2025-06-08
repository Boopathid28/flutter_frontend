class LoginPayload {
  String username;
  String password;

  LoginPayload({
    required this.username, required this.password
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

class LoginResponse {
  LoginData? data;
  String? message;
  int? status;

  LoginResponse({this.data, this.message, this.status});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new LoginData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class LoginData {
  String? token;
  String? sessionKey;
  String? username;
  int? userId;
  bool? branch;

  LoginData({this.token, this.sessionKey, this.username, this.userId, this.branch});

  LoginData.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    sessionKey = json['session_key'];
    username = json['username'];
    userId = json['user_id'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['session_key'] = this.sessionKey;
    data['username'] = this.username;
    data['user_id'] = this.userId;
    data['branch'] = this.branch;
    return data;
  }
}

class LogoutResponse {
  String? message;
  int? status;

  LogoutResponse({this.message, this.status});

  LogoutResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
