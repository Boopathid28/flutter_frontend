class UserMenuPermissionResponse {
  List<UserMenuDataList>? list;
  int? userRole;
  String? userRoleName;

  UserMenuPermissionResponse({this.list, this.userRole, this.userRoleName});

  UserMenuPermissionResponse.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <UserMenuDataList>[];
      json['list'].forEach((v) {
        list!.add(new UserMenuDataList.fromJson(v));
      });
    }
    userRole = json['user_role'];
    userRoleName = json['user_role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    data['user_role'] = this.userRole;
    data['user_role_name'] = this.userRoleName;
    return data;
  }
}

class UserMenuDataList {
  int? menuGroupId;
  String? menuGroupName;
  String? menuGroupIcon;
  String? shortcut;
  List<MenuList>? menuList;

  UserMenuDataList(
      {this.menuGroupId,
      this.menuGroupName,
      this.menuGroupIcon,
      this.shortcut,
      this.menuList});

  UserMenuDataList.fromJson(Map<String, dynamic> json) {
    menuGroupId = json['menu_group_id'];
    menuGroupName = json['menu_group_name'];
    menuGroupIcon = json['menu_group_icon'];
    shortcut = json['shortcut'];
    if (json['menu_list'] != null) {
      menuList = <MenuList>[];
      json['menu_list'].forEach((v) {
        menuList!.add(new MenuList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_group_id'] = this.menuGroupId;
    data['menu_group_name'] = this.menuGroupName;
    data['menu_group_icon'] = this.menuGroupIcon;
    data['shortcut'] = this.shortcut;
    if (this.menuList != null) {
      data['menu_list'] = this.menuList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MenuList {
  int? id;
  String? menuName;
  String? menuIcon;
  bool? modulePermit;
  bool? viewPermit;
  bool? addPermit;
  bool? editPermit;
  bool? deletePermit;
  String? shortcut;

  MenuList(
      {this.id,
      this.menuName,
      this.menuIcon,
      this.modulePermit,
      this.viewPermit,
      this.addPermit,
      this.editPermit,
      this.deletePermit,
      this.shortcut});

  MenuList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuName = json['menu_name'];
    menuIcon = json['menu_icon'];
    modulePermit = json['module_permit'];
    viewPermit = json['view_permit'];
    addPermit = json['add_permit'];
    editPermit = json['edit_permit'];
    deletePermit = json['delete_permit'];
    shortcut = json['shortcut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_name'] = this.menuName;
    data['menu_icon'] = this.menuIcon;
    data['module_permit'] = this.modulePermit;
    data['view_permit'] = this.viewPermit;
    data['add_permit'] = this.addPermit;
    data['edit_permit'] = this.editPermit;
    data['delete_permit'] = this.deletePermit;
    data['shortcut'] = this.shortcut;
    return data;
  }
}
