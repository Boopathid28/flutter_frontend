class FetchCatalogListPayload {
  int? menuId;
  String? floor;
  String? counter;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchCatalogListPayload(
      {this.menuId,
      this.floor,
      this.counter,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchCatalogListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    floor = json['floor'];
    counter = json['counter'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['floor'] = this.floor;
    data['counter'] = this.counter;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}



class CatalogListData {
  int? id;
  String? catalogNumber;
  double? catalogWeight;
  String? catalogType;
  String? catalogTypeName;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? counterDetails;
  String? counterDetailsName;
  String? floorDetailsName;
  String? branchName;
  int? sNo;

  CatalogListData(
      {this.id,
      this.catalogNumber,
      this.catalogWeight,
      this.catalogType,
      this.catalogTypeName,
      this.isActive = false,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.counterDetails,
      this.counterDetailsName,
      this.floorDetailsName,
      this.branchName,
      this.sNo});

  CatalogListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catalogNumber = json['catalog_number'].toString();
    catalogWeight = json['catalog_weight'];
    catalogType = json['catalog_type'];
    catalogTypeName = json['catalog_type_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    counterDetails = json['counter_details'];
    counterDetailsName = json['counter_details_name'];
    floorDetailsName = json['floor_details_name'];
    branchName = json['branch_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catalog_number'] = this.catalogNumber;
    data['catalog_weight'] = this.catalogWeight;
    data['catalog_type'] = this.catalogType;
    data['catalog_type_name'] = this.catalogTypeName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['counter_details'] = this.counterDetails;
    data['counter_details_name'] = this.counterDetailsName;
    data['floor_details_name'] = this.floorDetailsName;
    data['branch_name'] = this.branchName;
    data['s_no'] = this.sNo;
    return data;
  }
}


class CreateCatalogPayload {
  String? counterDetails;
  String? catalogNumber;
  String? catalogWeight;
  String? catalogType;
  int? menuId;

  CreateCatalogPayload(
      {this.counterDetails, this.catalogNumber, this.catalogWeight, this.menuId, this.catalogType});

  CreateCatalogPayload.fromJson(Map<String, dynamic> json) {
    counterDetails = json['counter_details'];
    catalogNumber = json['catalog_number'];
    catalogWeight = json['catalog_weight'];
    catalogType = json['catalog_type'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counter_details'] = this.counterDetails;
    data['catalog_number'] = this.catalogNumber;
    data['catalog_weight'] = this.catalogWeight;
    data['catalog_type'] = this.catalogType;
    data['menu_id'] = this.menuId;
    return data;
  }
}



class CreateCatalogResponse {
  int? id;
  String? boxNumber;
  double? boxWeight;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? counterDetails;

  CreateCatalogResponse(
      {this.id,
      this.boxNumber,
      this.boxWeight,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.counterDetails});

  CreateCatalogResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    boxNumber = json['box_number'];
    boxWeight = json['box_weight'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    counterDetails = json['counter_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['box_number'] = this.boxNumber;
    data['box_weight'] = this.boxWeight;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['counter_details'] = this.counterDetails;
    return data;
  }
}



class UpdateCatalogPayload {
  int? id;
  String? counterDetails;
  String? catalogNumber;
  String? catalogWeight;
  String? catalogType;
  int? menuId;

  UpdateCatalogPayload(
      {this.id,
      this.counterDetails,
      this.catalogNumber,
      this.catalogWeight,
      this.menuId,
      this.catalogType});

  UpdateCatalogPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    counterDetails = json['counter_details'];
    catalogNumber = json['catalog_number'];
    catalogWeight = json['catalog_weight'];
    catalogType = json['catalog_type'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['counter_details'] = this.counterDetails;
    data['catalog_number'] = this.catalogNumber;
    data['catalog_weight'] = this.catalogWeight;
    data['catalog_type'] = this.catalogType;
    data['menu_id'] = this.menuId;
    return data;
  }
}
