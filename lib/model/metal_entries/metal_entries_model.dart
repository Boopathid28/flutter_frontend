class MetalEntriesListData {
  int? id;
  String? entryId;
  double? touch;
  double? weight;
  bool? isCancelled;
  String? createdAt;
  String? createdBy;
  int? metalDetails;
  String? metalDetailsName;
  int? sNo;

  MetalEntriesListData(
      {this.id,
      this.entryId,
      this.touch,
      this.weight,
      this.isCancelled,
      this.createdAt,
      this.createdBy,
      this.metalDetails,
      this.metalDetailsName,
      this.sNo});

  MetalEntriesListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryId = json['entry_id'];
    touch = json['touch'];
    weight = json['weight'];
    isCancelled = json['is_cancelled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    metalDetails = json['metal_details'];
    metalDetailsName = json['metal_details_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entry_id'] = this.entryId;
    data['touch'] = this.touch;
    data['weight'] = this.weight;
    data['is_cancelled'] = this.isCancelled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['metal_details'] = this.metalDetails;
    data['metal_details_name'] = this.metalDetailsName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class FetchMetalEntriesPayload {
  int? menuId;
  String? branch;
  String? metal;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchMetalEntriesPayload(
      {this.menuId,
      this.branch,
      this.metal,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchMetalEntriesPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    metal = json['metal'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['metal'] = this.metal;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}

class CreateMetalEntriesPayload {
  int? menuId;
  String? branch;
  String? metalDetails;
  double? touch;
  double? weight;

  CreateMetalEntriesPayload(
      {this.menuId, this.branch, this.metalDetails, this.touch, this.weight});

  CreateMetalEntriesPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    metalDetails = json['metal_details'];
    touch = json['touch'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['metal_details'] = this.metalDetails;
    data['touch'] = this.touch;
    data['weight'] = this.weight;
    return data;
  }
}

class MetalEntriesCreateResponse {
  int? id;
  String? entryId;
  double? touch;
  double? weight;
  bool? isCancelled;
  String? createdAt;
  String? createdBy;
  int? metalDetails;

  MetalEntriesCreateResponse(
      {this.id,
      this.entryId,
      this.touch,
      this.weight,
      this.isCancelled,
      this.createdAt,
      this.createdBy,
      this.metalDetails});

  MetalEntriesCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryId = json['entry_id'];
    touch = json['touch'];
    weight = json['weight'];
    isCancelled = json['is_cancelled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    metalDetails = json['metal_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entry_id'] = this.entryId;
    data['touch'] = this.touch;
    data['weight'] = this.weight;
    data['is_cancelled'] = this.isCancelled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['metal_details'] = this.metalDetails;
    return data;
  }
}
