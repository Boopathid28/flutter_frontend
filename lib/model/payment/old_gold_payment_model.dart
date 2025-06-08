class OldPurchasePaymentPayload {
  int? menuId;
  String? customerDetails;
  String? branch;
  List<OldItemPaymentDetails>? oldItemDetails;

  OldPurchasePaymentPayload(
      {this.menuId, this.customerDetails, this.branch, this.oldItemDetails});

  OldPurchasePaymentPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    if (json['old_item_details'] != null) {
      oldItemDetails = <OldItemPaymentDetails>[];
      json['old_item_details'].forEach((v) {
        oldItemDetails!.add(new OldItemPaymentDetails.fromJson(v));
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

class OldItemPaymentDetails {
  String? id;
  String? item;
  String? oldMetal;
  String? oldMetalName;
  double? oldWeight;
  double? oldRate;
  double? oldDustWeight;
  double? oldNetWeight;
  double? grossWeight;
  double? reduceWeight;
  double? touch;
  double? gstAmount;
  double? totalAmount;

  OldItemPaymentDetails(
      {this.id,
      this.item,
      this.oldMetal,
      this.oldMetalName,
      this.oldWeight,
      this.oldRate,
      this.oldDustWeight,
      this.oldNetWeight,
      this.grossWeight,
      this.reduceWeight,
      this.touch,
      this.gstAmount,
      this.totalAmount});

  OldItemPaymentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item_name'];
    oldMetal = json['old_metal'];
    oldMetalName = json['old_metal_name'];
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
    data['item_name'] = this.item;
    data['old_metal'] = this.oldMetal;
    data['old_metal_name'] = this.oldMetalName;
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

class OldPurchasePaymentCreateResponse {
  int? id;
  String? oldGoldBillNumber;
  int? oldId;
  double? oldGoldWeight;
  int? oldGoldPieces;
  String? gstType;
  double? gstPercent;
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

  OldPurchasePaymentCreateResponse(
      {this.id,
      this.oldGoldBillNumber,
      this.oldId,
      this.oldGoldWeight,
      this.oldGoldPieces,
      this.gstType,
      this.gstPercent,
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
      this.branch});

  OldPurchasePaymentCreateResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldGoldBillNumber = json['old_gold_bill_number'];
    oldId = json['old_id'];
    oldGoldWeight = json['old_gold_weight'];
    oldGoldPieces = json['old_gold_pieces'];
    gstType = json['gst_type'];
    gstPercent = json['gst_percent'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_gold_bill_number'] = this.oldGoldBillNumber;
    data['old_id'] = this.oldId;
    data['old_gold_weight'] = this.oldGoldWeight;
    data['old_gold_pieces'] = this.oldGoldPieces;
    data['gst_type'] = this.gstType;
    data['gst_percent'] = this.gstPercent;
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
    return data;
  }
}

class OldPurchasePaymentParticularsDetails {
  String? id;
  String? oldGoldBillNo;
  String? totalAmount;

  OldPurchasePaymentParticularsDetails(
      {this.id, this.oldGoldBillNo, this.totalAmount});

  OldPurchasePaymentParticularsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldGoldBillNo = json['old_gold_bill_no'];
    totalAmount = json['total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_gold_bill_no'] = this.oldGoldBillNo;
    data['total_amount'] = this.totalAmount;
    return data;
  }
}

class OldPurchasePaymentRetrieveResponse {
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
  List<OldItemPaymentDetailsList>? oldItemDetailsList;

  OldPurchasePaymentRetrieveResponse(
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

  OldPurchasePaymentRetrieveResponse.fromJson(Map<String, dynamic> json) {
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
      oldItemDetailsList = <OldItemPaymentDetailsList>[];
      json['old_item_details_list'].forEach((v) {
        oldItemDetailsList!.add(new OldItemPaymentDetailsList.fromJson(v));
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

class OldItemPaymentDetailsList {
  int? id;
  double? oldGrossWeight;
  double? oldRate;
  double? oldDustWeight;
  double? oldNetWeight;
  double? oldAmount;
  double? gstAmount;
  double? totalAmount;
  int? oldBillDetails;
  int? oldMetal;
  String? oldMetalName;
  bool? isDb;

  OldItemPaymentDetailsList(
      {this.id,
      this.oldGrossWeight,
      this.oldRate,
      this.oldDustWeight,
      this.oldNetWeight,
      this.oldAmount,
      this.gstAmount,
      this.totalAmount,
      this.oldBillDetails,
      this.oldMetal,
      this.oldMetalName,
      this.isDb});

  OldItemPaymentDetailsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    oldGrossWeight = json['old_gross_weight'];
    oldRate = json['old_rate'];
    oldDustWeight = json['old_dust_weight'];
    oldNetWeight = json['old_net_weight'];
    oldAmount = json['old_amount'];
    gstAmount = json['gst_amount'];
    totalAmount = json['total_amount'];
    oldBillDetails = json['old_bill_details'];
    oldMetal = json['old_metal'];
    oldMetalName = json['old_metal_name'];
    isDb = json['is_db'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['old_gross_weight'] = this.oldGrossWeight;
    data['old_rate'] = this.oldRate;
    data['old_dust_weight'] = this.oldDustWeight;
    data['old_net_weight'] = this.oldNetWeight;
    data['old_amount'] = this.oldAmount;
    data['gst_amount'] = this.gstAmount;
    data['total_amount'] = this.totalAmount;
    data['old_bill_details'] = this.oldBillDetails;
    data['old_metal'] = this.oldMetal;
    data['old_metal_name'] = this.oldMetalName;
    data['is_db'] = this.isDb;
    return data;
  }
}