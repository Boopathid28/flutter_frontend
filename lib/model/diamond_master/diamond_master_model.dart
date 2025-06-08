class FetchDiamondMasterListPayload {
  bool? activeStatus;
  String? search;
  bool? reduceWeight;
  int? page;
  int? itemsPerPage;
  int? menuId;

  FetchDiamondMasterListPayload(
      {this.activeStatus,
      this.search,
      this.reduceWeight,
      this.page,
      this.itemsPerPage,
      this.menuId});

  FetchDiamondMasterListPayload.fromJson(Map<String, dynamic> json) {
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

class DiamondMasterListData {
  int? id;
  String? diamondName;
  String? diamondCode;
  double? rate;
  late bool reduceWeight;
  late bool isActive;
  double? certificateAmount;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? sNo;

  DiamondMasterListData(
      {this.id,
      this.diamondName,
      this.diamondCode,
      this.rate,
      this.certificateAmount,
      required this.reduceWeight,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.sNo});

  DiamondMasterListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diamondName = json['diamond_name'];
    diamondCode = json['diamond_code'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
    reduceWeight = json['reduce_weight'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['diamond_name'] = this.diamondName;
    data['diamond_code'] = this.diamondCode;
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

class CreateDiamondPayload {
  int? menuId;
  String? diamondName;
  String? diamondCode;
  double? rate;
  double? certificateAmount;
  bool? reduceWeight;

  CreateDiamondPayload(
      {this.menuId, this.diamondName, this.certificateAmount, this.diamondCode, this.rate, this.reduceWeight});

  CreateDiamondPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    diamondName = json['diamond_name'];
    diamondCode = json['diamond_code'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
    reduceWeight = json['reduce_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['diamond_name'] = this.diamondName;
    data['diamond_code'] = this.diamondCode;
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['reduce_weight'] = this.reduceWeight;
    return data;
  }
}

class UpdateDiamondPayload {
  int? menuId;
  String? diamondName;
  String? diamondCode;
  double? rate;
  double? certificateAmount;
  bool? reduceWeight;
  int? id;

  UpdateDiamondPayload(
      {this.menuId,
      this.diamondName,
      this.diamondCode,
      this.rate,
      this.certificateAmount,
      this.reduceWeight,
      this.id});

  UpdateDiamondPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    diamondName = json['diamond_name'];
    diamondCode = json['diamond_code'];
    rate = json['rate'];
    certificateAmount = json['certificate_amount'];
    reduceWeight = json['reduce_weight'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['diamond_name'] = this.diamondName;
    data['diamond_code'] = this.diamondCode;
    data['rate'] = this.rate;
    data['certificate_amount'] = this.certificateAmount;
    data['reduce_weight'] = this.reduceWeight;
    data['id'] = this.id;
    return data;
  }
}


class DiamondMasterCreateResponse {
  int? id;
  String? diamondName;
  String? diamondCode;
  bool? reduceWeight;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;

  DiamondMasterCreateResponse(
      {this.id,
      this.diamondName,
      this.diamondCode,
      this.reduceWeight,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});

  DiamondMasterCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diamondName = json['diamond_name'];
    diamondCode = json['diamond_code'];
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
    data['diamond_name'] = this.diamondName;
    data['diamond_code'] = this.diamondCode;
    data['reduce_weight'] = this.reduceWeight;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}
