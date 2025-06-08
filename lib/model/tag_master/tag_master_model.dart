class FetchTagMasterListPayload {
  int? menuId;
  String? metal;
  String? search;
  bool? activeStatus;
  int? page;
  int? itemsPerPage;

  FetchTagMasterListPayload(
      {this.menuId,
      this.metal,
      this.search,
      this.activeStatus,
      this.page,
      this.itemsPerPage});

  FetchTagMasterListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    metal = json['metal'];
    search = json['search'];
    activeStatus = json['active_status'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['metal'] = this.metal;
    data['search'] = this.search;
    data['active_status'] = this.activeStatus;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}

class TagMasterListData {
  int? id;
  String? tagName;
  String? tagCode;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? metal;
  String? metalName;
  int? sNo;

  TagMasterListData(
      {this.id,
      this.tagName,
      this.tagCode,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.metal,
      this.metalName,
      this.sNo});

  TagMasterListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagName = json['tag_name'];
    tagCode = json['tag_code'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    metal = json['metal'];
    metalName = json['metal_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag_name'] = this.tagName;
    data['tag_code'] = this.tagCode;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['metal'] = this.metal;
    data['metal_name'] = this.metalName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class CreateTagPayload {
  int? metal;
  String? tagName;
  String? tagCode;
  int? menuId;

  CreateTagPayload({this.metal, this.tagName, this.tagCode, this.menuId});

  CreateTagPayload.fromJson(Map<String, dynamic> json) {
    metal = json['metal'];
    tagName = json['tag_name'];
    tagCode = json['tag_code'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['metal'] = this.metal;
    data['tag_name'] = this.tagName;
    data['tag_code'] = this.tagCode;
    data['menu_id'] = this.menuId;
    return data;
  }
}

class TagMasterCreateResponse {
  int? id;
  String? tagName;
  String? tagCode;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? metal;

  TagMasterCreateResponse(
      {this.id,
      this.tagName,
      this.tagCode,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.metal});

  TagMasterCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tagName = json['tag_name'];
    tagCode = json['tag_code'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    metal = json['metal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tag_name'] = this.tagName;
    data['tag_code'] = this.tagCode;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['metal'] = this.metal;
    return data;
  }
}

class UpdateTagPayload {
  int? id;
  int? metal;
  String? tagName;
  String? tagCode;
  int? menuId;

  UpdateTagPayload(
      {this.id, this.metal, this.tagName, this.tagCode, this.menuId});

  UpdateTagPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metal = json['metal'];
    tagName = json['tag_name'];
    tagCode = json['tag_code'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metal'] = this.metal;
    data['tag_name'] = this.tagName;
    data['tag_code'] = this.tagCode;
    data['menu_id'] = this.menuId;
    return data;
  }
}
