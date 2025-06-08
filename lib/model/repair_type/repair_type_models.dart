class GetAllRepairTypes {
  int? id;
  String? repairType;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  Null? modifiedAt;
  Null? modifiedBy;
  int? sNo;

  GetAllRepairTypes(
      {this.id,
      this.repairType,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.sNo});

  GetAllRepairTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repairType = json['repair_type'];
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
    data['repair_type'] = this.repairType;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['s.no'] = this.sNo;
    return data;
  }
}




class GetAllRepairTypesPayload {
  String? search;
  dynamic activeStatus;
  int? menuId;

  GetAllRepairTypesPayload({this.search, this.activeStatus, this.menuId});

  GetAllRepairTypesPayload.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    activeStatus = json['active_status'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['active_status'] = this.activeStatus;
    data['menu_id'] = this.menuId;
    return data;
  }
}


class CreateRepairTypePayload {
  String? repairType;
  int? menuId;

  CreateRepairTypePayload({this.repairType, this.menuId});

  CreateRepairTypePayload.fromJson(Map<String, dynamic> json) {
    repairType = json['repair_type'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['repair_type'] = this.repairType;
    data['menu_id'] = this.menuId;
    return data;
  }
  
}




class UpdateRepairTypePayload {
  String? repairType;
  int? id;
  int? menuId;

  UpdateRepairTypePayload({this.repairType, this.id, this.menuId});

  UpdateRepairTypePayload.fromJson(Map<String, dynamic> json) {
    repairType = json['repair_type'];
    id = json['id'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['repair_type'] = this.repairType;
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    return data;
  }
}


