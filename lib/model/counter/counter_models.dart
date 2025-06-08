class FetchCounterListPayload {
  String? search;
  int? page;
  int? itemsPerPage;
  bool? activeStatus;
  int? menuId;
  String? branch;

  FetchCounterListPayload(
      {this.search,
      this.page,
      this.itemsPerPage,
      this.activeStatus,
      this.menuId,
      this.branch
      });

  FetchCounterListPayload.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
    activeStatus = json['active_status'];
    menuId = json['menu_id'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    data['active_status'] = this.activeStatus;
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    return data;
  }
}





class CounterListData {
  int? id;
  String? counterName;
  late bool isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  int? floorDetails;
  String? floorDetailsName;
  String? branchName;
  int? sNo;

  CounterListData(
      {this.id,
      this.counterName,
      required this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.floorDetails,
      this.floorDetailsName,
      this.branchName,
      this.sNo});

  CounterListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    counterName = json['counter_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    floorDetails = json['floor_details'];
    floorDetailsName = json['floor_details_name'];
    branchName = json['branch_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['counter_name'] = this.counterName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['floor_details'] = this.floorDetails;
    data['floor_details_name'] = this.floorDetailsName;
    data['branch_name'] = this.branchName;
    data['s_no'] = this.sNo;
    return data;
  }
}



class CreateCounterPayload {
  int? menuId;
  String? counterName;
  String? floordetails;
  String? branch;

  CreateCounterPayload({this.menuId, this.counterName , this.branch , this.floordetails});

  CreateCounterPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    counterName = json['counter_name'];
    counterName = json['floor_details'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['counter_name'] = this.counterName;
    data['floor_details'] = this.floordetails;
    data['branch'] = this.branch;
    return data;
  }
}




class CounterCreateResponse {
  int? id;
  String? counterName;
  bool? isActive;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;

  CounterCreateResponse(
      {this.id,
      this.counterName,
      this.isActive,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy});

  CounterCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    counterName = json['counter_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['counter_name'] = this.counterName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    return data;
  }
}


class UpdateCounterPayload {
  int? id;
  String? counterName;
  String? branch;
  String? floordetails;
  int? menuId;

  UpdateCounterPayload({this.id, this.counterName, this.menuId , this.branch , this.floordetails});

  UpdateCounterPayload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    counterName = json['counter_name'];
    counterName = json['floor_details'];
    branch = json['branch'];
    menuId = json['menu_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['counter_name'] = this.counterName;
    data['floor_details'] = this.floordetails;
    data['branch'] = this.branch;
    data['menu_id'] = this.menuId;
    return data;
  }
}


class CounterDetailsData {
  int? id;
  String? counterName;
  int? floorDetails;
  String? floorDetailsName;
  bool? isActive;
  String? createdAt;
  int? branch;
  String? branchName;

  CounterDetailsData(
      {this.id,
      this.counterName,
      this.floorDetails,
      this.floorDetailsName,
      this.isActive,
      this.createdAt,
      this.branch,
      this.branchName});

  CounterDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    counterName = json['counter_name'];
    floorDetails = json['floor_details'];
    floorDetailsName = json['floor_details_name'];
    isActive = json['is_active'];
    createdAt = json['created_at'];
    branch = json['branch'];
    branchName = json['branch_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['counter_name'] = this.counterName;
    data['floor_details'] = this.floorDetails;
    data['floor_details_name'] = this.floorDetailsName;
    data['is_active'] = this.isActive;
    data['created_at'] = this.createdAt;
    data['branch'] = this.branch;
    data['branch_name'] = this.branchName;
    return data;
  }
}

