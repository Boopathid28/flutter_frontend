class IssuedRepairItemPayload {
  dynamic vendor;
  num? menuId;
  num? id;

  IssuedRepairItemPayload({this.vendor, this.menuId, this.id});

  IssuedRepairItemPayload.fromJson(Map<String, dynamic> json) {
    vendor = json['vendor'];
    menuId = json['menu_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vendor'] = vendor;
    data['menu_id'] = menuId;
    data['id'] = id;
    return data;
  }
}

class ReceiveItemPayload {
  num? menuId;
  List<RepairItemDetails>? repairItemDetails;

  ReceiveItemPayload({this.menuId, this.repairItemDetails});

  ReceiveItemPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    if (json['repair_item_details'] != null) {
      repairItemDetails = <RepairItemDetails>[];
      json['repair_item_details'].forEach((v) {
        repairItemDetails!.add(RepairItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    if (repairItemDetails != null) {
      data['repair_item_details'] =
          repairItemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RepairItemDetails {
  num? id;
  num? vendorCharges;
  num? customerCharges;

  RepairItemDetails({this.id, this.vendorCharges, this.customerCharges});

  RepairItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorCharges = json['vendor_charges'];
    customerCharges = json['customer_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_charges'] = vendorCharges;
    data['customer_charges'] = customerCharges;
    return data;
  }
}




class IssuedRepairItemTableList {
  num? id;
  num? grossWeight;
  num? pieces;
  String? issuedDate;
  dynamic receivedDate;
  String? dueDate;
  bool? isIssued;
  bool? isReceived;
  String? remarks;
  num? vendorCharges;
  num? customerCharges;
  String? createdAt;
  String? createdBy;
  dynamic modifiedAt;
  dynamic modifiedBy;
  num? repairDetails;
  String? repairType;
  String? itemDetails;
  num? vendorDetails;
  String? vendorName;
  String? repairId;
  String? customerName;
  num? sNo;

  IssuedRepairItemTableList(
      {this.id,
      this.grossWeight,
      this.pieces,
      this.issuedDate,
      this.receivedDate,
      this.dueDate,
      this.isIssued,
      this.isReceived,
      this.remarks,
      this.vendorCharges,
      this.customerCharges,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.repairDetails,
      this.repairType,
      this.itemDetails,
      this.vendorDetails,
      this.vendorName,
      this.repairId,
      this.customerName,
      this.sNo});

  IssuedRepairItemTableList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossWeight = json['gross_weight'];
    pieces = json['pieces'];
    issuedDate = json['issued_date'];
    receivedDate = json['received_date'];
    dueDate = json['due_date'];
    isIssued = json['is_issued'];
    isReceived = json['is_received'];
    remarks = json['remarks'];
    vendorCharges = json['vendor_charges'];
    customerCharges = json['customer_charges'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    repairDetails = json['repair_details'];
    repairType = json['repair_type'];
    itemDetails = json['item_details'];
    vendorDetails = json['vendor_details'];
    vendorName = json['vendor_name'];
    repairId = json['repair_id'];
    customerName = json['customer_name'];
    sNo = json['s.no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gross_weight'] = grossWeight;
    data['pieces'] = pieces;
    data['issued_date'] = issuedDate;
    data['received_date'] = receivedDate;
    data['due_date'] = dueDate;
    data['is_issued'] = isIssued;
    data['is_received'] = isReceived;
    data['remarks'] = remarks;
    data['vendor_charges'] = vendorCharges;
    data['customer_charges'] = customerCharges;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['modified_at'] = modifiedAt;
    data['modified_by'] = modifiedBy;
    data['repair_details'] = repairDetails;
    data['repair_type'] = repairType;
    data['item_details'] = itemDetails;
    data['vendor_details'] = vendorDetails;
    data['vendor_name'] = vendorName;
    data['repair_id'] = repairId;
    data['customer_name'] = customerName;
    data['s.no'] = sNo;
    return data;
  }
}




class ReceiveItemResponse {
  num? id;
  num? grossWeight;
  num? pieces;
  String? issuedDate;
  String? receivedDate;
  String? dueDate;
  bool? isIssued;
  bool? isReceived;
  String? remarks;
  num? vendorCharges;
  num? customerCharges;
  String? createdAt;
  String? createdBy;
  dynamic modifiedAt;
  dynamic modifiedBy;
  num? repairDetails;
  num? repairType;
  num? itemDetails;
  num? vendorDetails;

  ReceiveItemResponse(
      {this.id,
      this.grossWeight,
      this.pieces,
      this.issuedDate,
      this.receivedDate,
      this.dueDate,
      this.isIssued,
      this.isReceived,
      this.remarks,
      this.vendorCharges,
      this.customerCharges,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.repairDetails,
      this.repairType,
      this.itemDetails,
      this.vendorDetails});

  ReceiveItemResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    grossWeight = json['gross_weight'];
    pieces = json['pieces'];
    issuedDate = json['issued_date'];
    receivedDate = json['received_date'];
    dueDate = json['due_date'];
    isIssued = json['is_issued'];
    isReceived = json['is_received'];
    remarks = json['remarks'];
    vendorCharges = json['vendor_charges'];
    customerCharges = json['customer_charges'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    repairDetails = json['repair_details'];
    repairType = json['repair_type'];
    itemDetails = json['item_details'];
    vendorDetails = json['vendor_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['gross_weight'] = grossWeight;
    data['pieces'] = pieces;
    data['issued_date'] = issuedDate;
    data['received_date'] = receivedDate;
    data['due_date'] = dueDate;
    data['is_issued'] = isIssued;
    data['is_received'] = isReceived;
    data['remarks'] = remarks;
    data['vendor_charges'] = vendorCharges;
    data['customer_charges'] = customerCharges;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['modified_at'] = modifiedAt;
    data['modified_by'] = modifiedBy;
    data['repair_details'] = repairDetails;
    data['repair_type'] = repairType;
    data['item_details'] = itemDetails;
    data['vendor_details'] = vendorDetails;
    return data;
  }
}
