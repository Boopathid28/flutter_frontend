class FetchTransferCreationListPayload {
  int? menuId;
  String? metal;
  String? status;
  String? search;
  int? page;
  int? itemsPerPage;

  FetchTransferCreationListPayload(
      {this.menuId,
      this.metal,
      this.status,
      this.search,
      this.page,
      this.itemsPerPage});

  FetchTransferCreationListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    metal = json['metal'];
    status = json['status'];
    search = json['search'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['metal'] = this.metal;
    data['status'] = this.status;
    data['search'] = this.search;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}



class TransferCreationListData {
  int? id;
  String? bagNumber;
  String? fromDate;
  String? toDate;
  int? totalItem;
  double? totalGrossWeight;
  double? totalNetWeight;
  double? totalDustWeight;
  bool? isIssued;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? metal;
  int? branch;
  String? metalName;
  int? sNo;

  TransferCreationListData(
      {this.id,
      this.bagNumber,
      this.fromDate,
      this.toDate,
      this.totalItem,
      this.totalGrossWeight,
      this.totalNetWeight,
      this.totalDustWeight,
      this.isIssued,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.metal,
      this.branch,
      this.metalName,
      this.sNo});

  TransferCreationListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bagNumber = json['bag_number'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    totalItem = json['total_item'];
    totalGrossWeight = json['total_gross_weight'];
    totalNetWeight = json['total_net_weight'];
    totalDustWeight = json['total_dust_weight'];
    isIssued = json['is_issued'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    metal = json['metal'];
    branch = json['branch'];
    metalName = json['metal_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bag_number'] = this.bagNumber;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['total_item'] = this.totalItem;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['total_net_weight'] = this.totalNetWeight;
    data['total_dust_weight'] = this.totalDustWeight;
    data['is_issued'] = this.isIssued;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['metal'] = this.metal;
    data['branch'] = this.branch;
    data['metal_name'] = this.metalName;
    data['s_no'] = this.sNo;
    return data;
  }
}




class TransferCreationDataListPayload {
  int? menuId;
  String? fromDate;
  String? toDate;
  String? metal;
  String? branch;

  TransferCreationDataListPayload(
      {this.menuId, this.fromDate, this.toDate, this.metal, this.branch});

  TransferCreationDataListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    metal = json['metal'];
    branch = json['branch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['metal'] = this.metal;
    data['branch'] = this.branch;
    return data;
  }
}




class TransferCreationDataListData {
  int? id;
  int? metalDetails;
  int? olditemDetails;
  String? metalDetailsName;
  String? refffrenceNumber;
  double? grossWeight;
  double? dustWeight;
  double? netWeight;
  String? customerName;
  String? receivedDate;

  TransferCreationDataListData(
      {this.id,
      this.metalDetails, 
      this.olditemDetails,
      this.metalDetailsName,
      this.refffrenceNumber,
      this.grossWeight,
      this.dustWeight,
      this.netWeight,
      this.customerName,
      this.receivedDate});

  TransferCreationDataListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metalDetails = json['metal_details']; 
    olditemDetails = json['old_item_details']; 
    metalDetailsName = json['metal_details_name'];
    refffrenceNumber = json['refffrence_number'];
    grossWeight = json['gross_weight'];
    dustWeight = json['dust_weight'];
    netWeight = json['net_weight'];
    customerName = json['customer_name'];
    receivedDate = json['received_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metal_details'] = this.metalDetails; 
    data['old_item_details'] = this.olditemDetails; 
    data['metal_details_name'] = this.metalDetailsName;
    data['refffrence_number'] = this.refffrenceNumber;
    data['gross_weight'] = this.grossWeight;
    data['dust_weight'] = this.dustWeight;
    data['net_weight'] = this.netWeight;
    data['customer_name'] = this.customerName;
    data['received_date'] = this.receivedDate;
    return data;
  }
}



class TransferCreationPayload {
  int? menuId;
  String? branch;
  String? fromDate;
  String? toDate;
  String? metal;
  List<String>? oldItemDetails;

  TransferCreationPayload(
      {this.menuId,
      this.branch,
      this.fromDate,
      this.toDate,
      this.metal,
      this.oldItemDetails});

  TransferCreationPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    metal = json['metal'];
    oldItemDetails = json['old_item_details'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['branch'] = this.branch;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['metal'] = this.metal;
    data['old_item_details'] = this.oldItemDetails;
    return data;
  }
}




class UpdateTransferCreationPayload {
  int? menuId;
  int? id;
  List<String>? removeItems;
  List<String>? newItems;

  UpdateTransferCreationPayload(
      {this.menuId, this.id, this.removeItems, this.newItems});

  UpdateTransferCreationPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
    removeItems = json['remove_items'].cast<String>();
    newItems = json['new_items'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['id'] = this.id;
    data['remove_items'] = this.removeItems;
    data['new_items'] = this.newItems;
    return data;
  }
}



class TransferCreationDetailsData {
  int? id;
  String? bagNumber;
  String? fromDate;
  String? toDate;
  int? totalItem;
  double? totalGrossWeight;
  double? totalNetWeight;
  double? totalDustWeight;
  bool? isIssued;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  String? metalName;
  int? metal;
  int? branch;
  List<OldItemDetails>? oldItemDetails;

  TransferCreationDetailsData(
      {this.id,
      this.bagNumber,
      this.fromDate,
      this.toDate,
      this.totalItem,
      this.totalGrossWeight,
      this.totalNetWeight,
      this.totalDustWeight,
      this.isIssued,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.metalName,
      this.metal,
      this.branch,
      this.oldItemDetails});

  TransferCreationDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bagNumber = json['bag_number'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    totalItem = json['total_item'];
    totalGrossWeight = json['total_gross_weight'];
    totalNetWeight = json['total_net_weight'];
    totalDustWeight = json['total_dust_weight'];
    isIssued = json['is_issued'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    metalName = json['metal_name'];
    metal = json['metal'];
    branch = json['branch'];
    if (json['old_item_details'] != null) {
      oldItemDetails = <OldItemDetails>[];
      json['old_item_details'].forEach((v) {
        oldItemDetails!.add(new OldItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['bag_number'] = this.bagNumber;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['total_item'] = this.totalItem;
    data['total_gross_weight'] = this.totalGrossWeight;
    data['total_net_weight'] = this.totalNetWeight;
    data['total_dust_weight'] = this.totalDustWeight;
    data['is_issued'] = this.isIssued;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['metal_name'] = this.metalName;
    data['metal'] = this.metal;
    data['branch'] = this.branch;
    if (this.oldItemDetails != null) {
      data['old_item_details'] =
          this.oldItemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OldItemDetails {
  int? id;
  int? metalDetails;
  int? olditemDetails;
  String? metalDetailsName;
  String? refffrenceNumber;
  double? dustWeight;
  double? netWeight;
  double? grossWeight;
  String? customerName;
  String? receivedDate;

  OldItemDetails(
      {this.id,
      this.metalDetails,
      this.olditemDetails,
      this.metalDetailsName,
      this.refffrenceNumber,
      this.dustWeight,
      this.netWeight,
      this.grossWeight,
      this.customerName,
      this.receivedDate});

  OldItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    metalDetails = json['metal_details'];
    olditemDetails = json['old_item_details'];
    metalDetailsName = json['metal_details_name'];
    refffrenceNumber = json['refffrence_number'].toString();
    dustWeight = json['dust_weight'];
    netWeight = json['net_weight'];
    grossWeight = json['gross_weight'];
    customerName = json['customer_name'];
    receivedDate = json['received_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['metal_details'] = this.metalDetails;
    data['old_item_details'] = this.olditemDetails;
    data['metal_details_name'] = this.metalDetailsName;
    data['refffrence_number'] = this.refffrenceNumber;
    data['dust_weight'] = this.dustWeight;
    data['net_weight'] = this.netWeight;
    data['gross_weight'] = this.netWeight;
    data['customer_name'] = this.customerName;
    data['received_date'] = this.receivedDate;
    return data;
  }
}
