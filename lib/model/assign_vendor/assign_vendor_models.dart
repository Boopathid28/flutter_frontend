class AssignVendorPayload {
  num? menuId;
  List<RepairItemDetails>? repairItemDetails;

  AssignVendorPayload({this.menuId, this.repairItemDetails});

  AssignVendorPayload.fromJson(Map<String, dynamic> json) {
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
  dynamic vendorDetails;
  String? dueDate;

  RepairItemDetails({this.id, this.vendorDetails, this.dueDate});

  RepairItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorDetails = json['vendor_details'];
    dueDate = json['due_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['vendor_details'] = vendorDetails;
    data['due_date'] = dueDate;
    return data;
  }
}



class AssignVendorResponse {
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
  num? repairType;
  num? itemDetails;
  num? vendorDetails;

  AssignVendorResponse(
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

  AssignVendorResponse.fromJson(Map<String, dynamic> json) {
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




class NotIssuesRepairItemTableListPayload {
  num? menuId;
  num? id;

  NotIssuesRepairItemTableListPayload({this.menuId, this.id});

  NotIssuesRepairItemTableListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['id'] = id;
    return data;
  }
}



class NotIssuesRepairItemTableList {
  num? id;
  num? grossWeight;
  num? pieces;
  dynamic issuedDate;
  dynamic receivedDate;
  dynamic dueDate;
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
  dynamic vendorDetails;
  String? repairId;
  String? customerName;
  num? sNo;

  NotIssuesRepairItemTableList(
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
      this.repairId,
      this.customerName,
      this.sNo});

  NotIssuesRepairItemTableList.fromJson(Map<String, dynamic> json) {
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
    data['repair_id'] = repairId;
    data['customer_name'] = customerName;
    data['s.no'] = sNo;
    return data;
  }
}
