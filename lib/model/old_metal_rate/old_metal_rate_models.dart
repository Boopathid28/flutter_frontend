class FetchOldMetalRatePayload {
  int? menuId;
  String? metal;
  int? page;
  int? itemsPerPage;

  FetchOldMetalRatePayload(
      {this.menuId, this.metal, this.page, this.itemsPerPage});

  FetchOldMetalRatePayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    metal = json['metal'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['metal'] = this.metal;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}



class OldMetalRateListData {
  int? id;
  int? oldRate;
  int? metalDetails;
  String? metalDetailsName;
  int? sNo;

  OldMetalRateListData(
      {this.id,
      this.oldRate,
      this.metalDetails,
      this.metalDetailsName,
      this.sNo});

  OldMetalRateListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldRate = json['old_rate'];
    metalDetails = json['metal_details'];
    metalDetailsName = json['metal_details_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_rate'] = this.oldRate;
    data['metal_details'] = this.metalDetails;
    data['metal_details_name'] = this.metalDetailsName;
    data['s_no'] = this.sNo;
    return data;
  }
}

////body to create
class CreateOldMetalRatePayload {
  int? menuId;
  int? metalDetails;
  int? oldRate;

  CreateOldMetalRatePayload(
      {this.menuId, this.metalDetails, this.oldRate});

  CreateOldMetalRatePayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    metalDetails = json['metal_details'];
    oldRate = json['old_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['metal_details'] = this.metalDetails;
    data['old_rate'] = this.oldRate;
    return data;
  }
}


///response after creation
class CreateOldMetalRateResponse {
  int? id;
  int? oldRate;
  int? metalDetails;

  CreateOldMetalRateResponse({this.id, this.oldRate, this.metalDetails});

  CreateOldMetalRateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldRate = json['old_rate'];
    metalDetails = json['metal_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_rate'] = this.oldRate;
    data['metal_details'] = this.metalDetails;
    return data;
  }
}

///body to update
class UpdateOldMetalRatePayload {
  int? id;
  int? menuId;
  int? metalDetails;
  int? oldRate;

  UpdateOldMetalRatePayload(
      {this.id,this.menuId, this.metalDetails, this.oldRate});

  UpdateOldMetalRatePayload.fromJson(Map<String, dynamic> json) {
    id=json['id'];
    menuId = json['menu_id'];
    metalDetails = json['metal_details'];
    oldRate = json['old_rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id']=this.id;
    data['menu_id'] = this.menuId;
    data['metal_details'] = this.metalDetails;
    data['old_rate'] = this.oldRate;
    return data;
  }
}

////resposne after update
class UpdateOldMetalRateResponse {
  int? id;
  int? oldRate;
  int? metalDetails;

  UpdateOldMetalRateResponse({this.id, this.oldRate, this.metalDetails});

  UpdateOldMetalRateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldRate = json['old_rate'];
    metalDetails = json['metal_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_rate'] = this.oldRate;
    data['metal_details'] = this.metalDetails;
    return data;
  }
}
