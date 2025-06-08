class FetchCustmergroupListPayload {
  int? menuId;
  String? search;
  int? page;
  int? itemsPerPage;
  bool? activeStatus;

  FetchCustmergroupListPayload(
      {this.menuId,
      this.search,
      this.page,
      this.itemsPerPage,
      this.activeStatus});

  FetchCustmergroupListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    activeStatus = json['active_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['active_status'] = this.activeStatus;
    return data;
  }
}



class CustomergroupListData {
  int? id;
  String? customerGroupName;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? sNo;

  CustomergroupListData(
      {this.id,
      this.customerGroupName,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.sNo});

  CustomergroupListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerGroupName = json['customer_group_name'];
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
    data['customer_group_name'] = this.customerGroupName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['s_no'] = this.sNo;
    return data;
  }
}


class CreateCustomerGroupPayload {
  int? menuId;
  String? customerGroupName;

  CreateCustomerGroupPayload({this.menuId, this.customerGroupName});

  CreateCustomerGroupPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    customerGroupName = json['customer_group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['customer_group_name'] = this.customerGroupName;
    return data;
  }
}



class CustomerGroupCreateResponse {
  int? id;
  String? customerGroupName;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;

  CustomerGroupCreateResponse(
      {this.id,
      this.customerGroupName,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});

  CustomerGroupCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerGroupName = json['customer_group_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_group_name'] = this.customerGroupName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}


class UpdateCustomerGroupPayload {
  int? id;
  int? menuId;
  String? customerGroupName;

  UpdateCustomerGroupPayload({this.id, this.menuId, this.customerGroupName});

  UpdateCustomerGroupPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    customerGroupName = json['customer_group_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['customer_group_name'] = this.customerGroupName;
    return data;
  }
}