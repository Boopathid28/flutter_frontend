class UserRoleListData {
  int? id;
  String? roleName;
  late bool isActive;

  UserRoleListData({this.id, this.roleName, required this.isActive});

  UserRoleListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleName = json['role_name'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_name'] = this.roleName;
    data['is_active'] = this.isActive;
    return data;
  }
}



class UserRoleResponse {
  List<UserRoleListData>? list;

  UserRoleResponse({this.list});

  UserRoleResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <UserRoleListData>[];
      json['list'].forEach((v) {
        list!.add(new UserRoleListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class CreateUserRolePayload {
  String? roleName;
  int? menuId;

  CreateUserRolePayload({this.roleName, this.menuId});

  CreateUserRolePayload.fromJson(Map<String, dynamic> json) {
    roleName = json['role_name'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role_name'] = this.roleName;
    data['menu_id'] = this.menuId;
    return data;
  }
}



class CreateUserRoleResponse {
  int? id;
  String? roleName;
  bool? isActive;

  CreateUserRoleResponse({this.id, this.roleName, this.isActive});

  CreateUserRoleResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roleName = json['role_name'];
    isActive = json['is_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['role_name'] = this.roleName;
    data['is_active'] = this.isActive;
    return data;
  }
}



class UpdateUserRolePayload {
  int? id;
  int? menuId;
  String? roleName;

  UpdateUserRolePayload({this.id, this.menuId, this.roleName});

  UpdateUserRolePayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['role_name'] = this.roleName;
    return data;
  }
}