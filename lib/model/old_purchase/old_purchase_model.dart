class FetchOldPurchaseListPayload {
  int? menuId;
  String? search;
  String? customer;
  String? branch;
  bool? status;
  String? fromDate;
  String? toDate;
  int? page;
  int? itemsPerPage;

  FetchOldPurchaseListPayload(
      {this.menuId,
      this.search,
      this.customer,
      this.branch,
      this.status,
      this.fromDate,
      this.toDate,
      this.page,
      this.itemsPerPage});

  FetchOldPurchaseListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    search = json['search'];
    customer = json['customer'];
    branch = json['branch'];
    status = json['status'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    page = json['page'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['menu_id'] = this.menuId;
    data['search'] = this.search;
    data['customer'] = this.customer;
    data['branch'] = this.branch;
    data['status'] = this.status;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['page'] = this.page;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}

class FetchOldPurchaseListResponse {
  int? id;
  String? oldGoldBillNumber;
  int? oldId;
  double? oldGoldWeight;
  int? oldGoldPieces;
  double? oldGoldAmount;
  bool? isBilled;
  String? refferenceNumber;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? customerDetails;
  int? branch;
  String? customerDetailsName;
  int? sNo;

  FetchOldPurchaseListResponse(
      {this.id,
      this.oldGoldBillNumber,
      this.oldId,
      this.oldGoldWeight,
      this.oldGoldPieces,
      this.oldGoldAmount,
      this.isBilled,
      this.refferenceNumber,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.customerDetails,
      this.branch,
      this.customerDetailsName,
      this.sNo});

  FetchOldPurchaseListResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldGoldBillNumber = json['old_gold_bill_number'];
    oldId = json['old_id'];
    oldGoldWeight = json['old_gold_weight'];
    oldGoldPieces = json['old_gold_pieces'];
    oldGoldAmount = json['old_gold_amount'];
    isBilled = json['is_billed'];
    refferenceNumber = json['refference_number'];
    isCanceled = json['is_canceled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    customerDetailsName = json['customer_details_name'];
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_gold_bill_number'] = this.oldGoldBillNumber;
    data['old_id'] = this.oldId;
    data['old_gold_weight'] = this.oldGoldWeight;
    data['old_gold_pieces'] = this.oldGoldPieces;
    data['old_gold_amount'] = this.oldGoldAmount;
    data['is_billed'] = this.isBilled;
    data['refference_number'] = this.refferenceNumber;
    data['is_canceled'] = this.isCanceled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    data['customer_details_name'] = this.customerDetailsName;
    data['s_no'] = this.sNo;
    return data;
  }
}

class OldPurchasePayload {
  int? menuId;
  int? customerDetails;
  String? branch;
  List<OldItemDetails>? oldItemDetails;

  OldPurchasePayload(
      {this.menuId, this.customerDetails, this.branch, this.oldItemDetails});

  OldPurchasePayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    customerDetails = json['customer_details'];
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
    data['menu_id'] = this.menuId;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    if (this.oldItemDetails != null) {
      data['old_item_details'] =
          this.oldItemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OldItemDetails {
  String? id;
  String? oldMetal;
  String? oldMetalName;
  String? oldItemName;
  String? purityPercent;
  double? oldWeight;
  double? oldRate;
  double? oldDustWeight;
  double? oldNetWeight;
  double? grossWeight;
  double? reduceWeight;
  double? touch;
  double? gstAmount;
  double? totalAmount;

  OldItemDetails(
      {this.id,
      this.oldMetal,
      this.oldMetalName,
      this.oldItemName,
      this.purityPercent,
      this.oldWeight,
      this.oldRate,
      this.oldDustWeight,
      this.oldNetWeight,
      this.grossWeight,
      this.reduceWeight,
      this.touch,
      this.gstAmount,
      this.totalAmount});

  OldItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldMetal = json['old_metal'];
    oldMetalName = json['old_metal_name'];
    oldItemName = json['item_name'];
    purityPercent = json['purity_percentage'];
    oldWeight = json['old_weight'];
    oldRate = json['old_rate'];
    oldDustWeight = json['old_dust_weight'];
    oldNetWeight = json['old_net_weight'];
    grossWeight = json['old_gross_weight'];
    reduceWeight = json['old_reduce_weight'];
    touch = json['old_touch'];
    gstAmount = json['gst_amount'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_metal'] = this.oldMetal;
    data['old_metal_name'] = this.oldMetalName;
    data['purity_percentage'] = this.purityPercent;
    data['item_name'] = this.oldItemName;
    data['old_weight'] = this.oldWeight;
    data['old_rate'] = this.oldRate;
    data['old_dust_weight'] = this.oldDustWeight;
    data['old_net_weight'] = this.oldNetWeight;
    data['old_gross_weight'] = this.grossWeight;
    data['old_reduce_weight'] = this.reduceWeight;
    data['old_touch'] = this.touch;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class OldPurchaseRetrieveResponse {
  int? id;
  String? oldGoldBillNumber;
  int? oldId;
  double? oldGoldWeight;
  int? oldGoldPieces;
  double? totalGstAmount;
  double? oldGoldAmount;
  bool? isBilled;
  String? refferenceNumber;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  String? modifiedAt;
  String? modifiedBy;
  String? branchName;
  int? customerDetails;
  int? branch;
  String? customerDetailsName;
  String? customerDetailsMobile;
  String? customerDetailsAddress;
  List<OldItemDetailsList>? oldItemDetailsList;

  OldPurchaseRetrieveResponse(
      {this.id,
      this.oldGoldBillNumber,
      this.oldId,
      this.oldGoldWeight,
      this.oldGoldPieces,
      this.totalGstAmount,
      this.oldGoldAmount,
      this.isBilled,
      this.refferenceNumber,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.customerDetails,
      this.branch,
      this.customerDetailsName,
      this.customerDetailsMobile,
      this.customerDetailsAddress,
      this.oldItemDetailsList});

  OldPurchaseRetrieveResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldGoldBillNumber = json['old_gold_bill_number'];
    oldId = json['old_id'];
    oldGoldWeight = json['old_gold_weight'];
    oldGoldPieces = json['old_gold_pieces'];
    totalGstAmount = json['total_gst_amount'];
    oldGoldAmount = json['old_gold_amount'];
    isBilled = json['is_billed'];
    refferenceNumber = json['refference_number'];
    isCanceled = json['is_canceled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    customerDetailsName = json['customer_details_name'];
    customerDetailsMobile = json['customer_details_mobile'];
    customerDetailsAddress = json['customer_details_address'];
    if (json['old_item_details_list'] != null) {
      oldItemDetailsList = <OldItemDetailsList>[];
      json['old_item_details_list'].forEach((v) {
        oldItemDetailsList!.add(new OldItemDetailsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_gold_bill_number'] = this.oldGoldBillNumber;
    data['old_id'] = this.oldId;
    data['old_gold_weight'] = this.oldGoldWeight;
    data['old_gold_pieces'] = this.oldGoldPieces;
    data['total_gst_amount'] = this.totalGstAmount;
    data['old_gold_amount'] = this.oldGoldAmount;
    data['is_billed'] = this.isBilled;
    data['refference_number'] = this.refferenceNumber;
    data['is_canceled'] = this.isCanceled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['branch_name'] = this.branchName;
    data['customer_details'] = this.customerDetails;
    data['branch'] = this.branch;
    data['customer_details_name'] = this.customerDetailsName;
    data['customer_details_mobile'] = this.customerDetailsMobile;
    data['customer_details_address'] = this.customerDetailsAddress;
    if (this.oldItemDetailsList != null) {
      data['old_item_details_list'] =
          this.oldItemDetailsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OldItemDetailsList {
  int? id;
  String? itemName;
  double? purityPercentage;
  double? oldGrossWeight;
  double? oldPureWeight;
  double? oldRate;
  double? oldDustWeight;
  double? oldNetWeight;
  double? oldAmount;
  double? gstAmount;
  double? totalAmount;
  bool? isTransffered;
  int? oldBillDetails;
  int? oldMetal;
  String? oldMetalName;
  bool? isDb;
 
  OldItemDetailsList(
      {this.id,
      this.itemName,
      this.purityPercentage,
      this.oldGrossWeight,
      this.oldPureWeight,
      this.oldRate,
      this.oldDustWeight,
      this.oldNetWeight,
      this.oldAmount,
      this.gstAmount,
      this.totalAmount,
      this.isTransffered,
      this.oldBillDetails,
      this.oldMetal,
      this.oldMetalName,
      this.isDb});
 
  OldItemDetailsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemName = json['item_name'];
    purityPercentage = json['purity_percentage'];
    oldGrossWeight = json['old_gross_weight'];
    oldPureWeight = json['old_pure_weight'];
    oldRate = json['old_rate'];
    oldDustWeight = json['old_dust_weight'];
    oldNetWeight = json['old_net_weight'];
    oldAmount = json['old_amount'];
    gstAmount = json['gst_amount'];
    totalAmount = json['total_amount'];
    isTransffered = json['is_transffered'];
    oldBillDetails = json['old_bill_details'];
    oldMetal = json['old_metal'];
    oldMetalName = json['old_metal_name'];
    isDb = json['is_db'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['item_name'] = this.itemName;
    data['purity_percentage'] = this.purityPercentage;
    data['old_gross_weight'] = this.oldGrossWeight;
    data['old_pure_weight'] = this.oldPureWeight;
    data['old_rate'] = this.oldRate;
    data['old_dust_weight'] = this.oldDustWeight;
    data['old_net_weight'] = this.oldNetWeight;
    data['old_amount'] = this.oldAmount;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    data['is_transffered'] = this.isTransffered;
    data['old_bill_details'] = this.oldBillDetails;
    data['old_metal'] = this.oldMetal;
    data['old_metal_name'] = this.oldMetalName;
    data['is_db'] = this.isDb;
    return data;
  }
}