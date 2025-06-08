class FetchItemListPayload {
  String? search;
  bool? activeStatus;
  String? metal;
  String? purity;
  int? page;
  int? itemsPerPage;
  int? menuId;

  FetchItemListPayload(
      {this.search,
      this.activeStatus,
      this.metal,
      this.purity,
      this.page,
      this.itemsPerPage,
      this.menuId});

  FetchItemListPayload.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    activeStatus = json['active_status'];
    metal = json['metal'];
    purity = json['purity'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['active_status'] = this.activeStatus;
    data['metal'] = this.metal;
    data['purity'] = this.purity;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['menu_id'] = this.menuId;
    return data;
  }
}



class ItemListData {
  int? id;
  String? itemName;
  String? itemCode;
  double? huidCharges;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? purity;
  String? purityName;
  int? metal;
  String? metalName;
  int? sNo;

  ItemListData(
      {this.id,
      this.itemName,
      this.itemCode,
      this.huidCharges,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.purity,
      this.purityName,
      this.metal,
      this.metalName,
      this.sNo});

  ItemListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    itemCode = json['item_code'];
    huidCharges = json['huid_charges'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    purity = json['purity'];
    purityName = json['purity_name'];
    metal = json['metal'];
    metalName = json['metal_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['item_code'] = this.itemCode;
    data['huid_charges'] = this.huidCharges;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['purity'] = this.purity;
    data['purity_name'] = this.purityName;
    data['metal'] = this.metal;
    data['metal_name'] = this.metalName;
    data['s_no'] = this.sNo;
    return data;
  }
}



class CreateItemPayload {
  int? menuId;
  String? itemName;
  String? itemCode;
  int? purity;
  double? huidCharges;

  CreateItemPayload(
      {this.menuId,
      this.itemName,
      this.itemCode,
      this.purity,
      this.huidCharges});

  CreateItemPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    itemName = json['item_name'];
    itemCode = json['item_code'];
    purity = json['purity'];
    huidCharges = json['huid_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['item_name'] = this.itemName;
    data['item_code'] = this.itemCode;
    data['purity'] = this.purity;
    data['huid_charges'] = this.huidCharges;
    return data;
  }
}



class ItemCreateResponse {
  int? id;
  String? itemName;
  String? itemCode;
  double? huidCharges;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? purity;

  ItemCreateResponse(
      {this.id,
      this.itemName,
      this.itemCode,
      this.huidCharges,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.purity});

  ItemCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    itemCode = json['item_code'];
    huidCharges = json['huid_charges'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    purity = json['purity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['item_code'] = this.itemCode;
    data['huid_charges'] = this.huidCharges;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['purity'] = this.purity;
    return data;
  }
}


class UpdateItemPayload {
  int? id;
  int? menuId;
  String? itemName;
  String? itemCode;
  int? purity;
  double? huidCharges;

  UpdateItemPayload(
      {this.id,
      this.menuId,
      this.itemName,
      this.itemCode,
      this.purity,
      this.huidCharges});

  UpdateItemPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    itemName = json['item_name'];
    itemCode = json['item_code'];
    purity = json['purity'];
    huidCharges = json['huid_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['item_name'] = this.itemName;
    data['item_code'] = this.itemCode;
    data['purity'] = this.purity;
    data['huid_charges'] = this.huidCharges;
    return data;
  }
}