class FetchStoneMasterListPayload {
  bool? activeStatus;
  String? search;
  bool? reduceWeight;
  int? page;
  int? itemsPerPage;
  int? menuId;

  FetchStoneMasterListPayload(
      {this.activeStatus,
      this.search,
      this.reduceWeight,
      this.page,
      this.itemsPerPage,
      this.menuId});

  FetchStoneMasterListPayload.fromJson(Map<String, dynamic> json) {
    activeStatus = json['active_status'];
    search = json['search'];
    reduceWeight = json['reduce_weight'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['active_status'] = this.activeStatus;
    data['search'] = this.search;
    data['reduce_weight'] = this.reduceWeight;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    return data;
  }
}

class StoneMasterListData {
  int? id;
  String? stoneName;
  String? stoneCode;
  double? rate;
  double? certificateAmount;
  late bool reduceWeight;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? sNo;

  StoneMasterListData(
      {this.id,
      this.stoneName,
      this.stoneCode,
      this.rate,
      required this.reduceWeight,
      required this.isActive,
      this.certificateAmount,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.sNo});

  StoneMasterListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stoneName = json['stone_name'];
    stoneCode = json['stone_code'];
    rate = json['rate'];
    reduceWeight = json['reduce_weight'];
    isActive = json['is_active'];
    certificateAmount = json['certificate_amount'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stone_name'] = this.stoneName;
    data['stone_code'] = this.stoneCode;
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['reduce_weight'] = this.reduceWeight;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['s_no'] = this.sNo;
    return data;
  }
}

class CreateStonePayload {
  int? menuId;
  String? stoneName;
  String? stoneCode;
  double? rate;
  bool? reduceWeight;
  double? certificateAmount;

  CreateStonePayload(
      {
      this.menuId,
      this.stoneName,
      this.stoneCode,
      this.rate,
      this.reduceWeight,
      this.certificateAmount});

  CreateStonePayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    stoneName = json['stone_name'];
    stoneCode = json['stone_code'];
    rate = json['rate'];
    reduceWeight = json['reduce_weight'];
    certificateAmount = json['certificate_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['stone_name'] = this.stoneName;
    data['stone_code'] = this.stoneCode;
    data['rate'] = this.rate;
    data['reduce_weight'] = this.reduceWeight;
    data['certificate_amount'] = this.certificateAmount;
    return data;
  }
}

class StoneMasterCreateResponse {
  int? id;
  String? stoneName;
  String? stoneCode;
  bool? reduceWeight;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;

  StoneMasterCreateResponse(
      {this.id,
      this.stoneName,
      this.stoneCode,
      this.reduceWeight,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});

  StoneMasterCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stoneName = json['stone_name'];
    stoneCode = json['stone_code'];
    reduceWeight = json['reduce_weight'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['stone_name'] = this.stoneName;
    data['stone_code'] = this.stoneCode;
    data['reduce_weight'] = this.reduceWeight;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}

class UpdateStonePayload {
  int? id;
  int? menuId;
  String? stoneName;
  String? stoneCode;
  double? rate;
  bool? reduceWeight;
  double? certificateAmount;

  UpdateStonePayload(
      {this.id,
      this.menuId,
      this.stoneName,
      this.stoneCode,
      this.rate,
      this.reduceWeight,
      this.certificateAmount});

  UpdateStonePayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    stoneName = json['stone_name'];
    stoneCode = json['stone_code'];
    rate = json['rate'];
    reduceWeight = json['reduce_weight'];
    certificateAmount = json['certificate_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['stone_name'] = this.stoneName;
    data['stone_code'] = this.stoneCode;
    data['rate'] = this.rate;
    data['reduce_weight'] = this.reduceWeight;
    data['certificate_amount'] = this.certificateAmount;
    return data;
  }
}
