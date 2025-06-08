class MenuPermissionDataResponse {
  List<MenuPermissionDataModel>? list;
  bool? allPermit;
  bool? modulePermit;
  bool? viewPermit;
  bool? addPermit;
  bool? editPermit;
  bool? deletePermit;

  MenuPermissionDataResponse(
      {this.list,
      this.allPermit,
      this.modulePermit,
      this.viewPermit,
      this.addPermit,
      this.editPermit,
      this.deletePermit});

  MenuPermissionDataResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <MenuPermissionDataModel>[];
      json['list'].forEach((v) {
        list!.add(new MenuPermissionDataModel.fromJson(v));
      });
    }
    allPermit = json['all_permit'];
    modulePermit = json['module_permit'];
    viewPermit = json['view_permit'];
    addPermit = json['add_permit'];
    editPermit = json['edit_permit'];
    deletePermit = json['delete_permit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['all_permit'] = this.allPermit;
    data['module_permit'] = this.modulePermit;
    data['view_permit'] = this.viewPermit;
    data['add_permit'] = this.addPermit;
    data['edit_permit'] = this.editPermit;
    data['delete_permit'] = this.deletePermit;
    return data;
  }
}

class MenuPermissionDataModel {
  int? menu;
  String? menuName;
  int? role;
  String? roleName;
  bool? modulePermit;
  bool? viewPermit;
  bool? addPermit;
  bool? editPermit;
  bool? deletePermit;
  bool? allPermission;
  int? sNo;

  MenuPermissionDataModel(
      {this.menu,
      this.menuName,
      this.role,
      this.roleName,
      this.modulePermit,
      this.viewPermit,
      this.addPermit,
      this.editPermit,
      this.deletePermit,
      this.allPermission,
      this.sNo});

  MenuPermissionDataModel.fromJson(Map<String, dynamic> json) {
    menu = json['menu'];
    menuName = json['menu_name'];
    role = json['role'];
    roleName = json['role_name'];
    modulePermit = json['module_permit'];
    viewPermit = json['view_permit'];
    addPermit = json['add_permit'];
    editPermit = json['edit_permit'];
    deletePermit = json['delete_permit'];
    allPermission = json['all_permission'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu'] = this.menu;
    data['menu_name'] = this.menuName;
    data['role'] = this.role;
    data['role_name'] = this.roleName;
    data['module_permit'] = this.modulePermit;
    data['view_permit'] = this.viewPermit;
    data['add_permit'] = this.addPermit;
    data['edit_permit'] = this.editPermit;
    data['delete_permit'] = this.deletePermit;
    data['all_permission'] = this.allPermission;
    data['s_no'] = this.sNo;
    return data;
  }
}


class ChangeMenuPermissionPayload {
  int? menuId;
  int? menu;
  String? role;
  bool? modulePermit;
  bool? viewPermit;
  bool? addPermit;
  bool? editPermit;
  bool? deletePermit;

  ChangeMenuPermissionPayload(
      {this.menuId,
      this.menu,
      this.role,
      this.modulePermit,
      this.viewPermit,
      this.addPermit,
      this.editPermit,
      this.deletePermit});

  ChangeMenuPermissionPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    menu = json['menu'];
    role = json['role'];
    modulePermit = json['module_permit'];
    viewPermit = json['view_permit'];
    addPermit = json['add_permit'];
    editPermit = json['edit_permit'];
    deletePermit = json['delete_permit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['menu'] = this.menu;
    data['role'] = this.role;
    data['module_permit'] = this.modulePermit;
    data['view_permit'] = this.viewPermit;
    data['add_permit'] = this.addPermit;
    data['edit_permit'] = this.editPermit;
    data['delete_permit'] = this.deletePermit;
    return data;
  }
}

class MenuAllPermissionPayload {
  int? menuId;
  String? role;
  int? type;
  bool? value;

  MenuAllPermissionPayload({this.menuId, this.role, this.type, this.value});

  MenuAllPermissionPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    role = json['role'];
    type = json['type'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['role'] = this.role;
    data['type'] = this.type;
    data['value'] = this.value;
    return data;
  }
}
