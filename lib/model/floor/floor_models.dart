class FetchFloorListPayload {
  int? menuId;
  String? search;
  String? branch;
  bool? activeStatus;
  int? page;
  int? itemsPerPage;

  FetchFloorListPayload(
      {this.menuId,
      this.search,
      this.branch,
      this.activeStatus,
      this.page,
      this.itemsPerPage});

  FetchFloorListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    search = json['search'];
    search = json['branch'];
    activeStatus = json['active_status'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['search'] = this.search;
    data['branch'] = this.branch;
    data['active_status'] = this.activeStatus;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}



class FloorListData {
  int? id;
  String? floorName;
  late bool isActive;
  String? branchName;
  int? branch;
  int? sNo;

  FloorListData(
      {this.id,
      this.floorName,
      required this.isActive,
      this.branchName,
      this.branch,
      this.sNo});

  FloorListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    floorName = json['floor_name'];
    isActive = json['is_active'];
    branchName = json['branch_name'];
    branch = json['branch'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['floor_name'] = this.floorName;
    data['is_active'] = this.isActive;
    data['branch_name'] = this.branchName;
    data['branch'] = this.branch;
    data['s_no'] = this.sNo;
    return data;
  }
}




class CreateFloorPayload {
  int? menuId;
  String? floorName;
  String? branch;

  CreateFloorPayload({this.menuId, this.floorName, this.branch});

  CreateFloorPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    floorName = json['floor_name'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['floor_name'] = this.floorName;
    data['branch'] = this.branch;
    return data;
  }
}



class FloorCreateResponse {
  int? id;
  String? floorName;
  bool? isActive;
  String? branchName;
  int? branch;

  FloorCreateResponse(
      {this.id, this.floorName, this.isActive, this.branchName, this.branch});

  FloorCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    floorName = json['floor_name'];
    isActive = json['is_active'];
    branchName = json['branch_name'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['floor_name'] = this.floorName;
    data['is_active'] = this.isActive;
    data['branch_name'] = this.branchName;
    data['branch'] = this.branch;
    return data;
  }
}



class UpdateFloorPayload {
  int? menuId;
  int? id;
  String? floorName;
  String? branch;

  UpdateFloorPayload({this.menuId, this.id, this.floorName, this.branch});

  UpdateFloorPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
    floorName = json['floor_name'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    data['floor_name'] = this.floorName;
    data['branch'] = this.branch;
    return data;
  }
}
