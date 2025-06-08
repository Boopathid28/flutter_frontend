class CreateRepairPayload {
  int? customerDetails;
  int? menuId;
  int? branch;
  List<RepairItemDetails>? repairItemDetails;

  CreateRepairPayload(
      {this.customerDetails, this.menuId, this.branch, this.repairItemDetails});

  CreateRepairPayload.fromJson(Map<String, dynamic> json) {
    customerDetails = json['customer_details'];
    menuId = json['menu_id'];
    branch = json['branch'];
    if (json['repair_item_details'] != null) {
      repairItemDetails = <RepairItemDetails>[];
      json['repair_item_details'].forEach((v) {
        repairItemDetails!.add(RepairItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_details'] = customerDetails;
    data['menu_id'] = menuId;
    data['branch'] = branch;
    if (repairItemDetails != null) {
      data['repair_item_details'] =
          repairItemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RepairItemDetails {
  int? itemDetails;
  double? grossWeight;
  int? pieces;
  int? repairType;
  String? remarks;

  RepairItemDetails(
      {this.itemDetails,
      this.grossWeight,
      this.pieces,
      this.repairType,
      this.remarks});

  RepairItemDetails.fromJson(Map<String, dynamic> json) {
    itemDetails = json['item_details'];
    grossWeight = json['gross_weight'];
    pieces = json['pieces'];
    repairType = json['repair_type'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_details'] = itemDetails;
    data['gross_weight'] = grossWeight;
    data['pieces'] = pieces;
    data['repair_type'] = repairType;
    data['remarks'] = remarks;
    return data;
  }
}

class RepairTableListPayload {
  int? menuId;
  dynamic branch;
  dynamic customer;

  RepairTableListPayload({this.menuId, this.branch, this.customer});

  RepairTableListPayload.fromJson(Map<String, dynamic> json) {
    menuId = json['menu_id'];
    branch = json['branch'];
    customer = json['customer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['menu_id'] = menuId;
    data['branch'] = branch;
    data['customer'] = customer;
    return data;
  }
}

class RepairTableList {
  int? id;
  String? repairId;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  Null modifiedAt;
  Null modifiedBy;
  String? branchName;
  int? customerDetails;
  int? branch;
  String? customerName;
  String? totalAmount;
  String? totalPayment;
  String? balanceAmount;
  int? sNo;

  RepairTableList(
      {this.id,
      this.repairId,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.customerDetails,
      this.branch,
      this.customerName,
      this.balanceAmount,
      this.totalPayment,
      this.totalAmount,
      this.sNo});

  RepairTableList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repairId = json['repair_id'];
    isCanceled = json['is_canceled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    customerName = json['customer_name'];
    balanceAmount = json['balance_amount'].toString();
    totalPayment = json['total_payment'].toString();
    totalAmount = json['total_amount'].toString();
    sNo = json['s_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['repair_id'] = repairId;
    data['is_canceled'] = isCanceled;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['modified_at'] = modifiedAt;
    data['modified_by'] = modifiedBy;
    data['branch_name'] = branchName;
    data['customer_details'] = customerDetails;
    data['branch'] = branch;
    data['customer_name'] = customerName;
    data['total_payment'] = totalPayment;
    data['balance_amount'] = balanceAmount;
    data['total_amount'] = totalAmount;
    data['s_no'] = sNo;
    return data;
  }
}

class GetRepairById {
  int? id;
  String? repairId;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  dynamic modifiedAt;
  dynamic modifiedBy;
  String? branchName;
  int? customerDetails;
  int? branch;
  String? customerName;
  String? customerPhone;
  List<EachRepairItemDetails>? itemDetails;

  GetRepairById(
      {this.id,
      this.repairId,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.branchName,
      this.customerDetails,
      this.branch,
      this.customerName,
      this.customerPhone,
      this.itemDetails});

  GetRepairById.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repairId = json['repair_id'];
    isCanceled = json['is_canceled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    branchName = json['branch_name'];
    customerDetails = json['customer_details'];
    branch = json['branch'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    if (json['item_details'] != null) {
      itemDetails = <EachRepairItemDetails>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new EachRepairItemDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['repair_id'] = repairId;
    data['is_canceled'] = isCanceled;
    data['created_at'] = createdAt;
    data['created_by'] = createdBy;
    data['modified_at'] = modifiedAt;
    data['modified_by'] = modifiedBy;
    data['branch_name'] = branchName;
    data['customer_details'] = customerDetails;
    data['branch'] = branch;
    data['customer_name'] = customerName;
    data['customer_phone'] = customerPhone;
    if (itemDetails != null) {
      data['item_details'] = itemDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EachRepairItemDetails {
  int? id;
  double? grossWeight;
  int? pieces;
  dynamic issuedDate;
  dynamic receivedDate;
  dynamic dueDate;
  bool? isIssued;
  bool? isReceived;
  String? remarks;
  double? vendorCharges;
  double? customerCharges;
  String? createdAt;
  String? createdBy;
  dynamic modifiedAt;
  dynamic modifiedBy;
  int? repairDetails;
  String? repairType;
  int? itemDetails;
  dynamic vendorDetails;
  String? itemDetailsName;
  String? repairId;
  bool? isDb;

  EachRepairItemDetails(
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
      this.itemDetailsName,
      this.repairId,
      this.isDb});

  EachRepairItemDetails.fromJson(Map<String, dynamic> json) {
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
    itemDetailsName = json['item_details_name'];
    repairId = json['repair_id'];
    isDb = json['is_db'];
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
    data['item_details_name'] = itemDetailsName;
    data['repair_id'] = repairId;
    data['is_db'] = isDb;
    return data;
  }
}




















class RepairGetbyData {
  int? id;
  String? repairId;
  bool? isCanceled;
  String? createdAt;
  String? createdBy;
  Null? modifiedAt;
  Null? modifiedBy;
  int? customerDetails;
  String? customerName;
  String? metalName;
  String? Sno;
  String? customerAddress;
  String? customerPhone;
  List<ItemDetails>? itemDetails;
  List<PaymentDetails>? paymentDetails;
  double? totalDenominationAmount;
  double? totalCashAmount;
  double? totalCardAmount;
  double? totalBankAmount;
  double? totalUpiAmount;
  double? totalAdvanceAmount;
  double? paidAmount;
  double? balanceAmount;
  double? totalCustomerCharges;

  RepairGetbyData(
      {this.id,
      this.repairId,
      this.isCanceled,
      this.createdAt,
      this.createdBy,
      this.modifiedAt,
      this.modifiedBy,
      this.customerDetails,
      this.customerAddress,
      this.customerName,
      this.Sno,
      this.metalName,
      this.customerPhone,
      this.itemDetails,
      this.paymentDetails,
      this.totalDenominationAmount,
      this.totalCashAmount,
      this.totalCardAmount,
      this.totalBankAmount,
      this.totalUpiAmount,
      this.totalAdvanceAmount,
      this.paidAmount,
      this.balanceAmount,
      this.totalCustomerCharges});

  RepairGetbyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repairId = json['repair_id'];
    isCanceled = json['is_canceled'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    modifiedAt = json['modified_at'];
    modifiedBy = json['modified_by'];
    customerDetails = json['customer_details'];
    metalName = json['metal_name'];
    Sno = json['s_no'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    if (json['item_details'] != null) {
      itemDetails = <ItemDetails>[];
      json['item_details'].forEach((v) {
        itemDetails!.add(new ItemDetails.fromJson(v));
      });
    }
    if (json['payment_details'] != null) {
      paymentDetails = <PaymentDetails>[];
      json['payment_details'].forEach((v) {
        paymentDetails!.add(new PaymentDetails.fromJson(v));
      });
    }
    totalDenominationAmount = json['total_denomination_amount'];
    totalCashAmount = json['total_cash_amount'];
    totalCardAmount = json['total_card_amount'];
    totalBankAmount = json['total_bank_amount'];
    totalUpiAmount = json['total_upi_amount'];
    totalAdvanceAmount = json['total_advance_amount'];
    paidAmount = json['paid_amount'];
    balanceAmount = json['balance_amount'];
    totalCustomerCharges = json['total_customer_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['repair_id'] = this.repairId;
    data['is_canceled'] = this.isCanceled;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['customer_details'] = this.customerDetails;
    data['customer_name'] = this.customerName;
    data['customer_address'] = this.customerAddress;
    data['metal_name'] = this.metalName;
    data['s_no'] = this.Sno;
    data['customer_phone'] = this.customerPhone;
    if (this.itemDetails != null) {
      data['item_details'] = this.itemDetails!.map((v) => v.toJson()).toList();
    }
    if (this.paymentDetails != null) {
      data['payment_details'] =
          this.paymentDetails!.map((v) => v.toJson()).toList();
    }
    data['total_denomination_amount'] = this.totalDenominationAmount;
    data['total_cash_amount'] = this.totalCashAmount;
    data['total_card_amount'] = this.totalCardAmount;
    data['total_bank_amount'] = this.totalBankAmount;
    data['total_upi_amount'] = this.totalUpiAmount;
    data['total_advance_amount'] = this.totalAdvanceAmount;
    data['paid_amount'] = this.paidAmount;
    data['balance_amount'] = this.balanceAmount;
    data['total_customer_charges'] = this.totalCustomerCharges;
    return data;
  }
}

class ItemDetails {
  int? id;
  int? Sno;
  double? grossWeight;
  int? pieces;
  String? issuedDate;
  String? receivedDate;
  String? dueDate;
  bool? isIssued;
  bool? isReceived;
  String? remarks;
  double? vendorCharges;
  double? customerCharges;
  String? createdAt;
  String? createdBy;
  Null? modifiedAt;
  Null? modifiedBy;
  int? repairDetails;
  String? repairType;
  int? itemDetails;
  int? vendorDetails;
  String? itemDetailsName;
  String? metalName;
  String? repairId;
  bool? isDb;

  ItemDetails(
      {this.id,
      this.Sno,
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
      this.itemDetailsName,
      this.metalName,
      this.repairId,
      this.isDb});

  ItemDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    Sno = json['s_no'];
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
    itemDetailsName = json['item_details_name'];
    metalName = json['metal_name'];
    repairId = json['repair_id'];
    isDb = json['is_db'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['s_no'] = this.Sno;
    data['gross_weight'] = this.grossWeight;
    data['pieces'] = this.pieces;
    data['issued_date'] = this.issuedDate;
    data['received_date'] = this.receivedDate;
    data['due_date'] = this.dueDate;
    data['is_issued'] = this.isIssued;
    data['is_received'] = this.isReceived;
    data['remarks'] = this.remarks;
    data['vendor_charges'] = this.vendorCharges;
    data['customer_charges'] = this.customerCharges;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['modified_at'] = this.modifiedAt;
    data['modified_by'] = this.modifiedBy;
    data['repair_details'] = this.repairDetails;
    data['repair_type'] = this.repairType;
    data['item_details'] = this.itemDetails;
    data['vendor_details'] = this.vendorDetails;
    data['item_details_name'] = this.itemDetailsName;
    data['metal_name'] = this.metalName;
    data['repair_id'] = this.repairId;
    data['is_db'] = this.isDb;
    return data;
  }
}

class PaymentDetails {
  int? id;
  String? repairPaymentId;
  String? paymentDate;
  String? createdBy;
  int? repairDetails;
  List<DenominationDetails>? denominationDetails;

  PaymentDetails(
      {this.id,
      this.repairPaymentId,
      this.paymentDate,
      this.createdBy,
      this.repairDetails,
      this.denominationDetails});

  PaymentDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    repairPaymentId = json['repair_payment_id'];
    paymentDate = json['payment_date'];
    createdBy = json['created_by'];
    repairDetails = json['repair_details'];
    if (json['denomination_details'] != null) {
      denominationDetails = <DenominationDetails>[];
      json['denomination_details'].forEach((v) {
        denominationDetails!.add(new DenominationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['repair_payment_id'] = this.repairPaymentId;
    data['payment_date'] = this.paymentDate;
    data['created_by'] = this.createdBy;
    data['repair_details'] = this.repairDetails;
    if (this.denominationDetails != null) {
      data['denomination_details'] =
          this.denominationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DenominationDetails {
  int? id;
  String? paymentMethod;
  String? paymentProviders;
  double? totalAmount;
  String? remarks;
  int? repairPaymentDetails;

  DenominationDetails(
      {this.id,
      this.paymentMethod,
      this.paymentProviders,
      this.totalAmount,
      this.remarks,
      this.repairPaymentDetails});

  DenominationDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMethod = json['payment_method'];
    paymentProviders = json['payment_providers'];
    totalAmount = json['total_amount'];
    remarks = json['remarks'];
    repairPaymentDetails = json['repair_payment_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['payment_method'] = this.paymentMethod;
    data['payment_providers'] = this.paymentProviders;
    data['total_amount'] = this.totalAmount;
    data['remarks'] = this.remarks;
    data['repair_payment_details'] = this.repairPaymentDetails;
    return data;
  }
}
