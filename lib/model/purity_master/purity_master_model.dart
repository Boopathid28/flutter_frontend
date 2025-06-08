class FetchPurityMasterListPayload {
  int? menuId;
  String? metal;
  String? search;
  bool? activeStatus;
  int? page;
  int? itemsPerPage;

  FetchPurityMasterListPayload(
      {this.menuId,
      this.metal,
      this.search,
      this.activeStatus,
      this.page,
      this.itemsPerPage});

  FetchPurityMasterListPayload.fromJson(Map<String, dynamic> json) {
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

class PurityMasterListData {
  int? id;
  String? purityName;
  String? purityCode;
  double? purityPercent;
  late bool isActive;
  late bool isVisible;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? metal;
  String? metalName;
  int? sNo;

  PurityMasterListData(
      {this.id,
      this.purityName,
      this.purityCode,
      this.purityPercent,
      required this.isActive,
      required this.isVisible,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.metal,
      this.metalName,
      this.sNo});

  PurityMasterListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purityName = json['purity_name'];
    purityCode = json['purity_code'];
    purityPercent = json['purity_percent'];
    isActive = json['is_active'];
    isVisible = json['is_visible'];
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
    data['purity_name'] = this.purityName;
    data['purity_code'] = this.purityCode;
    data['purity_percent'] = this.purityPercent;
    data['is_active'] = this.isActive;
    data['is_visible'] = this.isVisible;
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

class CreatePurityPayload {
  int? menuId;
  int? metal;
  String? purityName;
  String? purityCode;
  String? purityPercent;

  CreatePurityPayload(
      {this.menuId,
      this.metal,
      this.purityName,
      this.purityCode,
      this.purityPercent});

  CreatePurityPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    metal = json['metal'];
    purityName = json['purity_name'];
    purityCode = json['purity_code'];
    purityPercent = json['purity_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['metal'] = this.metal;
    data['purity_name'] = this.purityName;
    data['purity_code'] = this.purityCode;
    data['purity_percent'] = this.purityPercent;
    return data;
  }
}


class UpdatePurityPayload {
  int? menuId;
  int? id;
  int? metal;
  String? purityName;
  String? purityCode;
  String? purityPercent;

  UpdatePurityPayload(
      {this.menuId,
      this.id,
      this.metal,
      this.purityName,
      this.purityCode,
      this.purityPercent});

  UpdatePurityPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
    metal = json['metal'];
    purityName = json['purity_name'];
    purityCode = json['purity_code'];
    purityPercent = json['purity_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    data['metal'] = this.metal;
    data['purity_name'] = this.purityName;
    data['purity_code'] = this.purityCode;
    data['purity_percent'] = this.purityPercent;
    return data;
  }
}

class PurityMasterCreateResponse {
  int? id;
  String? purityName;
  String? purityCode;
  double? purityPercent;
  bool? isActive;
  bool? isVisible;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? metal;

  PurityMasterCreateResponse(
      {this.id,
      this.purityName,
      this.purityCode,
      this.purityPercent,
      this.isActive,
      this.isVisible,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.metal});

  PurityMasterCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purityName = json['purity_name'];
    purityCode = json['purity_code'];
    purityPercent = json['purity_percent'];
    isActive = json['is_active'];
    isVisible = json['is_visible'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    metal = json['metal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['purity_name'] = this.purityName;
    data['purity_code'] = this.purityCode;
    data['purity_percent'] = this.purityPercent;
    data['is_active'] = this.isActive;
    data['is_visible'] = this.isVisible;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['metal'] = this.metal;
    return data;
  }
}
