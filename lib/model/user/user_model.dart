class FetchUserListPayload {
  String? search;
  int? page;
  int? itemsPerPage;
  bool? activeStatus;
  int? menuId;
  String? branch;

  FetchUserListPayload(
      {this.search,
      this.page,
      this.itemsPerPage,
      this.activeStatus,
      this.menuId,
      this.branch});

  FetchUserListPayload.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    activeStatus = json['active_status'];
    menuId = json['menu_id'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['active_status'] = this.activeStatus;
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    return data;
  }
}

class UserListData {
  int? id;
  String? username;
  bool? isStaff;
  late bool isActive;
  late bool isLoggedin;
  String? lastLogin;
  int? sessionCount;
  int? sessionTimeout;
  late bool isAdmin;
  String? branchName;
  int? role;
  int? branch;
  String? roleName;
  int? activeSessionCount;
  int? sNo;

  UserListData(
      {this.id,
      this.username,
      this.isStaff,
      required this.isActive,
      required this.isLoggedin,
      this.lastLogin,
      this.sessionCount,
      this.sessionTimeout,
      required this.isAdmin,
      this.branchName,
      this.role,
      this.branch,
      this.roleName,
      this.activeSessionCount,
      this.sNo});

  UserListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    isStaff = json['is_staff'];
    isActive = json['is_active'];
    isLoggedin = json['is_loggedin'];
    lastLogin = json['last_login'];
    sessionCount = json['session_count'];
    sessionTimeout = json['session_timeout'];
    isAdmin = json['is_admin']??false;
    branchName = json['branch_name'];
    role = json['role'];
    branch = json['branch'];
    roleName = json['role_name'];
    activeSessionCount = json['active_session_count'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['is_staff'] = this.isStaff;
    data['is_active'] = this.isActive;
    data['is_loggedin'] = this.isLoggedin;
    data['last_login'] = this.lastLogin;
    data['session_count'] = this.sessionCount;
    data['session_timeout'] = this.sessionTimeout;
    data['is_admin'] = this.isAdmin;
    data['branch_name'] = this.branchName;
    data['role'] = this.role;
    data['branch'] = this.branch;
    data['role_name'] = this.roleName;
    data['active_session_count'] = this.activeSessionCount;
    data['s_no'] = this.sNo;
    return data;
  }
}

class UserCreateResponse {
  int? id;
  String? password;
  String? username;
  bool? isStaff;
  bool? isActive;
  bool? isLoggedin;
  String? lastLogin;
  int? sessionCount;
  int? sessionTimeout;
  bool? isAdmin;
  String? branchName;
  int? role;
  int? branch;

  UserCreateResponse(
      {this.id,
      this.password,
      this.username,
      this.isStaff,
      this.isActive,
      this.isLoggedin,
      this.lastLogin,
      this.sessionCount,
      this.sessionTimeout,
      this.isAdmin,
      this.branchName,
      this.role,
      this.branch});

  UserCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    username = json['username'];
    isStaff = json['is_staff'];
    isActive = json['is_active'];
    isLoggedin = json['is_loggedin'];
    lastLogin = json['last_login'];
    sessionCount = json['session_count'];
    sessionTimeout = json['session_timeout'];
    isAdmin = json['is_admin'];
    branchName = json['branch_name'];
    role = json['role'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['username'] = this.username;
    data['is_staff'] = this.isStaff;
    data['is_active'] = this.isActive;
    data['is_loggedin'] = this.isLoggedin;
    data['last_login'] = this.lastLogin;
    data['session_count'] = this.sessionCount;
    data['session_timeout'] = this.sessionTimeout;
    data['is_admin'] = this.isAdmin;
    data['branch_name'] = this.branchName;
    data['role'] = this.role;
    data['branch'] = this.branch;
    return data;
  }
}

class CreateUserPayload {
  String? username;
  String? password;
  int? role;
  int? menuId;
  String? branch;
  bool? isAdmin;
  String? sessionCount;
  String? sessionTimeout;

  CreateUserPayload(
      {this.username,
      this.password,
      this.role,
      this.menuId,
      this.branch,
      this.isAdmin,
      this.sessionCount,
      this.sessionTimeout});

  CreateUserPayload.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    role = json['role'];
    menuId = json['menu_id'];
    branch = json['branch'];
    isAdmin = json['is_admin'];
    sessionCount = json['session_count'];
    sessionTimeout = json['session_timeout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['role'] = this.role;
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['is_admin'] = this.isAdmin;
    data['session_count'] = this.sessionCount;
    data['session_timeout'] = this.sessionTimeout;
    return data;
  }
}

class UpdateUserPayload {
  int? id;
  String? username;
  int? role;
  int? menuId;
  String? branch;
  bool? isAdmin;
  String? sessionCount;
  String? sessionTimeout;

  UpdateUserPayload(
      {this.id,
      this.username,
      this.role,
      this.menuId,
      this.branch,
      this.isAdmin,
      this.sessionCount,
      this.sessionTimeout});

  UpdateUserPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    role = json['role'];
    menuId = json['menu_id'];
    branch = json['branch'];
    isAdmin = json['is_admin'];
    sessionCount = json['session_count'];
    sessionTimeout = json['session_timeout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['role'] = this.role;
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['is_admin'] = this.isAdmin;
    data['session_count'] = this.sessionCount;
    data['session_timeout'] = this.sessionTimeout;
    return data;
  }
}

class ChangePasswordPayload {
  int? menuId;
  int? id;
  String? password;

  ChangePasswordPayload({this.menuId, this.id, this.password});

  ChangePasswordPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    data['password'] = this.password;
    return data;
  }
}




class FetchPasswordPayload {
  int? menuId;
  int? id;
  String? password;

  FetchPasswordPayload({this.menuId, this.id, this.password});

  FetchPasswordPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    data['password'] = this.password;
    return data;
  }
}
