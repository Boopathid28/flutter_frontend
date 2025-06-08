class FetchMetalListPayload {
  int? menuId;
  bool? activeStatus;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchMetalListPayload(
      {this.menuId,
      this.activeStatus,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchMetalListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    activeStatus = json['active_status'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['active_status'] = this.activeStatus;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}




class MetalListData {
  int? id;
  String? metalName;
  String? metalCode;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? sNo;

  MetalListData(
      {this.id,
      this.metalName,
      this.metalCode,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.sNo});

  MetalListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metalName = json['metal_name'];
    metalCode = json['metal_code'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    sNo = json['s.no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metal_name'] = this.metalName;
    data['metal_code'] = this.metalCode;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['s.no'] = this.sNo;
    return data;
  }
}




class CreateMetalPayload {
  int? menuId;
  String? metalName;
  String? metalCode;

  CreateMetalPayload({this.menuId, this.metalName, this.metalCode});

  CreateMetalPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    metalName = json['metal_name'];
    metalCode = json['metal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['metal_name'] = this.metalName;
    data['metal_code'] = this.metalCode;
    return data;
  }
}



class MetalCreateResponse {
  int? id;
  String? metalName;
  String? metalCode;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;

  MetalCreateResponse(
      {this.id,
      this.metalName,
      this.metalCode,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});

  MetalCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metalName = json['metal_name'];
    metalCode = json['metal_code'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metal_name'] = this.metalName;
    data['metal_code'] = this.metalCode;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}




class UpdateMetalPayload {
  int? id;
  int? menuId;
  String? metalName;
  String? metalCode;

  UpdateMetalPayload({this.id, this.menuId, this.metalName, this.metalCode});

  UpdateMetalPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    metalName = json['metal_name'];
    metalCode = json['metal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['metal_name'] = this.metalName;
    data['metal_code'] = this.metalCode;
    return data;
  }
}